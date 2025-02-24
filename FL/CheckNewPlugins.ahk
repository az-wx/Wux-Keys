FileRead, FLEffects, C:\O\FLEffects.txt
Loop, Read, C:\O\FLInstalled.txt
{
   fileName:=A_LoopReadLine
   If InStr(FLEffects, fileName)=0
      FileAppend, %filename%`n, C:\O\FLNew.txt
}
Return