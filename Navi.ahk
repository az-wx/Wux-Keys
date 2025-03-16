 
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


; Scrolling through Explorer or Terminal tabs
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
F4::
	If WinActive("ahk_exe firefox.exe")||WinActive("ahk_exe chrome.exe") {
		Send {F1}
	} Else If WinActive("Code") {
		Send ^k^b ; Toggle Sidebar
	} Return
	
	
CapsLock & q::
	If WinActive("ahk_exe firefox.exe")||WinActive("ahk_exe chrome.exe") {
		Send {Ctrl Up}+!y ; Dark mode
	} Else If WinActive(" ahk_exe Code.exe") {
		Send ^k^b ; Toggle sidebar
	} Else {
		Send ^q
	} Return
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
	; SetKeyDelay, 11, 11
	global KeyWinSw:=1
	Send {LWin Down}{LCtrl Down}%key%
	KeyWait, %key%, T.2
	Send {LWin Up}{LCtrl Up}
	If ErrorLevel {
		Send !#%key%
		WinWaitActive, ahk_class SIBJumpView, , 2
		Send {Up}{Enter}
	} Return
}

#InputLevel 2
LShift::
	SendLevel 0
	MouseGetPos, x0, y0
	SetTimer, MouseMotion, 11
	Return

LShift Up::
	SendLevel 0
	If WinActive("Task View") {
		Send {Click}
	} Else If (A_PriorHotkey="*LShift")&&(A_PriorKey="LShift") {
		; Critical 1
		; Thread, Interrupt
		SendInput !{Tab}
		; AltTab()
		; Critical 0
	}
	SetTimer, MouseMotion, Off
	Return

#InputLevel


*Tab::
	MouseGetPos, x0, y0
	SetTimer, MouseMotion, 11
	Return
~*Tab Up::
	KeyWinSw:=0
	SetTimer, MouseMotion, Off
	If WinActive("Task View") {
		Send {LCtrl Up}{LWin Up}{Click}
	} Else If (A_PriorHotkey="*Tab")&&(A_PriorKey="Tab") {
		SendInput !{Tab}
	} Else {
		Send {LWin Up}
	} Return



MouseMotion:
	MouseGetPos, x1, y1
	If (!KeyWinSw)&&((abs(x1-x0)>mouseMoveThreshold)||(abs(y1-y0)>mouseMoveThreshold)) {
		Send {Tab Up}#{Tab}
		SetTimer, , Off
	} Return
	

Tab & BackSpace::Send +^p
Tab & e::SendInput ^n ; New Window
Tab & w::SendInput !{F4} ; Close Window


; Scrolling between desktops
#IfWinActive, Task View
WheelUp::Send #^{Left}
WheelDown::Send #^{Right}
#If GetKeyState("Space", "P") ; Doesn't work
WheelDown::Send {LShift Up}^#{Right}
WheelUp::Send ^#{Left}
#If GetKeyState("Tab", "P")
WheelDown::Send ^#{Right}
WheelUp::Send ^#{Left}
; #If GetKeyState("LShift", "P")
; WheelDown::Send {WheelRight}
; WheelUp::Send {WheelLeft}
#If
RAlt & F11::
~RButton & WheelUp::Send ^#{Left}
RAlt & F12::
~RButton & WheelDown::Send ^#{Right}

