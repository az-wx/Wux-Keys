#SingleInstance, Force
#NoTrayIcon

SetWorkingDir, %A_ScriptDir%

; If a plugin exists in Effects folder it means it's processed and shall be removed from X
NowTime:=A_TickCount
CountRemoved:=0
plugEff=C:\Users\azowux\Documents\Image-Line\FL Studio\Presets\Plugin database\X\Effects\
Loop, Files, C:\Users\azowux\Documents\Image-Line\FL Studio\Presets\Plugin database\Effects\*, FR 
{
      If FileExist(plugEff . A_LoopFileName) {
         FileDelete, %plugEff%%A_LoopFileName%
         CountEffRemoved++
      }
}
plugGen=C:\Users\azowux\Documents\Image-Line\FL Studio\Presets\Plugin database\X\Generators\
Loop, Files, C:\Users\azowux\Documents\Image-Line\FL Studio\Presets\Plugin database\Generators\*, FR
{
      If FileExist(plugGen . A_LoopFileName) {
         FileDelete, %plugGen%%A_LoopFileName%
         CountGenRemoved++
      }
}
SpentTime:=A_TickCount-NowTime
MsgBox, , , Spent %SpentTime%ms | Removed %CountEffRemoved% Effects & %CountGenRemoved% Generators
Return
