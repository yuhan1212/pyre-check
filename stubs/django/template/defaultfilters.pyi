# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

# pyre-unsafe

from typing import Any

def date(value, arg: Any = ...) -> Any: ...
def escapejs(value: str) -> str: ...
def linebreaks(value: str, autoescape: bool = ...) -> str: ...
def slugify(value: str) -> str: ...