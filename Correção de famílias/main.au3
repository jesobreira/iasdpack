#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#NoTrayIcon

Global $familiaId = 1

Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=E:\Documents and Settings\IASD - NEW ALMEIDA\Meus documentos\IASDapps\fixfamilies\Form1.kxf
$Form1 = GUICreate("Corrigir famílias - Oração Intercessória", 442, 178, (@DesktopWidth/2)-(442/2), (@DesktopHeight/2)-(178/2))
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "Form1Minimize")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "Form1Maximize")
GUISetOnEvent($GUI_EVENT_RESTORE, "Form1Restore")
$familia = GUICtrlCreateLabel("familia", 8, 16, 422, 49, $SS_CENTER)
GUICtrlSetFont(-1, 30, 400, 0, "Arial")
GUICtrlSetOnEvent(-1, "familiaClick")
$Label2 = GUICtrlCreateLabel("(e família)", 176, 80, 93, 27)
GUICtrlSetFont(-1, 15, 400, 0, "Arial")
GUICtrlSetOnEvent(-1, "Label2Click")
$Button1 = GUICtrlCreateButton("Sim", 16, 120, 201, 49, 0)
GUICtrlSetFont(-1, 15, 400, 0, "MS Sans Serif")
GUICtrlSetOnEvent(-1, "sim")
$Button2 = GUICtrlCreateButton("Não", 224, 120, 201, 49, 0)
GUICtrlSetFont(-1, 15, 400, 0, "MS Sans Serif")
GUICtrlSetOnEvent(-1, "nao")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
carregarfamilia()
While 1
	Sleep(100)
WEnd

Func familiaClick()

EndFunc
Func Form1Close()
	Exit
EndFunc
Func Form1Maximize()

EndFunc
Func Form1Minimize()

EndFunc
Func Form1Restore()

EndFunc
Func Label2Click()

EndFunc
Func nao()
	gravarFamilia($familiaId, "false", GUICtrlRead($familia))
	carregarfamilia()
EndFunc
Func sim()
	gravarFamilia($familiaId, "true", GUICtrlRead($familia))
	carregarfamilia()
EndFunc

Func carregarfamilia()
	;While True
		$fam_name = IniRead("familias.ini", $familiaId, "nome", "nono")
		$fam_status = IniRead("familias.ini", $familiaId, "status", "nono")
		If $fam_name = "nono" Then
			MsgBox(64,"Famílias","Registro corrigido com sucesso!")
			Exit
		EndIf
		If $fam_status = "true" Then
			$familiaId += 1
			GUICtrlSetData($familia, $fam_name)
			;ExitLoop
			Return 0
		Else
			$familiaId += 1
			gravarFamilia($familiaId, "false", $fam_name)
			carregarfamilia()
		EndIf
	;WEnd
EndFunc

Func gravarFamilia($fam, $sta, $nom)
	$fam -= 1
	IniWrite("new_familia.ini", $fam, "nome", $nom)
	IniWrite("new_familia.ini", $fam, "status", $sta)
	
EndFunc