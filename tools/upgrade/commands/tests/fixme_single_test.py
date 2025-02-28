# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

import unittest
from pathlib import Path
from unittest.mock import MagicMock, mock_open, patch

from ... import upgrade
from ...errors import Errors
from ...repository import Repository
from .. import fixme_single
from ..command import ErrorSuppressingCommand
from ..fixme_single import Configuration, FixmeSingle


repository = Repository()


class FixmeSingleTest(unittest.TestCase):
    @patch("subprocess.run")
    @patch.object(Configuration, "find_project_configuration", return_value=Path("/"))
    @patch.object(Configuration, "write")
    @patch.object(Configuration, "remove_version")
    @patch.object(Configuration, "get_errors")
    @patch.object(ErrorSuppressingCommand, "_apply_suppressions")
    @patch(f"{fixme_single.__name__}.add_local_mode")
    # pyre-fixme[56]: Pyre was not able to infer the type of argument
    #  `f"{tools.pyre.tools.upgrade.upgrade.__name__}"".Repository.commit_changes"` to
    #  decorator factory `unittest.mock.patch`.
    @patch(f"{upgrade.__name__}.Repository.commit_changes")
    def test_run_fixme_single(
        self,
        commit_changes: MagicMock,
        add_local_mode: MagicMock,
        apply_suppressions: MagicMock,
        get_errors: MagicMock,
        remove_version: MagicMock,
        configuration_write: MagicMock,
        find_configuration: MagicMock,
        subprocess: MagicMock,
    ) -> None:
        arguments = MagicMock()
        arguments.path = Path("/local")
        arguments.error_source = "generate"
        arguments.lint = False
        arguments.no_commit = False
        arguments.fixme_threshold = 0
        get_errors.return_value = Errors([])
        configuration_contents = '{"targets":[]}'
        with patch("builtins.open", mock_open(read_data=configuration_contents)):
            FixmeSingle.from_arguments(arguments, repository).run()
            apply_suppressions.assert_not_called()
            commit_changes.assert_called_once_with(
                commit=True, title="Update pyre version for local"
            )

        commit_changes.reset_mock()
        configuration_contents = '{"version": 123}'
        with patch("builtins.open", mock_open(read_data=configuration_contents)):
            FixmeSingle.from_arguments(arguments, repository).run()
            apply_suppressions.assert_not_called()
            add_local_mode.assert_not_called()
            commit_changes.assert_called_once_with(
                commit=True, title="Update pyre version for local"
            )

        apply_suppressions.reset_mock()
        commit_changes.reset_mock()
        pyre_errors = [
            {
                "line": 2,
                "column": 4,
                "path": "local.py",
                "code": 7,
                "name": "Kind",
                "concise_description": "Error",
                "ignore_error": False,
                "external_to_global_root": False,
            }
        ]
        get_errors.return_value = Errors(pyre_errors)
        with patch("builtins.open", mock_open(read_data=configuration_contents)):
            FixmeSingle.from_arguments(arguments, repository).run()
            apply_suppressions.assert_called_once_with(Errors(pyre_errors))
            add_local_mode.assert_not_called()
            commit_changes.assert_called_once_with(
                commit=True, title="Update pyre version for local"
            )

        apply_suppressions.reset_mock()
        commit_changes.reset_mock()
        arguments.fixme_threshold = 1
        pyre_errors = [
            {
                "line": 2,
                "column": 4,
                "path": "local.py",
                "code": 7,
                "name": "Kind",
                "concise_description": "Error",
                "ignore_error": False,
                "external_to_global_root": False,
            },
            {
                "line": 3,
                "column": 4,
                "path": "local.py",
                "code": 7,
                "name": "Kind",
                "concise_description": "Error",
                "ignore_error": False,
                "external_to_global_root": False,
            },
        ]
        get_errors.return_value = Errors(pyre_errors)
        with patch("builtins.open", mock_open(read_data=configuration_contents)):
            FixmeSingle.from_arguments(arguments, repository).run()
            apply_suppressions.assert_not_called()
            add_local_mode.assert_called_once()
            commit_changes.assert_called_once_with(
                commit=True, title="Update pyre version for local"
            )
