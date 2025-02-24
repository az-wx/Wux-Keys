RAlt & 3:: ; Window Spy
	GoSub, WindowSpy
	Return
RAlt & 4:: ; History
	GoSub, History
	Return
RAlt & 5:: ; Help
	GoSub, Help
	Return

WindowSpy:
	Run "C:\Program Files\AutoHotkey\WindowSpy.ahk"
	WinWait, Window Spy
	CoordMode, Mouse, Screen
	WinMove, Window Spy, , 1450, 250
	WinActivate
	Sleep 5
	Send {Space}
	Return

History:
	Send {LShift Up}
	Sleep 11
	KeyHistory
	WinWaitActive, C:\Users\azowux\OneDrive\Wux-Keys\XKeys.ahk - AutoHotkey v1.1.37.01
	WinMove, , , 330, 200, 1200, 800
	Send {F5}
	Return

Help:
	Run "C:\Program Files\AutoHotkey\AutoHotkey.chm"
	WinWaitActive, AutoHotkey Help
	Send #{Up}
	Return



SetSystemCursor(Cursor := "", cx := 0, cy := 0) {

	SystemCursors := "32512IDC_ARROW,32513IDC_IBEAM,32514IDC_WAIT,32515IDC_CROSS,32516IDC_UPARROW"
	. ",32642IDC_SIZENWSE,32643IDC_SIZENESW,32644IDC_SIZEWE"
	. ",32645IDC_SIZENS,32646IDC_SIZEALL,32648IDC_NO,32649IDC_HAND,32650IDC_APPSTARTING,32651IDC_HELP"

	if (Cursor = "") {
		VarSetCapacity(AndMask, 128, 0xFF), VarSetCapacity(XorMask, 128, 0)

		Loop Parse, SystemCursors, % ","
		{
			CursorHandle := DllCall("CreateCursor", "ptr", 0, "int", 0, "int", 0, "int", 32, "int", 32, "ptr", &AndMask, "ptr", &XorMask, "ptr")
			DllCall("SetSystemCursor", "ptr", CursorHandle, "int", SubStr(A_LoopField, 1, 5)) ; calls DestroyCursor
		}
		return
	}

	if (Cursor ~= "i)(AppStarting|Arrow|Cross|Hand|Help|IBeam|Icon|No|Size|SizeAll|SizeNESW|SizeNS|SizeNWSE|SizeWE|UpArrow|Wait)") {
		Loop Parse, SystemCursors, % ","
		{
			CursorName := SubStr(A_LoopField, 6) ; get the cursor name
			CursorID := SubStr(A_LoopField, 1, 5) ; get the cursor id
		} until (CursorName ~= "i)" Cursor)

		if !(CursorShared := DllCall("LoadCursor", "ptr", 0, "ptr", CursorID, "ptr"))
			throw Exception("Error: Invalid cursor name")

		Loop Parse, SystemCursors, % ","
		{
			CursorHandle := DllCall("CopyImage", "ptr", CursorShared, "uint", 2, "int", cx, "int", cy, "uint", 0, "ptr")
			DllCall("SetSystemCursor", "ptr", CursorHandle, "int", SubStr(A_LoopField, 1, 5)) ; calls DestroyCursor
		}
		return
	}

	if FileExist(Cursor) {
		SplitPath, Cursor,,, Ext ; auto-detect type
		if !(uType := (Ext = "ani" || Ext = "cur") ? 2 : (Ext = "ico") ? 1 : 0)
			throw Exception("Error: Invalid file type")

		if (Ext = "ani") {
			Loop Parse, SystemCursors, % ","
			{
				CursorHandle := DllCall("LoadImage", "ptr", 0, "str", Cursor, "uint", uType, "int", cx, "int", cy, "uint", 0x10, "ptr")
				DllCall("SetSystemCursor", "ptr", CursorHandle, "int", SubStr(A_LoopField, 1, 5)) ; calls DestroyCursor
			}
		} else {
			if !(CursorShared := DllCall("LoadImage", "ptr", 0, "str", Cursor, "uint", uType, "int", cx, "int", cy, "uint", 0x00008010, "ptr"))
				throw Exception("Error: Corrupted file")

			Loop Parse, SystemCursors, % ","
			{
				CursorHandle := DllCall("CopyImage", "ptr", CursorShared, "uint", 2, "int", 0, "int", 0, "uint", 0, "ptr")
				DllCall("SetSystemCursor", "ptr", CursorHandle, "int", SubStr(A_LoopField, 1, 5)) ; calls DestroyCursor
			}
		}
		return
	}

	throw Exception("Error: Invalid file path or cursor name")
}

RestoreCursor() {
	static SPI_SETCURSORS := 0x57
	return DllCall("SystemParametersInfo", "uint", SPI_SETCURSORS, "uint", 0, "ptr", 0, "uint", 0)
}

CenterWindow:
	WinGetActiveTitle, NowWinTitle
	If (NowWinTitle="Open ahk_class #32770")||(NowWinTitle="File Upload")
	CenterWindow(NowWinTitle)
	Return

CenterWindow(WinTitle)
	{
	WinGetPos,,, Width, Height, %WinTitle%
	WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
	}


   ; Since Windows OS always opens new directories in new windows, soon there're a lot. This makes sure there's only one window, everything else gets closed automatically
CheckExplorer:
	SetTimer, CheckExplorer, Off
		WinGet, thisID, ID, A
	WinGet, count, Count, ahk_class CabinetWClass
	If (count>1) {
		; SplashTextOn, , , BYE, BYE
		WinGet, toKill, IDLast, ahk_class CabinetWClass
		; WinGetTitle, address, A
		; WinGet, thisID, IDLast, ahk_class CabinetWClass
		; ClipSave:=ClipboardAll
		; ClipWait
		WinGet, thisID, IDLast, ahk_class CabinetWClass
		WinClose, ahk_id %toKill%
		; WinKill, ahk_id %toKill%
		WinActivate, ahk_id %thisID%
		;MsgBox, %address%
			; SetKeyDelay, 20, 10
			; Send ^t!d^v{Enter}
			; Clipboard:=ClipSave
	}
	SetTimer, CheckExplorer, 222
	Return
