(**************************************************************************)
(*  This file is part of Binsec.                                          *)
(*                                                                        *)
(*  Copyright (C) 2016-2017                                               *)
(*    VERIMAG                                                             *)
(*                                                                        *)
(*  you can redistribute it and/or modify it under the terms of the GNU   *)
(*  Lesser General Public License as published by the Free Software       *)
(*  Foundation, version 2.1.                                              *)
(*                                                                        *)
(*  It is distributed in the hope that it will be useful,                 *)
(*  but WITHOUT ANY WARRANTY; without even the implied warranty of        *)
(*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *)
(*  GNU Lesser General Public License for more details.                   *)
(*                                                                        *)
(*  See the GNU Lesser General Public License version 2.1                 *)
(*  for more details (enclosed in the file licenses/LGPLv2.1).            *)
(**************************************************************************)

open TypeTraceDSE
open TypeHistoryDSE


module GuideAsDFS = functor (TraceDSE_v:TypeTraceDSE) -> functor (HistoryDSE_v:TypeHistoryDSE) ->
struct
  module HistoryDSE = HistoryDSE_v(TraceDSE_v)
  type trace_t = TraceDSE_v.trace_t
  type child_t = TraceDSE_v.child_t
  type history_t = HistoryDSE.history_t

  type score_input_t = string
  type score_t = int
  type children_t = child_t list

  let init_children () : children_t = []

  let print_children _ = ()

  (* score of child simply return 0 *)
  let _score_child _ _ = 0

  (* select next child for examination: DFS visitor => select the last child *)
  let select_child (children:children_t) =
    match List.rev children with
    | child :: rested_children ->
      Some child, (List.rev rested_children:children_t)
    | _ -> None, ([]:children_t)


  let next_children previous trace (_history:  HistoryDSE.history_t) =
    TraceDSE_v.get_children previous trace

  let add_children = List.append

  let add_children_max_score (children:children_t) _ = children, 0

  let add_children_second_max_score children _ = children,0

  let set_score (_score_file:score_input_t) = ()

  let reset_max_score () = ()
  let enable_max_score  () = ()
  let disable_max_score () = ()
end
