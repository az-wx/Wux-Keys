#SingleInstance, Force
#NoTrayIcon
#NoEnv

SetTitleMatchMode 2
DetectHiddenWindows On

SetTimer, SkipWindows, 111
SetTimer, CenterWindow, 111
SetTimer, FLPluginsSearch, On


SkipWindows:
	Gosub, SkipUpdate
	WinWaitActive, Windows Security ahk_class #32770
	ControlSend, Button1, {Tab 2}{Space}
	Return

SkipUpdate:
	WinWait, Update ahk_class PX_WINDOW_CLASS
	WinClose, Update
	Return


CenterWindow:
	WinGetActiveTitle, NowWinTitle
	WinGetClass, NowWinClass, %NowWinTitle%, , Properties
	If InStr(NowWinClass, "#32770") {
		; If InStr(NowWinTitle, "Open") {
			WinGet, NowWinID, ID, %NowWinTitle%
			CenterWindow("ahk_id" . NowWinID)
		; }
	} Return

CenterWindow(NowWinTitle) {
    WinGetPos,,, Width, Height, %NowWinTitle%
    WinMove, %NowWinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
	Return
}

FLPluginsSearch:
	SetTimer, , Off
	WinWaitActive, ahk_class TFLStudioPluginScannerMainForm
	ControlFocus, TQuickEdit1
	Sleep 5555
	SetTimer, , On
	Return

; RAlt & `::Gosub, CopyURLtoOneNote

; CopyURLtoOneNote:
; 	clipSleep:=1111
; 	Send ^c
; 	Sleep %clipSleep%
; 	JobTitle:=Clipboard
	
	
