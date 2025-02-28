*RButton::MButton
#If GetKeyState("Space", "P")
*RButton::Click
#If

*MButton::
	KeyWait, MButton, T.133
	Send % !ErrorLevel ? "#{Tab}" : "{RButton}"
	; If !ErrorLevel {
	; 	Send #{Tab}
	; } Else {
	; 	Send {RButton}
	; 	Loop {
	; 		Sleep 5
	; 	} Until !GetKeyState("MButton", "P")
	; 	Click
	; }
	Return


; Clipboard

~LButton & RButton:: ; Cut, Copy, Paste
	KeyWait, RButton, T.3
	If ErrorLevel
		Send ^x
	Else If GetKeyState("LButton", "P") {
		Send ^c
	} Else If !GetKeyState("LButton", "P") {
		Send ^v
	} Return

CapsLock & a::
	While GetKeyState("a", "P") {
		Send ^a
		Sleep 222
	} Return
CapsLock & s::
	KeyWait, s, T.2
	Send % !ErrorLevel ? "^c" : "^x"
	Return
CapsLock & d::
	KeyWait, d, T.2
	Send % !ErrorLevel ? "^v" : "+^v"
	Return

CapsLock & x:: ; Insert link
	Send ^k
	Sleep 200
	If GetKeyState("x", "P") {
		Send ^v
		Sleep 200
		Send {Enter}
	} Return

; Ditto
Esc::
	KeyWait, Esc, T.17
	Send % ErrorLevel ? "^{SC029}" : "{Esc}"
	Sleep 177
	; Keep pressed longer  —  opens groups either
	If GetKeyState("Esc", "P")
		Send {F7}
	Return
; Move to Group
#IfWinActive, Ditto
*RButton::Send +!y
#If