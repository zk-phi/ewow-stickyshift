;; This script provides: sticky-shift key

sticky_tt := alloc_tt()

;; ---------
;; variables
;; ---------

sticky_pending = 0

set_sticky()
{ Global
    sticky_pending = 1
    ToolTip, Sticky, 1, 0, %sticky_tt%
}

reset_sticky()
{ Global
    sticky_pending = 0
    ToolTip, , , , %sticky_tt%
}

add_hook("after_display_transition_hook", "reset_sticky")

;; -----
;; hooks
;; -----

sticky_executing = 0

sticky_before_send()
{ Global
    If sticky_pending
    {
        sticky_executing = 1
        reset_sticky()
        last_command = {shift down}%last_command%{shift up}
    }
}

sticky_after_send()
{ Global
    If sticky_executing
        sticky_executing = 0
}

add_hook("before_send_hook", "sticky_before_send")
add_hook("after_send_hook", "sticky_after_send")

;; --------
;; commands
;; --------

sticky_shift()
{ Global
    If !sticky_pending
        command_simple("set_sticky", 0, 0)
    Else
    {
        reset_sticky()
        command_simple("self_send_command", 0, 0)
    }
}
