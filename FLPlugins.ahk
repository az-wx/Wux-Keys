#SingleInstance, Force
#NoTrayIcon

SetWorkingDir, %A_ScriptDir%
FileCreateDir, FL\

; Collect installed plugins in default \Plugin database\Installed folder
Loop, Files, C:\Users\azowux\Documents\Image-Line\FL Studio\Presets\Plugin database\Installed\Effects\*, FR
{
   If (InStr(A_LoopFileName, ".nfo")=0)&&(InStr(A_LoopFileName, ".png")=0)&&(InStr(A_LoopFileName, "(Mono)")=0)&&(InStr(A_LoopFileName, "Mono.")=0)
      FileAppend, %A_LoopFileName%`n, FL\FLInstalled.txt
}


; Effects are divided into Mono and X folder. Mono is unneeded, X is the main

Loop, Files, C:\Users\azowux\Documents\Image-Line\FL Studio\Presets\Plugin database\Effects\*, FR
{
   If (InStr(A_LoopFileName, ".nfo")=0)&&(InStr(A_LoopFileName, ".png")=0)&&(InStr(A_LoopFileName, "(Mono)")=0)&&(InStr(A_LoopFileName, "Mono.")=0)
      FileAppend, %A_LoopFileName%`n, FL\FLEffects.txt
}
Loop, Files, C:\Users\azowux\Documents\Image-Line\FL Studio\Presets\Plugin database\X\*, FR
{
   If (InStr(A_LoopFileName, ".nfo")=0)&&(InStr(A_LoopFileName, ".png")=0)&&(InStr(A_LoopFileName, "(Mono)")=0)&&(InStr(A_LoopFileName, "Mono.")=0)
      FileAppend, %A_LoopFileName%`n, FL\FLEffects.txt
}


; Check new plugins: in case not present neither in FLEffects, nor in FLInstalled (where plugins get copied once processed), put them into FLNew
FileRead, FLEffects, \FL\FLEffects.txt
Loop, Read, FL\FLInstalled.txt
{
   fileName:=A_LoopReadLine
   If InStr(FLEffects, fileName)=0
      FileAppend, %filename%`n, FL\FLNew.txt
}










; If a plugin exists in Effects folder it means it's processed and shall be removed from X
NowTime:=A_TickCount
CountRemoved:=0
plugX=C:\Users\azowux\Documents\Image-Line\FL Studio\Presets\Plugin database\X\
Loop, Files, C:\Users\azowux\Documents\Image-Line\FL Studio\Presets\Plugin database\Effects\*, FR
{
   If FileExist(plugX . A_LoopFileName) {
         FileDelete, %plugX%%A_LoopFileName%
         CountRemoved++
      }
}
; FileDelete, \FL\FL*.txt
SpentTime:=A_TickCount-NowTime
MsgBox, , , Spent %SpentTime%ms | Removed %CountRemoved% plugins
FileRemoveDir, FL\, 1
Return
