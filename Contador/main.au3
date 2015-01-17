#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=E:\Documents and Settings\IASD - NEW ALMEIDA\Meus documentos\IASDapps\count\Form1.kxf
$Form1 = GUICreate("IASD Count", 186, 68, 283, 215)
GUISetOnEvent($GUI_EVENT_CLOSE, "saidaqui")
GUISetIcon("E:\Documents and Settings\IASD - NEW ALMEIDA\Desktop\oracao_intercessoria\resources\iasd.ico")
$numero = GUICtrlCreateInput("", 8, 8, 57, 21, BitOR($ES_AUTOHSCROLL,$ES_NUMBER))
$poronde = GUICtrlCreateCombo("", 72, 8, 105, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Decrescer|Incrementar")
$Button1 = GUICtrlCreateButton("Iniciar!", 72, 32, 57, 25, 0)
GUICtrlSetOnEvent(-1, "iniciar")
$Button2 = GUICtrlCreateButton("Parar", 136, 32, 41, 25, 0)
GUICtrlSetOnEvent(-1, "parar")
$contagemminha = GUICtrlCreateLabel("00", 8, 32, 54, 22, $SS_CENTER, $WS_EX_CLIENTEDGE)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

#Region ### START Koda GUI section ### Form=E:\Documents and Settings\IASD - NEW ALMEIDA\Meus documentos\IASDapps\count\Form2.kxf
$Form2 = GUICreate("IASD Count", 330, 210, (@DesktopWidth/2)-(330/2), (@DesktopHeight/2)-(210/2), BitOR($WS_MINIMIZEBOX,$WS_POPUP,$WS_GROUP,$WS_CLIPSIBLINGS))
GUISetOnEvent($GUI_EVENT_CLOSE, "Form2Close")
$contagemdeles = GUICtrlCreateLabel("00", 8, 8, 314, 194, $SS_CENTER)
GUICtrlSetFont(-1, 128, 400, 0, "Arial")
GUICtrlSetOnEvent(-1, "contagemdelesClick")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	Sleep(100)
WEnd

Func iniciar()
	If GUICtrlRead($numero) = 0 Then Return 0
	If GUICtrlRead($poronde) = "Decrescer" Then
		GUICtrlSetData($contagemminha, GUICtrlRead($numero))
		GUICtrlSetData($contagemdeles, GUICtrlRead($numero))
	Else
		GUICtrlSetData($contagemminha, 0)
		GUICtrlSetData($contagemdeles, 0)
	EndIf
	AdlibRegister("mainfunc", 1000)
EndFunc
Func parar()
	AdlibUnRegister("mainfunc")
EndFunc

Func saidaqui()
	Exit
EndFunc

Func mainfunc()
	$atual = GUICtrlRead($contagemminha)
	$modo = GUICtrlRead($poronde)
	$maximo = GUICtrlRead($numero)
	If $modo = "Decrescer" Then
		$atual = $atual - 1
		GUICtrlSetData($contagemminha, $atual)
		GUICtrlSetData($contagemdeles, $atual)
		If $atual = 0 Then AdlibUnRegister()
	Else
		$atual = $atual + 1
		GUICtrlSetData($contagemminha, $atual)
		GUICtrlSetData($contagemdeles, $atual)
		If $atual = $maximo Then AdlibUnRegister()
	EndIf
	
EndFunc