﻿; FL Studio

#IfWinActive, ahk_exe FL64.exe

1:: ; Navigate
	WinGetActiveTitle, NowAppTitle
	ControlGetFocus, FLControl, %NowAppTitle%
	MouseGetPos, , , AppUnderMouse
	WinGetClass, Playlist, ahk_id %AppUnderMouse%
	If (FLControl!="TQuickEdit1")&&(FLControl!="TQuickEdit5")&&(Playlist="TFruityLoopsMainForm") {
		ControlFocus, TEventEditForm1, ahk_class TFruityLoopsMainForm
		Send {LAlt Down}{Click, M, D}
		KeyWait, 1
		Send {LAlt Up}{Click, M, U}
	} Else {
		Send 1
	} Return
2:: ; Draw/Delete
	WinGetActiveTitle, NowAppTitle
	ControlGetFocus, FLControl, %NowAppTitle%
	MouseGetPos, , , AppUnderMouse
	WinGetClass, Playlist, ahk_id %AppUnderMouse%
	If (FLControl!="TQuickEdit1")&&(FLControl!="TQuickEdit5")&&(Playlist="TFruityLoopsMainForm") {
		ControlFocus, TEventEditForm1, ahk_class TFruityLoopsMainForm
		Send p
		Sleep 177
		If GetKeyState("2", "P")
		Send d{LButton Down}
		KeyWait, 2
		Send {LButton Up}p
	} Else {
		Send 2
	} Return
3:: ; Slice
	WinGetActiveTitle, NowAppTitle
	ControlGetFocus, FLControl, %NowAppTitle%
	MouseGetPos, , , AppUnderMouse
	WinGetClass, Playlist, ahk_id %AppUnderMouse%
	If (FLControl!="TQuickEdit1")&&(FLControl!="TQuickEdit5")&&(Playlist="TFruityLoopsMainForm") {
		ControlFocus, TEventEditForm1, ahk_class TFruityLoopsMainForm
		Send c{LShift Down}{LButton Down}
		KeyWait, 3
		Send {LButton Up}{LShift Up}p
	} Else {
		Send 3
	}  Return
4:: ; Cut
	WinGetActiveTitle, NowAppTitle
	ControlGetFocus, FLControl, %NowAppTitle%
	MouseGetPos, , , AppUnderMouse
	WinGetClass, Playlist, ahk_id %AppUnderMouse%
	If (FLControl!="TQuickEdit1")&&(FLControl!="TQuickEdit5")&&(Playlist="TFruityLoopsMainForm") {
		ControlFocus, TEventEditForm1, ahk_class TFruityLoopsMainForm
		Send c{LShift Down}{RButton Down}
		KeyWait, 4
		Send {RButton Up}{LShift Up}p
	} Else {
		Send 4
	} Return	
5:: ; Play/Mute
	WinGetActiveTitle, NowAppTitle
	ControlGetFocus, FLControl, %NowAppTitle%
	MouseGetPos, , , AppUnderMouse
	WinGetClass, Playlist, ahk_id %AppUnderMouse%
	If (FLControl!="TQuickEdit1")&&(FLControl!="TQuickEdit5")&&(Playlist="TFruityLoopsMainForm") {
		ControlFocus, TEventEditForm1, ahk_class TFruityLoopsMainForm
		Send y
		Sleep 177
		If GetKeyState("5", "P")
		Send t{LButton Down}
		KeyWait, 5
		Send {LButton Up}y
	} Else {
		Send 5
	} Return



F5::Send {F7} ; Piano roll
F6::Send {F6} ; Channel rack
F7::Send {F9} ; Mixer
F8:: ; Browser / Plugins
	KeyWait, F8, T.17
	Send % !ErrorLevel ? "!{F8}" : "{F8}"
	Return
F9::Send {F5} ; Playlist
F10:: ; Record. Long-press redoes the last recording. Files are kept on disk and removed from project
	; ControlSend, , r, Edison, Edison
	; Send {Space}
	KeyWait, F10, T.2
	SetKeyDelay, 5, 11
	If !ErrorLevel {
		Send r
	} Else {
		Send r{Space}
		Sleep 111
		Send ^z
		Send r
	} Return


LButton & F8::GoSub AddPlugin ; Add Plugin

AddPlugin:
	KeyWait, LButton
	CoordMode, Mouse, Relative
	MouseMove, 11, 11, 0
	Send {Click}{Down 6}
	Sleep 11
	Send {Enter}
	WinWaitActive, Confirm, , 3
	Send {Enter}
	Return

AddDeletePlugin:
	MouseGetPos, x0, y0
	Click
	MouseGetPos, , , WinUnderMouse
	WinGet, WinID, ID, WinUnderMouse
	GoSub, AddPlugin
	WinActivate, ahk_id %WinID%
	GoSub RemovePlugin
	WinWaitActive, ahk_class TSampleListForm, , 3
	Send ^{Up}
	MouseMove, x0, y0
	Return
	

LButton & F6::
Browser_Home::GoSub RemovePlugin ; Remove Plugin
RemovePlugin:	
	KeyWait, LButton
	CoordMode, Mouse, Relative
	MouseMove, 11, 11
	Send {Click}e
	Return

Space & F6:: ; Reset Mixer Inserts
	CoordMode, Mouse, Relative
	MouseMove, 11, 11
	Send {Click}f{Home}{Down 3}{Enter}
	Return


; Scroll between markers
CapsLock & WheelUp::Send {Media_Prev}
CapsLock & WheelDown::Send {Media_Next}
Insert::!t ; Add a Marker

#IfWinActive, ahk_exe PluginManager.exe
F5:: ; Find New Plugins
	CoordMode, Mouse, Relative
	MouseGetPos, x0, y0
	Click, 177, 60
	MouseMove, x0, y0
	Return
#If


; Scaling
RWin & 1::1
RWin & 2::2
RWin & 3::3
RWin & 4::4
RWin & 5::5
RWin & 6::6
RWin & 7::7



#IfWinActive

