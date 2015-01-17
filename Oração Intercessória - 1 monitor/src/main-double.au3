#cs
	Oração Intercessória
		coded by J. S.
#ce

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include <Array.au3>
#NoTrayIcon

Opt("GUIOnEventMode", 1)

If Not @compiled Then FileChangeDir("..\")
Global $sorteados_list[100]
#Region interfaces
; esta é a interface principal
#Region ### START Koda GUI section ### Form=E:\Documents and Settings\IASD - NEW ALMEIDA\Desktop\oracao_intercessoria\src\interface.kxf
$Form1 = GUICreate("Oração Intercessória - IASD Nova Almeida", 882, 591, 74, 91)
GUISetIcon("E:\Documents and Settings\IASD - NEW ALMEIDA\Desktop\oracao_intercessoria\resources\iasd.ico")
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "Form1Minimize")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "Form1Maximize")
GUISetOnEvent($GUI_EVENT_RESTORE, "Form1Restore")
$Group1 = GUICtrlCreateGroup("", 584, 8, 289, 521, $BS_CENTER, BitOR($WS_EX_TRANSPARENT,$WS_EX_STATICEDGE))
GUICtrlSetColor($Group1, 0xFFFFFF)
$aindanao = GUICtrlCreateEdit("", 591, 23, 273, 486, BitOR($ES_CENTER,$ES_AUTOVSCROLL,$ES_WANTRETURN,$WS_VSCROLL))
GUICtrlSetFont($aindanao, 26, 400, 0, "Arial Black")
GUICtrlSetOnEvent($aindanao, "aindanaoClick")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlSetState($Group1, $GUI_HIDE)
$jasorteados = GUICtrlCreateListView("Nº|Família", 8, 8, 569, 569)
;$jasorteados = _GUICtrlListView_Create($Form1, "No.|Família", 8, 8, 569, 569)
GUICtrlSendMsg($jasorteados, $LVM_SETCOLUMNWIDTH, 0, 50)
GUICtrlSendMsg($jasorteados, $LVM_SETCOLUMNWIDTH, 1, 500)
GUICtrlSetFont($jasorteados, 16, 400, 0, "Arial Black")
GUICtrlSetColor($jasorteados, 0x000000)
GUICtrlSetOnEvent($jasorteados, "jasorteadosClick")
$Group2 = GUICtrlCreateGroup("", 584, 528, 289, 49, $BS_CENTER)
GUICtrlSetColor($Group2, 0xFFFFFF)
$novafamilia = GUICtrlCreateInput("", 592, 536, 177, 38, BitOR($ES_CENTER,$ES_AUTOHSCROLL,$ES_NUMBER))
GUICtrlSetFont($novafamilia, 20, 400, 0, "Arial Black")
GUICtrlSetOnEvent($novafamilia, "novafamiliaChange")
$Button1 = GUICtrlCreateButton(">>", 776, 536, 89, 33, 0)
GUICtrlSetFont($Button1, 16, 400, 0, "Arial Black")
GUICtrlSetOnEvent($Button1, "botao_click")
;;HotKeySet("{ENTER}", "botao_click")
GUICtrlCreateGroup("", -99, -99, 1, 1)
#EndRegion ### END Koda GUI section ###

GUISetState(@SW_SHOW)

; esta outra interface é só para mostrar o número e a família
#Region ### START Koda GUI section ### Form=E:\Documents and Settings\IASD - NEW ALMEIDA\Desktop\oracao_intercessoria\resources\show_num_gui.kxf
$Form2 = GUICreate("Oração Intercessória - IASD Nova Almeida", 520, 268, @DesktopWidth + 240, 193)
GUISetIcon("E:\Documents and Settings\IASD - NEW ALMEIDA\Desktop\oracao_intercessoria\resources\iasd.ico")
GUISetOnEvent($GUI_EVENT_CLOSE, "Form2Close")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "Form2Minimize")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "Form2Maximize")
GUISetOnEvent($GUI_EVENT_RESTORE, "Form2Restore")
$Group12 = GUICtrlCreateGroup(" Estaremos orando por: ", 8, 8, 505, 217, BitOR($BS_CENTER,$BS_FLAT))
GUICtrlSetFont(-1, 16, 400, 0, "Arial Black")
$Label12 = GUICtrlCreateLabel("$NUM$", 176, 56, 175, 64)
GUICtrlSetFont(-1, 32, 400, 0, "Arial Black")
GUICtrlSetOnEvent(-1, "Label1Click")
$Label22 = GUICtrlCreateLabel("$nome$ e família", 16, 144, 493, 60, $SS_CENTER)
GUICtrlSetFont(-1, 30, 400, 0, "Arial Black")
GUICtrlSetOnEvent(-1, "Label2Click")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button12 = GUICtrlCreateButton("&Oração", 156, 232, 89, 25, 0)
GUICtrlSetOnEvent(-1, "oracao")
$Button13 = GUICtrlCreateButton("&Não está presente", 245, 232, 99, 25, 0)
GUICtrlSetOnEvent(-1, "naoesta")
;GUISetState(@SW_SHOW)
GUICtrlSetState($novafamilia, $GUI_FOCUS)
update()
#EndRegion ### END Koda GUI section ###
#endregion

