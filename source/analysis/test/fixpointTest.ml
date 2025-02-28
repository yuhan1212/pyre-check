(*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

open Core
open OUnit2
open Ast
open Analysis
open Statement
open Test

module CountingState : sig
  type t = int

  include Fixpoint.State with type t := t
end = struct
  type t = int [@@deriving show]

  let less_or_equal ~left ~right = left <= right

  let forward ~key:_ state ~statement =
    match statement with
    | { Node.value = Statement.Pass; _ } -> state + 1
    | _ -> state


  let backward ~key:_ state ~statement =
    match statement with
    | { Node.value = Statement.Pass; _ } -> state + 1
    | _ -> state


  let join left right = Int.max left right

  let widening_threshold = 10

  let widen ~previous ~next ~iteration =
    if iteration > widening_threshold then
      Int.max_value
    else
      join previous next
end

module CountingFixpoint = Fixpoint.Make (CountingState)

let assert_fixpoint body expected =
  let define =
    {
      Define.signature =
        {
          name = + !&"foo";
          parameters = [];
          decorators = [];
          return_annotation = None;
          async = false;
          generator = false;
          parent = None;
          nesting_define = None;
        };
      captures = [];
      unbound_names = [];
      body;
    }
  in
  assert_equal
    ~cmp:(CountingFixpoint.equal ~f:Int.equal)
    ~printer:(fun fixpoint -> Format.asprintf "%a" CountingFixpoint.pp fixpoint)
    ~pp_diff:(diff ~print:CountingFixpoint.pp)
    expected
    (CountingFixpoint.forward ~cfg:(Cfg.create define) ~initial:0)


let test_forward _ =
  assert_fixpoint
    [+Statement.Pass]
    (Int.Table.of_alist_exn [0, 0; (* Entry *) 1, 1; (* Exit *) 3, 1; (* Final *) 5, 0 (* Pass *)]);
  assert_fixpoint
    [+Statement.Pass; +Statement.Expression !"ignored"]
    (Int.Table.of_alist_exn [0, 0; 1, 1; 3, 1; 5, 0]);
  assert_fixpoint
    [+Statement.Pass; +Statement.Pass]
    (Int.Table.of_alist_exn [0, 0; 1, 2; 3, 2; 5, 0]);
  assert_fixpoint
    [+Statement.Pass; +Statement.Pass; +Statement.Expression !"ignored"; +Statement.Pass]
    (Int.Table.of_alist_exn [0, 0; 1, 3; 3, 3; 5, 0])


let test_join _ =
  let open Expression in
  assert_fixpoint
    [
      +Statement.If
         {
           If.test = +Expression.Constant Constant.True;
           body = [+Statement.Pass];
           orelse = [+Statement.Pass];
         };
    ]
    (Int.Table.of_alist_exn
       [
         0, 0;
         (* Entry *)
         1, 1;
         (* Exit *)
         3, 1;
         (* Final *)
         5, 0;
         (* If *)
         6, 1;
         (* Join *)
         7, 0;
         (* Body *)
         8, 0;
         (* Orelse *)
       ]);
  assert_fixpoint
    [
      +Statement.If
         { If.test = +Expression.Constant Constant.True; body = [+Statement.Pass]; orelse = [] };
    ]
    (Int.Table.of_alist_exn [5, 0; 6, 1; 0, 0; 8, 0; 1, 1; 3, 1; 7, 0]);
  assert_fixpoint
    [
      +Statement.If
         {
           If.test = +Expression.Constant Constant.True;
           body = [+Statement.Pass; +Statement.Pass];
           orelse = [+Statement.Pass];
         };
    ]
    (Int.Table.of_alist_exn [0, 0; 1, 2; 3, 2; 5, 0; 6, 2; 7, 0; 8, 0])


let test_widening _ =
  let open Expression in
  assert_fixpoint
    [
      +Statement.While
         { While.test = +Expression.Constant Constant.True; body = [+Statement.Pass]; orelse = [] };
    ]
    (Int.Table.of_alist_exn
       [
         0, 0;
         (* Entry *)
         1, Int.max_value;
         (* Exit *)
         3, Int.max_value;
         (* Final *)
         5, Int.max_value;
         (* Split *)
         7, Int.max_value;
         (* Pass *)
         8, Int.max_value;
         (* Synthetic assert False *)
       ])


let () =
  "fixpoint"
  >::: ["forward" >:: test_forward; "join" >:: test_join; "widening" >:: test_widening]
  |> Test.run
