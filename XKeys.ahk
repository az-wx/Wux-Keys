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

Menu, Tray, NoStandard

Menu, X Keys, Add, History
Menu, X Keys, Add, WinSpy, WindowSpy
Menu, X Keys, Add, Help

Menu, Tray, Add, X Keys, :X Keys

Menu, Tray, Add, M Clip, MClip
If FileExist("MClip.ahk")
	Menu, Tray, Check, M Clip 
Menu, Tray, Add, Navi, Navi
If FileExist("Navi.ahk")
	Menu, Tray, Check, Navi
Menu, Tray, Add, Lang, Lang
If FileExist("Lang.ahk")
	Menu, Tray, Check, Lang
Menu, Tray, Add, Utils, Utils
If FileExist("Utils.ahk")
	Menu, Tray, Check, Utils
Menu, Tray, Add, FL Keys, FLKeys
If FileExist("FLKeys.ahk")
	Menu, Tray, Check, FL Keys
Menu, Tray, Add, Freeze, Freeze
Menu, Tray, Default, Freeze
Menu, Tray, Add, Exit, Exit





SetTimer, FLDialogSkipper, 15
SetTimer, CenterWindow, 15
; SetTimer, CheckExplorer, 222

Hotkey, *F6, Freeze

FuncToggler(func) {
	If !FileExist("\.Off\") {
		FileCreateDir, .Off\
	}
	If FileExist(func . ".ahk") {
		FileMove, %func%.ahk, .Off\%func%.ahk
	} Else {
		FileMove, .Off\%func%.ahk, %func%.ahk
	}
	GoSub, TestScript
	Return
}

#Include, *i %A_ScriptDir%\MClip.ahk
#Include, *i %A_ScriptDir%\Navi.ahk
#Include, *i %A_ScriptDir%\Lang.ahk
#Include, *i %A_ScriptDir%\Utils.ahk
#Include, *i %A_ScriptDir%\FLKeys.ahk





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
	KeyWait, Tab, T0.2
	Send % !ErrorLevel ? "^f" : "^h"
	Return


; Comfy keys
CapsLock & \::Send +^s ; Save
Space & F6::Send +^n ; New folder
SC056::Send ^z ; Undo
Space & SC056::Send % WinActive("ahk_exe FL64.exe") ? "!^z" : "+^z" ; Redo
RAlt & F10::Volume_Mute
^F12::Send {F2} ; Rename
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




XKeys:
	GoSub, History
	Return
MClip:
	FuncToggler("MClip")
	Return
Navi:
	FuncToggler("Navi")
	Return

Lang:
	FuncToggler("Lang")
	Return
Utils:
	FuncToggler("Utils")
	Return
FLKeys:
	FuncToggler("FLKeys")
	Return
FLPlugins:
	Run, %A_WorkingDir%\FL\
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


CheckPluginDirectory:
	Run,	%A_ScriptDir%\FL\CheckPluginDirectory.ahk
	Return
CheckNewPlugins:
	Run,	%A_ScriptDir%\FL\CheckNewPlugins.ahk
	Return
CleanXPluginDirectory:
	Run,	%A_ScriptDir%\FL\CleanXPluginDirectory.ahk
	Return
FLInstalled:
	Run,	%A_ScriptDir%\FL\FLInstalled.ahk
	Return

