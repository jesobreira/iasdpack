#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include "lib.au3"

Opt("GUIOnEventMode", 1)
Opt("GUICloseOnEsc", 0)
#Region ### Controle
$controle = GUICreate("Controle do Placar - IASD Nova Almeida", 426, 386, 241, 220)
GUISetIcon("C:\WINDOWS\system32\shell32.dll", 114)
GUISetOnEvent($GUI_EVENT_CLOSE, "controleClose")
$icList = GUICtrlCreateListView("Participante|Pontos", 8, 8, 321, 329)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 250)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 50)
GUICtrlSetOnEvent(-1, "icListClick")
$Button1 = GUICtrlCreateButton("Adicionar participante", 8, 344, 113, 33, 0)
GUICtrlSetOnEvent(-1, "addPlayer")
$Button2 = GUICtrlCreateButton("Remover participante", 120, 344, 105, 33, 0)
GUICtrlSetOnEvent(-1, "delPlayer")
$Button8 = GUICtrlCreateButton("Editar participante", 224, 344, 105, 33, 0)
GUICtrlSetOnEvent(-1, "editPlayer")
$Group1 = GUICtrlCreateGroup("", 336, 8, 81, 329)
$Button3 = GUICtrlCreateButton("+", 344, 24, 65, 57, 0)
GUICtrlSetOnEvent(-1, "plus")
$Button4 = GUICtrlCreateButton("-", 344, 88, 65, 57, 0)
GUICtrlSetOnEvent(-1, "minus")
$Button5 = GUICtrlCreateButton("Bônus", 344, 280, 65, 49, 0)
GUICtrlSetOnEvent(-1, "setx")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button6 = GUICtrlCreateButton("Salvar", 336, 344, 41, 33, 0)
GUICtrlSetOnEvent(-1, "salvar")
$Button7 = GUICtrlCreateButton("Abrir", 376, 344, 41, 33, 0)
GUICtrlSetOnEvent(-1, "abrir")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


#Region ### Projeção
$Form2 = GUICreate("Placar - IASD Nova Almeida", 746, 562, -1, -1, BitOR($WS_SYSMENU,$WS_POPUP,$WS_CLIPSIBLINGS))
GUISetIcon("C:\WINDOWS\system32\shell32.dll", 114)
$projecao = GUICtrlCreateListView("Participante|Pontos", 0, 0, 745, 561)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 640)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 100)
GUICtrlSetFont(-1, 15, 800, 0, "Arial")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
WinActivate("Controle do Placar - IASD Nova Almeida")
While 1
	Sleep(100)
WEnd

#Region ### Funções

Func addPlayer()
	$nome = InputBox("Placar", "Nome do jogoador:")
	GUICtrlCreateListViewItem($nome & "|" & "0", $icList)
	GUICtrlCreateListViewItem($nome & "|" & "0", $projecao)
EndFunc
Func controleClose()
	Exit
EndFunc
Func delPlayer()
	$item = Int(_GUICtrlListView_GetSelectedIndices($icList))
	_GUICtrlListView_DeleteItem($icList, $item)
	_GUICtrlListView_DeleteItem($projecao, $item)
EndFunc
Func editPlayer()
	$indice = Int(_GUICtrlListView_GetSelectedIndices($icList))
	$nome = _GUICtrlListView_GetItemTextString($icList, $indice)
	$nome = StringSplit($nome, "|")
	$nome = $nome[1]
 	$nome = InputBox("Placar", "Nome do jogador:", $nome)
	_GUICtrlListView_SetItemText($icList, $indice, $nome, 0)
	_GUICtrlListView_SetItemText($projecao, $indice, $nome, 0)
EndFunc
Func icListClick()

EndFunc
Func minus()
	setscore(getsel(), getscore(getsel())-1)
EndFunc
Func plus()
	setscore(getsel(), getscore(getsel())+1)
EndFunc
Func abrir()
	$file = FileOpenDialog("Placar", "", "Placar (*.plc)", 2+16)
	If Not $file Then Return 0
	_load($file)
EndFunc
Func salvar()
	$file = FileSaveDialog("Placar", "", "Placar (*.plc)", 1+2)
	If Not $file Then Return 0
	_save($file & ".plc")
EndFunc
Func setx()
	$newscore = InputBox("Placar", "Nova pontuação para """ & getname(getsel()) & """:", getscore(getsel()))
	If $newscore = False Then Return 0
	setscore(getsel(), $newscore)
EndFunc

#endregion

#Region ### lib

#EndRegion
