#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
SetBatchLines, -1

;How long the Shift should stay active this value is in seconds. use 0.5 for half secondif you want a capital A, then press and release Shift, then press 'a' within two seconds after the timeout has elapsed, the shift is no longer in effect
timeout := 0.2

;Should tapping shift twice turn on Capslock? this value is either 'true' or 'false' with no quotes default is 'false', which means a double tap of Shift will cancel the shift
double_shift_for_caps := true

;Allow the sequence "Shift,Space,Key" to still shift the Key this value is either 'true' or 'false' with no quotes this means that the Spacebar will not cancel the shift a user wanted to press Shift+Space to be able to shift the next char after Space
skip_spacebar := false

; we don't want Control as end key, because we need to be able to press Shift,Ctrl+Left
; we don't want Alt as end key, because Shift+Alt+F should still open up File menu bars
; we don't want Win as end key, because it Shift+Win+D should still send Shift+D
; don't want CapsLock as end key, because Shift down, Caps down/up, Shift still down + M, should invert CapsLock
end_keys := "{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}"
. "{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{PrintScreen}{Pause}{AppsKey}{LShift}{RShift}"
; test := 0

; F11::ListHotkeys
; Esc::ExitApp ;a;sdlkjffj;akljdjf

#F8::
; Send, ^s ; To save a changed script
Sleep, 300 ; give it time to save the script
Reload
Return

Hotkey, LShift, Shift_Down, on
Hotkey, RShift, Shift_Down, on
Hotkey, LShift Up, Shift_Up , on
Hotkey, RShift Up, Shift_Up , on


Shift_Down:
    ;    tooltip, % "[" A_ThisHotkey "]" ++test ;"`nA_PriorKey=" A_PriorKey    ; if you hold down shift, you'll see this loops after each timeout, so Shift is a repeat key just like any letter, it keeps getting spammed
    if (caps_on)
    {
        SetCapsLockState, Off
        caps_on := false
        return
    }

    trigger_shift_key := A_ThisHotkey ; needs to be set because A_ThisHotkey gets overwritten by the Up hotkey
    , waiting_for_input := 1

    Send, {%trigger_shift_key% down}
    Input, key, V M L1 T%timeout%, %end_keys%
    ; inputErrorLevel := ErrorLevel

    if (ErrorLevel == "EndKey:LShift") || (ErrorLevel == "EndKey:RShift")
    {
        KeyWait, % SubStr(ErrorLevel, 8) ; careful, keywait sets its own errorlevel from this point forward
        if (double_shift_for_caps)
        {
            ; tooltip, a second shift press occurred.`ntrigger_shift_key: %trigger_shift_key%`ninputErrorLevel: %inputErrorLevel%
            ; sleep, 1000
            SetCapsLockState, On
            caps_on := true
        }
    }

    ; ; allow Shift,Space,Space,Space(etc),Letter to work:
    ; if (skip_spacebar)
    ;     while (key = " ")
    ;     Input key, V M L1 T%timeout%, %end_keys%

    tooltip, key=[%key%]`nA_ThisHotkey=[%A_ThisHotkey%]`ntrigger_shift_key=[%trigger_shift_key%]`ninputErrorlevel=%inputErrorLevel%`nhotkeys back on

    if !(GetKeyState(A_ThisHotkey))
        Send, {%trigger_shift_key% Up}
    waiting_for_input := 0 ; the order of this line could possibly matter, this seems like the best order
    Hotkey, LShift, on
    Hotkey, RShift, on
    Hotkey, LShift Up, on
    Hotkey, RShift Up, on
return

Shift_Up:
    ; tooltip, [%A_ThisHotkey%]`nshift_key=%trigger_shift_key%

    ; if we pressed and released Shift, then the down hotkey is waiting for the next char input
    ; so we want to turn off these hotkeys, so that we can detect another LShift as the Input EndKey
    if (waiting_for_input)
    {
        ; tooltip, turning off hotkeys
        Hotkey, RShift, off
        Hotkey, RShift Up, off
        Hotkey, LShift, off
        Hotkey, LShift Up, off
    }

    ; else, the down hotkey is no longer waiting for input.
    ; this only fires if the Up hotkey was triggered AFTER the Input was complete
    ; which means shift was held down during the Input, resulting in a normal Shift+letter simultanous chord.
    ; this is needed because without it, then shift would get 'stuck' down.
    ; test: hold down Shift, and the down hotkey above fires. while still holding shift, we press a letter.
    ; the Input cmd captures the letter and then finally its supposed to Send Shift Up
    ; but we're still physically holding down Shift, so i don't think the virtual Send Shift Up ever goes through
    ; or if it does go through, it somehow blocks our real Shift up release
    else
    {
        Send, {%A_ThisHotkey%}
    }
return
