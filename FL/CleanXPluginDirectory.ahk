







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
FileDelete, C:\O\FL*.txt
SpentTime:=A_TickCount-NowTime
MsgBox, , , Spent %SpentTime%ms | Removed %CountRemoved% plugins
Return