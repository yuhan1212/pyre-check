(*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

module Context = PyreAst.Parser.Context
module Error = PyreAst.Parser.Error

exception Exception of Error.t

let position ~line ~column = { Ast.Location.line; column }

let location ~start ~stop = { Ast.Location.start; stop }

let identifier x = x

let expression_context = PyreAst.TaglessFinal.ExpressionContext.make ~load:() ~store:() ~del:() ()

let constant =
  let none () = failwith "not implemented yet" in
  let false_ () = failwith "not implemented yet" in
  let true_ () = failwith "not implemented yet" in
  let ellipsis () = failwith "not implemented yet" in
  let integer _ = failwith "not implemented yet" in
  let big_integer _ = failwith "not implemented yet" in
  let float_ _ = failwith "not implemented yet" in
  let complex _ = failwith "not implemented yet" in
  let string_ _ = failwith "not implemented yet" in
  let byte_string _ = failwith "not implemented yet" in
  PyreAst.TaglessFinal.Constant.make
    ~none
    ~false_
    ~true_
    ~ellipsis
    ~integer
    ~big_integer
    ~float_
    ~complex
    ~string_
    ~byte_string
    ()


let boolean_operator =
  let and_ () = failwith "not implemented yet" in
  let or_ () = failwith "not implemented yet" in
  PyreAst.TaglessFinal.BooleanOperator.make ~and_ ~or_ ()


let binary_operator =
  let add () = failwith "not implemented yet" in
  let sub () = failwith "not implemented yet" in
  let mult () = failwith "not implemented yet" in
  let matmult () = failwith "not implemented yet" in
  let div () = failwith "not implemented yet" in
  let mod_ () = failwith "not implemented yet" in
  let pow () = failwith "not implemented yet" in
  let lshift () = failwith "not implemented yet" in
  let rshift () = failwith "not implemented yet" in
  let bitor () = failwith "not implemented yet" in
  let bitxor () = failwith "not implemented yet" in
  let bitand () = failwith "not implemented yet" in
  let floordiv () = failwith "not implemented yet" in
  PyreAst.TaglessFinal.BinaryOperator.make
    ~add
    ~sub
    ~mult
    ~matmult
    ~div
    ~mod_
    ~pow
    ~lshift
    ~rshift
    ~bitor
    ~bitxor
    ~bitand
    ~floordiv
    ()


let unary_operator =
  let invert () = failwith "not implemented yet" in
  let not_ () = failwith "not implemented yet" in
  let uadd () = failwith "not implemented yet" in
  let usub () = failwith "not implemented yet" in
  PyreAst.TaglessFinal.UnaryOperator.make ~invert ~not_ ~uadd ~usub ()


let comparison_operator =
  let eq () = failwith "not implemented yet" in
  let noteq () = failwith "not implemented yet" in
  let lt () = failwith "not implemented yet" in
  let lte () = failwith "not implemented yet" in
  let gt () = failwith "not implemented yet" in
  let gte () = failwith "not implemented yet" in
  let is () = failwith "not implemented yet" in
  let isnot () = failwith "not implemented yet" in
  let in_ () = failwith "not implemented yet" in
  let notin () = failwith "not implemented yet" in
  PyreAst.TaglessFinal.ComparisonOperator.make
    ~eq
    ~noteq
    ~lt
    ~lte
    ~gt
    ~gte
    ~is
    ~isnot
    ~in_
    ~notin
    ()


let comprehension ~target:_ ~iter:_ ~ifs:_ ~is_async:_ = failwith "not implemented yet"

let keyword ~location:_ ~arg:_ ~value:_ = failwith "not implemented yet"

let argument ~location:_ ~identifier:_ ~annotation:_ ~type_comment:_ =
  failwith "not implemented yet"


let arguments ~posonlyargs:_ ~args:_ ~vararg:_ ~kwonlyargs:_ ~kw_defaults:_ ~kwarg:_ ~defaults:_ =
  failwith "not implemented yet"


let expression =
  let bool_op ~location:_ ~op:_ ~values:_ = failwith "not implemented yet" in
  let named_expr ~location:_ ~target:_ ~value:_ = failwith "not implemented yet" in
  let bin_op ~location:_ ~left:_ ~op:_ ~right:_ = failwith "not implemented yet" in
  let unary_op ~location:_ ~op:_ ~operand:_ = failwith "not implemented yet" in
  let lambda ~location:_ ~args:_ ~body:_ = failwith "not implemented yet" in
  let if_exp ~location:_ ~test:_ ~body:_ ~orelse:_ = failwith "not implemented yet" in
  let dict ~location:_ ~keys:_ ~values:_ = failwith "not implemented yet" in
  let set ~location:_ ~elts:_ = failwith "not implemented yet" in
  let list_comp ~location:_ ~elt:_ ~generators:_ = failwith "not implemented yet" in
  let set_comp ~location:_ ~elt:_ ~generators:_ = failwith "not implemented yet" in
  let dict_comp ~location:_ ~key:_ ~value:_ ~generators:_ = failwith "not implemented yet" in
  let generator_exp ~location:_ ~elt:_ ~generators:_ = failwith "not implemented yet" in
  let await ~location:_ ~value:_ = failwith "not implemented yet" in
  let yield ~location:_ ~value:_ = failwith "not implemented yet" in
  let yield_from ~location:_ ~value:_ = failwith "not implemented yet" in
  let compare ~location:_ ~left:_ ~ops:_ ~comparators:_ = failwith "not implemented yet" in
  let call ~location:_ ~func:_ ~args:_ ~keywords:_ = failwith "not implemented yet" in
  let formatted_value ~location:_ ~value:_ ~conversion:_ ~format_spec:_ =
    failwith "not implemented yet"
  in
  let joined_str ~location:_ ~values:_ = failwith "not implemented yet" in
  let constant ~location:_ ~value:_ ~kind:_ = failwith "not implemented yet" in
  let attribute ~location:_ ~value:_ ~attr:_ ~ctx:() = failwith "not implemented yet" in
  let subscript ~location:_ ~value:_ ~slice:_ ~ctx:() = failwith "not implemented yet" in
  let starred ~location:_ ~value:_ ~ctx:() = failwith "not implemented yet" in
  let name ~location:_ ~id:_ ~ctx:() = failwith "not implemented yet" in
  let list ~location:_ ~elts:_ ~ctx:() = failwith "not implemented yet" in
  let tuple ~location:_ ~elts:_ ~ctx:() = failwith "not implemented yet" in
  let slice ~location:_ ~lower:_ ~upper:_ ~step:_ = failwith "not implemented yet" in
  PyreAst.TaglessFinal.Expression.make
    ~bool_op
    ~named_expr
    ~bin_op
    ~unary_op
    ~lambda
    ~if_exp
    ~dict
    ~set
    ~list_comp
    ~set_comp
    ~dict_comp
    ~generator_exp
    ~await
    ~yield
    ~yield_from
    ~compare
    ~call
    ~formatted_value
    ~joined_str
    ~constant
    ~attribute
    ~subscript
    ~starred
    ~name
    ~list
    ~tuple
    ~slice
    ()


let with_item ~context_expr:_ ~optional_vars:_ = failwith "not implemented yet"

let import_alias ~location:_ ~name:_ ~asname:_ = failwith "not implemented yet"

let exception_handler ~location:_ ~type_:_ ~name:_ ~body:_ = failwith "not implemented yet"

(* TODO(T102720335): Support pattern matching *)
let match_case ~pattern:_ ~guard:_ ~body:_ = failwith "not implemented yet"

(* TODO(T102720335): Support pattern matching *)
let pattern =
  let match_value ~location:_ ~value:_ = () in
  let match_singleton ~location:_ ~value:_ = () in
  let match_sequence ~location:_ ~patterns:_ = () in
  let match_mapping ~location:_ ~keys:_ ~patterns:_ ~rest:_ = () in
  let match_class ~location:_ ~cls:_ ~patterns:_ ~kwd_attrs:_ ~kwd_patterns:_ = () in
  let match_star ~location:_ ~name:_ = () in
  let match_as ~location:_ ~pattern:_ ~name:_ = () in
  let match_or ~location:_ ~patterns:_ = () in
  PyreAst.TaglessFinal.Pattern.make
    ~match_value
    ~match_singleton
    ~match_sequence
    ~match_mapping
    ~match_class
    ~match_star
    ~match_as
    ~match_or
    ()


let statement =
  let function_def ~location:_ ~name:_ ~args:_ ~body:_ ~decorator_list:_ ~returns:_ ~type_comment:_ =
    failwith "not implemented yet"
  in
  let async_function_def
      ~location:_
      ~name:_
      ~args:_
      ~body:_
      ~decorator_list:_
      ~returns:_
      ~type_comment:_
    =
    failwith "not implemented yet"
  in
  let class_def ~location:_ ~name:_ ~bases:_ ~keywords:_ ~body:_ ~decorator_list:_ =
    failwith "not implemented yet"
  in
  let return ~location:_ ~value:_ = failwith "not implemented yet" in
  let delete ~location:_ ~targets:_ = failwith "not implemented yet" in
  let assign ~location:_ ~targets:_ ~value:_ ~type_comment:_ = failwith "not implemented yet" in
  let aug_assign ~location:_ ~target:_ ~op:_ ~value:_ = failwith "not implemented yet" in
  let ann_assign ~location:_ ~target:_ ~annotation:_ ~value:_ ~simple:_ =
    failwith "not implemented yet"
  in
  let for_ ~location:_ ~target:_ ~iter:_ ~body:_ ~orelse:_ ~type_comment:_ =
    failwith "not implemented yet"
  in
  let async_for ~location:_ ~target:_ ~iter:_ ~body:_ ~orelse:_ ~type_comment:_ =
    failwith "not implemented yet"
  in
  let while_ ~location:_ ~test:_ ~body:_ ~orelse:_ = failwith "not implemented yet" in
  let if_ ~location:_ ~test:_ ~body:_ ~orelse:_ = failwith "not implemented yet" in
  let with_ ~location:_ ~items:_ ~body:_ ~type_comment:_ = failwith "not implemented yet" in
  let async_with ~location:_ ~items:_ ~body:_ ~type_comment:_ = failwith "not implemented yet" in
  let match_ ~location:_ ~subject:_ ~cases:_ =
    (* TODO(T102720335): Support pattern matching *)
    failwith "not implemented yet"
  in
  let raise_ ~location:_ ~exc:_ ~cause:_ = failwith "not implemented yet" in
  let try_ ~location:_ ~body:_ ~handlers:_ ~orelse:_ ~finalbody:_ =
    failwith "not implemented yet"
  in
  let assert_ ~location:_ ~test:_ ~msg:_ = failwith "not implemented yet" in
  let import ~location:_ ~names:_ = failwith "not implemented yet" in
  let import_from ~location:_ ~module_:_ ~names:_ ~level:_ = failwith "not implemented yet" in
  let global ~location:_ ~names:_ = failwith "not implemented yet" in
  let nonlocal ~location:_ ~names:_ = failwith "not implemented yet" in
  let expr ~location:_ ~value:_ = failwith "not implemented yet" in
  let pass ~location:_ = failwith "not implemented yet" in
  let break ~location:_ = failwith "not implemented yet" in
  let continue ~location:_ = failwith "not implemented yet" in
  PyreAst.TaglessFinal.Statement.make
    ~function_def
    ~async_function_def
    ~class_def
    ~return
    ~delete
    ~assign
    ~aug_assign
    ~ann_assign
    ~for_
    ~async_for
    ~while_
    ~if_
    ~with_
    ~async_with
    ~match_
    ~raise_
    ~try_
    ~assert_
    ~import
    ~import_from
    ~global
    ~nonlocal
    ~expr
    ~pass
    ~break
    ~continue
    ()


let type_ignore ~lineno:_ ~tag:_ = ()

let module_ ~body ~type_ignores:_ = body

let function_type ~argtypes:_ ~returns:_ = ()

let specification =
  PyreAst.TaglessFinal.make
    ~argument
    ~arguments
    ~binary_operator
    ~boolean_operator
    ~comparison_operator
    ~comprehension
    ~constant
    ~exception_handler
    ~expression
    ~expression_context
    ~function_type
    ~identifier
    ~import_alias
    ~keyword
    ~location
    ~match_case
    ~module_
    ~pattern
    ~position
    ~statement
    ~type_ignore
    ~unary_operator
    ~with_item
    ()


let with_context ?on_failure = PyreAst.Parser.with_context ?on_init_failure:on_failure

let parse_module ?filename ?enable_type_comment ~context =
  PyreAst.Parser.TaglessFinal.parse_module
    ?filename
    ?enable_type_comment
    ~context
    ~spec:specification


let parse_module_exn ?filename ?enable_type_comment ~context text =
  match parse_module ?filename ?enable_type_comment ~context text with
  | Result.Ok statements -> statements
  | Result.Error error -> raise (Exception error)


let parse_expression ~context =
  PyreAst.Parser.TaglessFinal.parse_expression ~context ~spec:specification
