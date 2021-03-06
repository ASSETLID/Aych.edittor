(**************************************************************************)
(*                                                                        *)
(*  Copyright 2013 OCamlPro                                               *)
(*                                                                        *)
(*  All rights reserved.  This file is distributed under the terms of     *)
(*  the GNU Public License version 3.0.                                   *)
(*                                                                        *)
(*  This software is distributed in the hope that it will be useful,      *)
(*  but WITHOUT ANY WARRANTY; without even the implied warranty of        *)
(*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *)
(*  GNU General Public License for more details.                          *)
(*                                                                        *)
(**************************************************************************)

module Controls : sig
  type t = [ `NEW | `OPEN | `SAVE | `SAVE_AS
           | `EXECUTE | `EXECUTE_ALL | `STOP | `RESTART | `CLEAR
           | `SELECT_COLOR | `ZOOM_IN | `ZOOM_OUT | `FULLSCREEN
           | `QUIT ]
  val bind: t -> (unit -> unit) -> unit
  (* val trigger: t -> unit *)

  val enable: t -> unit
  val disable: t -> unit
end

module Dialogs : sig
  type 'a cps = ('a -> unit) -> unit

  val choose_file :
    parent:#GWindow.window_skel ->
    [< `OPEN | `SAVE ] -> ?cancel:(unit -> unit) -> string cps

  val error :
    parent:#GWindow.window_skel ->
    title:string -> string -> unit

  val quit :
    parent:#GWindow.window_skel ->
    string option
    -> save:(unit -> unit cps) -> quit:(unit -> unit)
    -> unit

  val confirm :
    parent:#GWindow.window_skel ->
    title:string -> string -> ?no:(unit -> unit) -> unit cps
end

val main_window : unit -> GWindow.window

val set_window_title :
  GWindow.window -> ('a, unit, string, string, string, unit) format6 -> 'a

val open_text_view : GSourceView3.source_buffer -> GSourceView3.source_view

val open_toplevel_view : GSourceView3.source_buffer -> GSourceView3.source_view

(* Displays a message in the status bar *)
val top_msg : string -> unit
val index_msg : string -> unit

(* call _after_ opening the views *)
val set_font :
  GSourceView3.source_view -> GSourceView3.source_view -> string
  -> unit

val switch_fullscreen : GWindow.window -> unit
