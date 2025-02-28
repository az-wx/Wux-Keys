#SingleInstance, Force
#UseHook 1
#InstallMouseHook
#InstallKeybdHook

SetCapsLockState, AlwaysOff
SetNumLockState, AlwaysOff

SetTitleMatchMode 2

CoordMode, Mouse, Screen

mouseMoveThreshold:=22

SetWorkingDir, %A_Script_Dir%
Menu, Tray, Icon, .ico\'.ico ; Tray Icon
Menu, Tray, Tip, •
Menu, Tray, Click, 1

Menu, Tray, Add, History
Menu, Tray, Add, WinSpy, WindowSpy
Menu, Tray, Add, Help
Menu, Tray, Add, Exit
Menu, Tray, Add, Freeze
Menu, Tray, Default, Freeze
Menu, Tray, NoStandard


SetTimer, CenterWindow, 33

Hotkey, !F6, Freeze


#Include, *i %A_ScriptDir%\MClip.ahk
#Include, *i %A_ScriptDir%\Navi.ahk
#Include, *i %A_ScriptDir%\Lang.ahk
#Include, *i %A_ScriptDir%\Utils.ahk
#Include, *i %A_ScriptDir%\FLKeys.ahk


F6:: ; -Rename   —New Folder
	KeyWait, F6, T.2
	Send % !ErrorLevel ? "{F2}" : "+^n"
	Return
	
	
; LCtrl & Tab
*CapsLock::Send {LCtrl Down} 
~*CapsLock Up::
	Send {LCtrl Up}
	If GetKeyState("Space", "P") {
		Send +{Tab}
	} Else If (A_PriorKey="CapsLock")&&(A_PriorHotkey="*CapsLock") {
		Send {Tab}
	} Return


~Space & Tab:: ; Search / Replace
	If GetKeyState("LButton", "P") {
		SearchSelection:=1
	}
	KeyWait, Tab, T0.2
	Send % !ErrorLevel ? "^f" : "^h"
	If SearchSelection {
		Send !l
	}
	Return


; Comfy keys
CapsLock & \::Send +^s ; Save

SC056::Send ^z ; Undo
Space & SC056::Send % WinActive("ahk_exe FL64.exe") ? "!^z" : "+^z" ; Redo
RAlt & F10::Volume_Mute
RAlt & /::Send ^{/} ; Coment out
F12::PrintScreen

#InputLevel 2

-:: ; Short = '-' | Long = '  —  '
	SendLevel 1
	Send {-}
	KeyWait, -, T0.2
	If ErrorLevel
		GoSub, longdash
	Return

*Space:: ; Short = Space | Long = Shift
	SendLevel 0
	Send {LShift DownR}
	Thread, Interrupt
	Keywait, Space
	Send {LShift Up}
	If (A_TimeSinceThisHotkey<188)&&(A_PriorKey!="BackSpace")&&(A_PriorKey!="CapsLock") { ; &&(A_PriorKey!="\")
		SendLevel 1
		Send {Space}
	} Else If (A_Priorkey="LButton") {
		Send ^c
	} Else If (A_Priorkey="RButton") {
		Send ^v
	}
	Return

*BackSpace:: ; Enter
	SendLevel 0
	KeyWait, BackSpace, T.15
	; GoSub, NewTabWindow
	If WinActive("Task View")
		Send {F2}{End} ; Rename Desktop
	Else If WinActive("Save ahk_class #32770")&&!ErrorLevel
		Send {Enter} ; Save File
	Else If WinActive("ahk_class #32770")&&!ErrorLevel {
		ControlFocus, Button2
		Send {Enter}
	} Else If ErrorLevel&&(WinActive("Double Commander")||WinActive("ahk_exe Explorer.EXE")) {
		SendInput {F2} ; Explorer Rename
	} Else If ErrorLevel&&WinActive("ahk_group Browsers") {
		Send ^l
	} Else If ErrorLevel&&WinActive("Code") {
		Send {Esc}{Home}+^]
	} Else If GetKeyState("CapsLock", "P")&&WinActive("Google Translate — Mozilla Firefox") {
		Send +^s ; Swap translation direction
	} Else If GetKeyState("CapsLock", "P") {
		SendLevel 1
		Send ^{Enter}
	} Else If !GetKeyState("CapsLock", "P") {
		SendLevel 1
		Send {Enter}
	}	Return


*Enter:: ; BackSpace
	SendLevel 0
	While GetKeyState("Enter", "P") {
		If GetKeyState("LAlt", "P") {
			Send % (A_TimeSincePriorHotkey<155) ? "^w" : "+^t"
			Sleep 188
		} Else {
			SendLevel 1
			Send {BackSpace}
		}
		Sleep 88
	}
	Return

*Delete:: ; Delete / Esc
	SendLevel 0
	KeyWait, Delete, T.2
	Send % ErrorLevel ? "{Esc}" : "{Delete}"
		; CoordMode, Mouse, Relative
		; MouseMove, 11, 11
		; Send {Click}e
	Return

; The final and incredible fix
#InputLevel 1
longdash:
	SendLevel 1
	Send {BackSpace}  `—  `
	Return
#InputLevel 0

; Function Togglers
XKeys:
	Return

Freeze:
	Suspend, Toggle
	If (A_IsSuspended) {
		Menu, Tray, Icon, %A_ScriptDir%\.ico\....ico, , 1
		; SetSystemCursor("Arrow") ; AppStarting, Arrow, Cross, Help, IBeam, Icon, No, Size, SizeAll, SizeNESW, SizeNS, SizeNWSE, SizeWE, UpArrow, Wait, Unknown
		; SetTimer, DialogResponse, Off
		; PostMessage, 0x0111, 65305,,, F-Clip.ahk - AutoHotkey  ; Suspend.
		; Pause 1
	} Else {
		;Pause 0
		Menu, Tray, Icon, %A_ScriptDir%\.ico\'.ico, , 1
		; RestoreCursor()
		; SetTimer, DialogResponse, On
		; PostMessage, 0x0111, 65305,,, F-Clip.ahk - AutoHotkey  ; Suspend.
		GoSub, TestScript
	} Return
Exit:
	ExitApp
	Return
TestScript:
	SendLevel 0
	SetTitleMatchMode 2
	If WinActive("Code")&&WinActive(".ahk") {
		Send ^k^1
		If WinExist(" .ahk")
			WinClose, .ahk
	}
	Sleep 111
	; Send {LWin Up}{Alt Up}{Ctrl Up}{Shift Up}
	Reload
	Return