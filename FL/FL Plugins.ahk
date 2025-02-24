
; Scan already present items
Loop, Files, C:\Users\azowux\Documents\Image-Line\FL Studio\Presets\Plugin database\Effects\*, FR
{
   If (InStr(A_LoopFileName, ".nfo")=0)&&(InStr(A_LoopFileName, ".png")=0)&&(InStr(A_LoopFileName, "(Mono)")=0)&&(InStr(A_LoopFileName, "Mono.")=0)
      FileAppend, %A_LoopFileName%`n, FLEffects.txt
}
Loop, Files, C:\Users\azowux\Documents\Image-Line\FL Studio\Presets\Plugin database\X\*, FR
{
   If (InStr(A_LoopFileName, ".nfo")=0)&&(InStr(A_LoopFileName, ".png")=0)&&(InStr(A_LoopFileName, "(Mono)")=0)&&(InStr(A_LoopFileName, "Mono.")=0)
      FileAppend, %A_LoopFileName%`n, FLEffects.txt
}

; Scan effects in default folder
Loop, Files, C:\Users\azowux\Documents\Image-Line\FL Studio\Presets\Plugin database\Installed\Effects\*, FR
{
   If (InStr(A_LoopFileName, ".nfo")=0)&&(InStr(A_LoopFileName, ".png")=0)&&(InStr(A_LoopFileName, "(Mono)")=0)&&(InStr(A_LoopFileName, "Mono.")=0)
      FileAppend, %A_LoopFileName%`n, FLInstalled.txt
}

