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

#Include, *i %A_ScriptDir%\Tray.ahk
#Include, *i %A_ScriptDir%\MClip.ahk
#Include, *i %A_ScriptDir%\Navi.ahk
#Include, *i %A_ScriptDir%\Lang.ahk
#Include, *i %A_ScriptDir%\Utils.ahk
#Include, *i %A_ScriptDir%\FLKeys.ahk


F6::Send {F2} ; Rename
Space & F6::Send +^n ; New folder

; LCtrl & Tab
*CapsLock::Send {LCtrl Down} 
~*CapsLock Up::
	Send {LCtrl Up}
	If (A_PriorKey="CapsLock")&&(A_PriorHotkey="*CapsLock") {
		Send {Blind}{Tab}
	} Return


~Space & Tab:: ; Search / Replace
	If WinActive("ahk_exe PluginManager.exe") {
		ControlFocus, TQuickEdit1
	}
	If GetKeyState("LButton", "P") {
		SearchSelection:=1
	}
	KeyWait, Tab, T0.2
	; Send % !ErrorLevel ? "^f" : "^h"
	If !ErrorLevel {
		Send ^f
		Search:=1
	} Else {
		Send ^h
		SearchReplace:=1
	}
	If SearchSelection {
		Send !l
		SearchSelection:=0
	}
	Return


; Comfy keys
CapsLock & \::Send +^s ; Save

SC056::Send ^z ; Undo
Space & SC056::Send % WinActive("ahk_exe FL64.exe") ? "!^z" : "+^z" ; Redo
RAlt & F10::Volume_Mute
RAlt & /::Send ^{/} ; Coment out

F12::PrintScreen

~*LAlt:: ; File Info
	If WinActive("ahk_exe Explorer.EXE") {
		If (A_TimeIdleMouse<111) {
			Send !{Click}
		} Else {
			Send !{Enter}
		}
	} Return


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
	; Thread, Interrupt
	Keywait, Space
	Send {LShift Up}
	If (A_TimeSinceThisHotkey<188)&&(A_PriorKey!="BackSpace")&&(A_PriorKey!="CapsLock")&&(A_ThisHotkey="*Space") { 
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
	} Else If ErrorLevel&&WinActive("Code") {
		Send {Esc}{Home}+^]
	} Else If ErrorLevel&&(WinActive("Double Commander")||WinActive("ahk_exe Explorer.EXE")) {
		SendInput {F2} ; Explorer Rename
	} Else If ErrorLevel&&WinActive("ahk_group Browsers") {
		Send ^l
	} Else If GetKeyState("CapsLock", "P")&&WinActive("Google Translate — Mozilla Firefox") {
		Send +^s ; Swap translation direction
	} Else If GetKeyState("CapsLock", "P")&&WinActive("ahk_exe WindowsTerminal.exe") {
		; Send {Right}{End}
		; Sleep 11
		; Send {Enter}
		Send ^f{Enter}
	} Else If GetKeyState("CapsLock", "P")&&Search {
		GoSub, ModifiersUp
		Send !{F3}{Esc}
		Search:=0
	} Else If GetKeyState("CapsLock", "P")&&SearchReplace {
		GoSub, ModifiersUp
		Send !^{Enter}{Esc}
		SearchReplace:=0
	} Else If GetKeyState("CapsLock", "P") {
		SendLevel 1
		Send ^{Enter}
	} Else If !GetKeyState("CapsLock", "P") {
		SendLevel 1
		Send {Enter}
	} Return


*Enter:: ; BackSpace
	SendLevel 0
	While GetKeyState("Enter", "P") {
		If GetKeyState("CapsLock", "P") {
			If WinActive("ahk_exe WindowsTerminal.exe") {
				Send ^w
			} Else {
				Send ^{BackSpace}
			}
			Sleep 33
		} Else {
			SendLevel 1
			Send {BackSpace}
		}
		Sleep 88
	}
	Return

*Delete:: ; Delete / Esc
	SendLevel 0
	If GetKeyState("CapsLock", "P") {
		Send % WinActive("ahk_exe WindowsTerminal.exe") ? "{LCtrl Up}!d" : "^{Delete}"
	} Else {
		Send {Delete}
	}
	Sleep 111
	Return

; The final and incredible fix
#InputLevel 1
longdash:
	SendLevel 1
	Send {BackSpace}  `—  `
	Return
#InputLevel 0
