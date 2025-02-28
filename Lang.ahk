
SetKeyDelay, 11, 11

:*:~~:: ; TimeStamp
	SendInput ` %A_DD%.%A_MM%` |` %A_Hour%●%A_Min% `
	Return
:*:~``:: ; Datestamp
	SendInput ` %A_DD%.%A_MM%`
	Return

:*:**::×

; Deutsch ümlaut
:?*:a``::ä
:?*:o``::ö
:?*:u``::ü
:?*:s``::ß


:*:g,::greetings, `

::gsade::gta san andreas definitive edition


SetKeyDelay


RShift::#Space

Space & RShift:: ; Transliterate
	SendLevel 0
	While GetKeyState("RShift", "P") {
		Send +^{Left}
		Sleep 200
	}
	Transliterate()
	Send #{Space}
	;Language:=!Language
	;LanguageSwitch(Language)
	; DestroyToolTip(777)
	SetTimer, ModifiersUp
	Return

ModifiersUp:
		If GetKeyState("LAlt", "T")||GetKeyState("LAlt", "P")
			Send {LAlt Up}
		If GetKeyState("LCtrl", "T")||GetKeyState("LCtrl", "P")
			Send {LCtrl Up}
		If GetKeyState("LShift", "T")||GetKeyState("LShift", "P") ; Playing safer, since it is physically is pressed
			Send {LShift Up}	
		SetTimer, , Off
		Return

LanguageSwitch(Language) {
	BlockInput 1
	If Language {
		Send +!1
	} Else {
		Send +!0
	}
	BlockInput 0
	Sleep 55
	Return
}
Transliterate() {
	SendLevel 0
	NowClip:=Clipboard
	Cut()
	Loop {
		If (Clipboard!=NowClip)
		Break
	}
	transliterated:=transformTextLayout(Clipboard)
	Sleep 1
	SendInput %transliterated%
	Clipboard:=NowClip
	; NowClip:=""
	; transliterated:=""
	Return
}
transformTextLayout(textContainer) {
	en := "``qwertyuiop[]asdfghjkl;'zxcvbnm,./~@#$^&QWERTYUIOP{}ASDFGHJKL:""ZXCVBNM<>?"
	ru := "ёйцукенгшщзхъфывапролджэячсмитьбю.Ё""№;:?ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,"
	textContainer ~= "i)[a-z]" ? (layoutIn := en, layoutOut := ru) : (layoutIn := ru, layoutOut := en)
	Loop, Parse, textContainer
	{
		IfNotInString, layoutIn, %A_LoopField%
			newChar := A_LoopField
		Else
			StringReplace, newChar, A_LoopField, %A_LoopField%, % SubStr(layoutOut, InStr(layoutIn, A_LoopField, True), 1)
		outputStr .= newChar
	}Return outputStr
}

Cut(){
	Clipboard:=""
	If GetKeyState("LButton")
		Send {LButton Up}
	If WinActive("- OneNote")
		SendPlay ^x
	Else
		Send ^x
	ClipWait, , 1
	Return
}