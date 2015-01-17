#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Sorteio CONTROLE", 186, 185, 397, 323)
GUISetOnEvent($GUI_EVENT_CLOSE, "fechar")
$Label1 = GUICtrlCreateLabel("Mínimo", 0, 8, 39, 17)
$min = GUICtrlCreateInput("0", 0, 32, 97, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label2 = GUICtrlCreateLabel("Máximo", 0, 72, 40, 17)
$max = GUICtrlCreateInput("", 0, 96, 97, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$sorteados = GUICtrlCreateList("", 104, 0, 81, 149)
$Button1 = GUICtrlCreateButton("Sortear", 0, 152, 159, 25)
GUICtrlSetOnEvent(-1, "sortear")
GUICtrlCreateButton("Bal", 160, 152, 29, 25)
GUICtrlSetOnEvent(-1, "balanca")
$fakechk = GUICtrlCreateCheckbox("Fake", 0, 128, 49, 17)
$fakeNum = GUICtrlCreateInput("", 56, 128, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
#Region ### START Koda GUI section ### Form=
$Form2 = GUICreate("Sorteio DISPLAY", 300, 223, (@DesktopWidth/2)-150, -1, $WS_POPUP)
$contar = GUICtrlCreateLabel("", 8, 0, 286, 213, $SS_CENTER)
GUICtrlSetFont(-1, 130, 400, 0, "Tahoma")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	Sleep(100)
WEnd

Func sortear()
   If GUICtrlRead($fakechk) = 1 Then
	  GUICtrlSetData($contar, GUICtrlRead($fakeNum))
	  _GUICtrlListBox_AddString($sorteados, String($fakeNum))
	  MsgBox(0, "Sorteio", "Número sorteado: " & $fakeNum)
   Else
	  $num_min = GUICtrlRead($min)
	  $num_max = GUICtrlRead($max)
	  $possiveis = $num_max-$num_min
	  ; NÃO TIRE o -1. não sei como, mas isso faz tudo funcionar...
	  If Int(_GUICtrlListBox_GetCount($sorteados))-1 = $possiveis Then
		 MsgBox(0, "Sorteio", "Todos os números já foram sorteados.")
		 Return 0
	  EndIf
	  $sorteado = Random($num_min, $num_max, 1)
	  While _GUICtrlListBox_FindString($sorteados, String($sorteado), True) <> -1
		 $sorteado = Random($num_min, $num_max, 1)
	  WEnd
	  GUICtrlSetData($contar, $sorteado)
	  _GUICtrlListBox_AddString($sorteados, String($sorteado))
	  MsgBox(0, "Sorteio", "Número sorteado: " & $sorteado, 2)
   EndIf
EndFunc
Func fechar()
   Exit
EndFunc

Func balanca()
   $originalpos = WinGetPos("Sorteio DISPLAY")
   For $i = 0 To 2
	  $rand_w = $originalpos[0]+Random(-100, 100, 1)
	  $rand_h = $originalpos[1]+Random(-100, 100, 1)
	  WinMove("Sorteio DISPLAY", "", $rand_w, $rand_h, $originalpos[2], $originalpos[3], 2)
   Next
   WinMove("Sorteio DISPLAY", "", $originalpos[0], $originalpos[1], $originalpos[2], $originalpos[3], 2)
EndFunc