#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

$sound_5min = False ; mude aqui
$sound_1min = True ; mude aqui
#cs
If FileExists(@ScriptDir & "\5min.mp3") Then $sound_5min = True
If Not FileExists(@ScriptDir & "\1min.mp3") Then $sound_1min = False
#ce
If WinExists("Relógio IASD") Then
   WinKill("Relógio IASD")
EndIf

#Region ### START Koda GUI section ### Form=
$left = (@DesktopWidth*2)-(@DesktopWidth/2)-(300/2) ; (@DesktopWidth*2)-(@DesktopWidth/2)-(300/2)
$Form1 = GUICreate("Escola Sabatina", 400, 223, $left, 235, $WS_POPUP)
$contar = GUICtrlCreateLabel("5:00", 8, 0, 386, 213, $SS_CENTER)
GUICtrlSetFont(-1, 130, 400, 0, "Tahoma")
GUISetState(@SW_SHOW)
WinSetOnTop("Escola Sabatina", "", 1)
#EndRegion ### END Koda GUI section ###
AdlibRegister("contar", 1000)
If $sound_5min Then SoundPlay(@ScriptDir & "\5min.mp3")
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd

Func contar()
   $atual = horaconvertback(GUICtrlRead($contar))
   $atual -= 1
   GUICtrlSetData($contar, horaconvert($atual))
   If $atual = 60 Then
	  AdlibRegister("piscar")
	  If $sound_1min Then SoundPlay(@ScriptDir & "\1min.mp3")
   ElseIf $atual = 0 Then
	  AdlibUnRegister("piscar")
	  AdlibUnRegister("contar")
	  Sleep(10000)
	  Exit
   EndIf
EndFunc

Func piscar()
   GUICtrlSetState($contar, $GUI_HIDE)
   Sleep(500)
   GUICtrlSetState($contar, $GUI_SHOW)
   Sleep(500)
EndFunc

Func horaconvert($segundos)
   $minutos = Floor($segundos/60)
   $segundos = Mod($segundos, 60)
   If StringLen($segundos) <> 2 Then $segundos = "0" & $segundos
   Return $minutos & ":" & $segundos
EndFunc

Func horaconvertback($hora)
   $hora = StringSplit($hora, ":")
   $minuto = Int($hora[1])
   $segundo = Int($hora[2])
   $transforma = $minuto*60
   $resultado = $transforma+$segundo
   If StringLen($resultado) < 2 Then $resultado = "0" & $resultado
   Return $resultado
EndFunc