
; 4 Way Navigation


*F3::WheelScroll("F3", "Right", "WheelRight")
*F1::WheelScroll("F1", "Left", "WheelLeft")
*F2::WheelScroll("F2", "Down", "WheelDown")
*LWin::WheelScroll("LWin", "Up", "WheelUp")

WheelScroll(shortcut, key, mouse) {
	SetMouseDelay 44
	multiplier:=1
	setDelay := WinActive("ahk_exe FL64.exe") ? 111 : 99
	; setDelay:=55
	; SetMouseDelay, 77
	Loop {
		; If (A_TimeSinceThisHotkey<222) {
		; 	SendEvent {%key% %multiplier%}
		; }
		SendEvent {%key% %multiplier%}
		If (A_TimeSinceThisHotkey>777) {
			setDelay:=11
			Sleep %setDelay%
			MouseClick, %mouse%, , , , 77
			multiplier:=33
		} Else If (A_TimeSinceThisHotkey>555) {
			SendEvent {%key% %multiplier%}
			setDelay:=33
			multiplier:=7
		} Else If (A_TimeSinceThisHotkey>333) {
			SendEvent {%key% %multiplier%}
			setDelay:=77
			multiplier:=3
		}
		If (A_TimeSinceThisHotkey>1111) {
			multiplier:=22
		}
		Sleep %setDelay%
	} Until !GetKeyState(shortcut, "P")
	Return
}


*Up::NavKey("Up")
*Down::NavKey("Down")
*Left::NavKey("Left")
*Right::NavKey("Right")
NavKey(key) {
		Loop {
		If WinActive("OneNote") { ; Adapt to OneNote
			ControlSend, OneNote::DocumentCanvas1,{%key%},ahk_exe ONENOTE.EXE
		} Else {
			Send {Blind}{%key%}
		}
		Sleep 99
	} Until !GetKeyState(key, "P")
	Return
}



; Scrolling through Explorer tabs
#IfWinActive, ahk_class CabinetWClass 

CapsLock & WheelDown::Send {Tab}
CapsLock & WheelUp::Send +{Tab}
#If

CapsLock & RButton::Send ^w ; Close tab
CapsLock & Tab::Send ^{Tab} ; Last tab
CapsLock & WheelUp::Send ^{PgUp} ; Previous tab
CapsLock & WheelDown::Send ^{PgDn} ; Next tab
CapsLock & w::Send ^w ; Close tab
CapsLock & e::Send ^t ; New tab
CapsLock & r::Send ^r ; Reload
CapsLock & q::Send {Ctrl Up}+!y ; Dark mode
CapsLock & t::Send +^t ; Reopen last closed tab





; Navigating between apps' open windows.
; Choosing between apps' windows: bring chosen to front
; Choosing between different apps' windows: bring the last most recent apps' window to front
; Long press: close all app's windows
#If GetKeyState("Tab", "P")
1::WindowKey(1)
2::WindowKey(2)
3::WindowKey(3)
4::WindowKey(4)
5::WindowKey(5)
#If

WindowKey(key) {
	SetKeyDelay, 11, 33
	Send {RWin Down}{LCtrl Down}%key%
	KeyWait, %key%, T.2
	Send {RWin Up}{LCtrl Up}
	If ErrorLevel {
		Send {RWin Down}{LAlt Down}%key%{LAlt Up}{RWin Up}
		Sleep 11
		Send {Up}{Enter}
	}
	Return
}

*LShift::
	MouseGetPos, x0, y0
	SetTimer, MouseMotion, 11
	Return

*LShift Up::
	If WinActive("Task View") {
		Send {Click}
	} Else If (A_PriorHotkey="*LShift") {
		Critical 1
		Send {LAlt Down}{Tab}
		Sleep 5
		; WinWait, ahk_class XamlExplorerHostIslandWindow
		Send {LAlt Up}
		Critical 0
	}
	SetTimer, MouseMotion, Off
	Return

   *Tab::
	MouseGetPos, x0, y0
	SetTimer, MouseMotion, 11
	Return
~*Tab Up::
	SetTimer, MouseMotion, Off
	If WinActive("Task View") {
		Send {LCtrl Up}{LWin Up}{Click}
	} Else If (A_PriorHotkey="*Tab") {
		Critical 1
		Thread, Interrupt
		Send {LAlt Down}{Tab}
		Sleep 5
		; WinWait, ahk_class XamlExplorerHostIslandWindow
		Send {LAlt Up}
		Critical 0
	} Else {
		Send {LWin Up}
	} Return

Tab & BackSpace::Send +^p
Tab & e::SendInput ^n ; New Window
Tab & w::SendInput !{F4} ; Close Window






; Scrolling between desktops
#IfWinActive, Task View
WheelUp::Send #^{Left}
WheelDown::Send #^{Right}
#If GetKeyState("LShift", "P")
WheelDown::Send ^#{Left}
WheelUp::Send ^#{Right}
#If
RAlt & F11::
~RButton & WheelUp::Send ^#{Left}
RAlt & F12::
~RButton & WheelDown::Send ^#{Right}

