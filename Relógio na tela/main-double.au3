#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#Region ### START Koda GUI section ### Form=
$left = (@DesktopWidth*2)-(@DesktopWidth/2)-(800/2) ; (@DesktopWidth*2)-(@DesktopWidth/2)-(300/2)
$Form1 = GUICreate("Relógio IASD", 800, 223, $left, 235, $WS_POPUP)
$contar = GUICtrlCreateLabel(@HOUR & ":" & @MIN & ":" & @SEC, 8, 0, 800-8, 213, $SS_CENTER)
GUICtrlSetFont(-1, 130, 400, 0, "Tahoma")
GUISetState(@SW_SHOW)
WinSetOnTop("Relógio IASD", "", 1)
#EndRegion ### END Koda GUI section ###
AdlibRegister("contar", 1000)
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd

Func contar()
   GUICtrlSetData($contar, @HOUR & ":" & @MIN & ":" & @SEC)
EndFunc

