#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#KeyHistory 0

Hotkey, *i, Off
Hotkey, *j, Off
Hotkey, *k, Off
Hotkey, *l, Off
Hotkey, *o, Off
Hotkey, *u, Off
Hotkey, *3, Off
Hotkey, *4, Off
Hotkey, *[, Off
Hotkey, *', Off
Hotkey, *``, Off
Hotkey, *., Off
Hotkey, *`,, Off
Hotkey, *m, Off
Hotkey, *w, Off
Hotkey, *q, Off
Hotkey, *c, Off
Hotkey, *x, Off
Hotkey, *v, Off
Hotkey, *r, Off
Hotkey, *z, Off
Hotkey, *y, Off
Hotkey, *s, Off
Hotkey, *a, Off
Hotkey, *d, Off
Hotkey, *`;, Off
Hotkey, *g, Off
Hotkey, *t, Off
Hotkey, *b, Off

*RAlt::
    Hotkey, *i, on
    Hotkey, *j, on
    Hotkey, *k, on
    Hotkey, *l, on
    Hotkey, *o, on
    Hotkey, *u, on
    Hotkey, *3, on
    Hotkey, *4, on
    Hotkey, *[, on
    Hotkey, *', on
    Hotkey, *``, on
    Hotkey, *., on
    Hotkey, *`,, on
    Hotkey, *m, on
    Hotkey, *w, on
    Hotkey, *q, on
    Hotkey, *c, on
    Hotkey, *x, on
    Hotkey, *v, on
    Hotkey, *r, on
    Hotkey, *z, on
    Hotkey, *y, on
    Hotkey, *s, on
    Hotkey, *a, on
    Hotkey, *d, on
    Hotkey, *`;, on
    Hotkey, *g, on
    Hotkey, *t, on
    Hotkey, *b, on
return

*RAlt up::
    Hotkey, *i, off
    Hotkey, *j, off
    Hotkey, *k, off
    Hotkey, *l, off
    Hotkey, *o, Off
    Hotkey, *u, Off
    Hotkey, *3, Off
    Hotkey, *4, Off
    Hotkey, *[, Off
    Hotkey, *', Off
    Hotkey, *``, Off
    Hotkey, *., Off
    Hotkey, *`,, Off
    Hotkey, *m, Off
    Hotkey, *w, Off
    Hotkey, *q, Off
    Hotkey, *c, Off
    Hotkey, *x, Off
    Hotkey, *v, Off
    Hotkey, *r, Off
    Hotkey, *z, Off
    Hotkey, *y, Off
    Hotkey, *s, Off
    Hotkey, *a, Off
    Hotkey, *d, Off
    Hotkey, *`;, Off
    Hotkey, *g, Off
    Hotkey, *t, Off
    Hotkey, *b, Off
return

*i::send {blind}{up}
*j::send {blind}{left}
*k::send {blind}{down}
*l::send {blind}{right}
*o::send {blind}{end}
*u::send {blind}{home}
;
;Required extensions for following custom commands:
;"Quick and Simple Text Selection" publisher:"David Bankier" 
;"Toggle Case" publisher:"Pranshu Agrawal"
;"Go to Next/Previous Member" publisher:"Mishkin Faustini"
;"bracket select" by chunsen wang
;"Any Swap" by publisher:"wolray"
;"copy word in cursor" publisher:"Alessandro Fragnani"
;"Semicolon Insertion Shortcut" publisher:"Christian Valentin"
;"Multiple clipboards for VSCode" publisher:"slevesque"
;"Code Ace Jumper" publisher:"lucax88x"
;"Multiple clipboards for VSCode" publisher:"slevesque"
;
*3::send {LCtrl Down}{k}{LCtrl Up}{LShift Down}{,}{LShift Up}   ;select inside angled brackets ! "Quick and Simple Text Selection" 
*4::send {LCtrl Down}{k}{LCtrl Up}{LShift Down}{.}{LShift Up}   ;select inside tag ! "Quick and Simple Text Selection" 
*[::send {blind}{LCtrl Down}{k}{LCtrl Up}{[}   ;select inside bracket ! "Quick and Simple Text Selection" 
*'::send {LCtrl Down}{k}{LCtrl Up}{LShift Down}{;}{LShift Up}   ;switch quotes ! "Quick and Simple Text Selection" 
*`::send {blind}{F13}    ;switch upper/lower case !"Toggle Case" 
*.::send {blind}{F14}    ;swap argument right !"Any Swap"
*,::send {blind}{F15}    ;swap argument left
*q::send {blind}{F16}    ;select inside quote(including brackets) !"bracket select" by chunsen wang
*m::send {blind}{F17}    ;jump to next/previous member !"Go to Next/Previous Member" 
*w::send {LCtrl Down}{d}{LCtrl Up}    ;(Word) select word, press again to select next occurrence
*c::send {LCtrl Down}{c}{LCtrl Up}    ;(Copy) copy word ! "copy word in cursor" 
*x::send {LCtrl Down}{x}{LCtrl Up}    ;(X) cut word/selection !need above extension
*v::send {LCtrl Down}{v}{LCtrl Up}    ;(V) Paste 
*r::send {LCtrl Down}{d}{v}{LCtrl Up}    ;(Replace) replace Word
*z::send {LCtrl Down}{z}{LCtrl Up}    ;(Z) undo
*y::send {LCtrl Down}{y}{LCtrl Up}    ;(Y) redo
*s::send {home}{LShift Down}{end}{LShift Up}    ;(Sentence) select the sentence (all text in the line excluding the indent)
*a::send {LCtrl Down}{l}{LCtrl Up}    ;(Line) select line
*d::send {LCtrl Down}{d}{BackSpace}{LCtrl Up}    ;(Delete) word
*;::send {blind}{LCtrl Down}{;}{LCtrl Up}    ;(add) ;/: at end of line !Semicolon Insertion Shortcut
*g::send {LCtrl Down}{g}{LCtrl Up}   ;(Goto) go to word !ACE Jumper
*t::send {LCtrl Down}{LShift Down}{g}{LShift Up}{LCtrl Up}   ;(Goto) go to line !ACE Jumper
*b::send {blind}{F18}   ;(Board) clipboard buffer

;<\b>asdf<\b> "hello"
;;standalone hotkeys: \ key on the keyboard has the delete function, the charactar \ is remapped to capslock and z. 
*\::Send {Right}{BackSpace}  ;(Delete) don't send {delete} to avoid triggering ctrl+alt+delete system-wide command on windows
^\::Send {LCtrl Down}{Right}{LCtrl Up}{BackSpace}   ;(Delete) the word to the right 
<+-::return 
*7::Send {_}
<+7::Send {&}
CapsLock & 7::Send {_}

; double press CapsLock to turn on, single press to turn off.. 
~CapsLock:: 
    if (A_PriorHotkey != "~CapsLock" or A_TimeSincePriorHotkey > 200)
    {
        ; Too much time between presses, so this isn't a double-press.123(<>_
        KeyWait, CapsLock
        SetCapsLockState, off
        return
    }
    SetCapsLockState, On ;double-pressed
return

; CapsLock & @::SendMode("ummmmm@gmail.com", "string")

CapsLock & u::Send {1}
CapsLock & i::Send {2}
CapsLock & o::Send {3}
CapsLock & j::Send {4}
CapsLock & k::Send {5}
CapsLock & l::Send {6}
CapsLock & m::Send {7}
CapsLock & ,::Send {8}
CapsLock & .::Send {9}
CapsLock & y::Send {0}
CapsLock & x::Send {x}
CapsLock & n::Send {.}
CapsLock & h::Send {,}
CapsLock & t::SendMode("{-}{>}", "arrow")
CapsLock & g::SendMode("{&}", "assignment")
CapsLock & b::SendMode("{|}", "assignment")
CapsLock & p::SendMode("{+}", "assignment")
CapsLock & -::SendMode("{-}", "assignment")
CapsLock & 8::SendMode("{*}", "assignment")
CapsLock & /::SendMode("{/}", "assignment")
CapsLock & `;::SendMode("{:}", "assignment")
CapsLock & 3::Send {<}
CapsLock & 4::Send {>}
CapsLock & e::Send {[}
CapsLock & r::Send {]}
CapsLock & d::Send {(}
CapsLock & f::Send {)}
CapsLock & c::Send {{}
CapsLock & v::Send {}}
CapsLock & '::Send {"}
CapsLock & 5::Send {`%}
CapsLock & 6::Send {^} 
; CapsLock & s::Send {_}
CapsLock & 1::Send {!}
CapsLock & 2::Send {@}  
CapsLock & w::Send {$}  
CapsLock & q::Send {#}   
CapsLock & s::Send {~}   
CapsLock & z::Send {\}  

;disable keys: 
;   
<+9::return ;disable left shift + 9 
<++::return
; <+8::return
; <+[::return
; <+]::return 
; *[::return


SendMode(key, mode) {
    LAlt := GetKeyState("LALT", "P")

    if LAlt {
        switch mode {
            case "assignment":  Send, %key%=
            case "arrow":       Send, =>
            case "string":      Send, %key%
            Default:            Send, %key%%mode%
        }
    }
    else {
        Send, %key%
    }
}