; fim das interfaces; início funções

; funções para interface #1
#region i1
While 1
	Sleep(100)
WEnd

Func naoesta()
	$numero = GUICtrlRead($novafamilia)
	IniWrite("resources\familias.ini", $numero, "status", "false")
	GUISetState(@SW_HIDE, $Form2)
	clear()
EndFunc

Func aindanaoClick()

EndFunc
Func botao_click()
	If Not GUICtrlRead($novafamilia) Then Return 0
	sort(GUICtrlRead($novafamilia))
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
Func jasorteadosClick()

EndFunc
Func novafamiliaChange()

EndFunc

Func sort($num)
	Return setnumber($num)
EndFunc

Func clear()
	GUICtrlSetData($novafamilia, "")
EndFunc
#endregion



; funções para interface #2
#region i2
Func Button1Click()

EndFunc
Func Form2Close()
	Exit
	GUISetState(@SW_HIDE, $Form2)
	update()
EndFunc
Func Form2Maximize()

EndFunc
Func Form2Minimize()

EndFunc
Func Form2Restore()

EndFunc
Func Label1Click()

EndFunc
Func Label2Click()

EndFunc
Func oracao()
	ShellExecute("resources\musica.bat")
EndFunc
#endregion




; funções globais (ambas as interfaces)
#region ambas
Func setnumber($num) ; configura o número na janela show
	If IniRead("resources\familias.ini", $num, "status", "error") = "true" Then
		Dim $iMsgBoxAnswer
		$iMsgBoxAnswer = MsgBox(53,"Aviso","Esta família já foi selecionada.")
		Select
		   Case $iMsgBoxAnswer = 4 ;Retry
				Return 0
		   Case $iMsgBoxAnswer = 2 ;Cancel
				; do nothing
		EndSelect
	EndIf
	$nome = IniRead("resources\familias.ini", $num, "nome", "<error>") & " e família"
	GUICtrlSetData($Label22, $nome)
	GUICtrlSetData($Label12, $num)
	IniWrite("resources\familias.ini", $num, "status", "true")
	GUISetState(@SW_SHOW, $Form2)
EndFunc

Func update()
	;Return 0 ; remove this
	#cs
	todo: em caso true, apenas usar4 _GUICtrlListView_AddItem() e _GUICtrlListView_AddSubItem() para listar os que ja foram
	compilar e pronto
	#ce
	
	For $delete In $sorteados_list
		GUICtrlDelete($delete)
		_ArrayDelete($sorteados_list, $delete)
	Next
	
	$familias = IniReadSectionNames("resources\familias.ini")
	;_ArrayDisplay($familias)
	;Return 0
	For $i = 1 To $familias[0]
		$resp = IniRead("resources\familias.ini", $i, "status", "error")
		If $resp = "true" Then
			; família já sorteada
			;_GUICtrlListView_AddItem($jasorteados, $i, $i)
			;_GUICtrlListView_AddSubItem($jasorteados, $i, IniRead("resources\familias.ini", $i, "nome", "error"), 1)
			$nome = IniRead("resources\familias.ini", $i, "nome", "error")
			$id = GUICtrlCreateListViewItem($i & "|" & $nome, $jasorteados)
			_ArrayAdd($sorteados_list, $id)
		Else
			; não sorteada, ainda
 			GUICtrlSetData($aindanao, GUICtrlRead($aindanao) & "  " & $i)
		EndIf
	Next
EndFunc

#endregion