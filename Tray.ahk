
Menu, Tray, Icon, .ico\'.ico ; Tray Icon
Menu, Tray, Tip, •
Menu, Tray, Click, 1
Menu, Tray, Add, History
Menu, Tray , Icon, History, .ico\X.ico
Menu, Tray, Add, WinSpy, WindowSpy
Menu, Tray , Icon, WinSpy, .ico\Spy.ico
Menu, Tray, Add, Help
Menu, Tray , Icon, Help, .ico\Help.ico
Menu, Tray, Add, Exit
Menu, Tray , Icon, Exit, .ico\Exit.ico
Menu, Tray, Add, FL X, FLX
Menu, Tray , Icon, FL X, .ico\FL.ico
Menu, Tray, Add, WiFi
Menu, Tray , Icon, WiFi, .ico\wifi.ico 
Menu, Tray, Add, Freeze
Menu, Tray , Icon, Freeze, .ico\Snowflake.ico
Menu, Tray, Default, Freeze
Menu, Tray, NoStandard


Hotkey, !\, Freeze
Hotkey, RAlt & RWin, Freeze

Run Tools.ahk




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
    
FLX:
    Run FLPlugins.ahk
    Return
WiFi:
	Run, powershell.exe -noexit -file %A_ScriptDir%\ToggleWiFi.ps1
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
	GoSub, ModifiersUp
	; Send {LWin Up}{Alt Up}{Ctrl Up}{Shift Up}
	Reload
	Return