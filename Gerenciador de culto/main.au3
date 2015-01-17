#cs
	Este programa é protegido por leis internacionais de software e também pela lei de Deus.
	Afinal, só Deus sabe como isso aqui funciona.
	Cuidado com a linha que for alterar.
	
;~ 	TODO: []
#ce
#NoTrayIcon
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <WindowsConstants.au3>
#Include <GuiListView.au3>
#include <File.au3>
#include "lib.au3"

Global $advanced_mode = True
Global Const $tempsave = @TempDir & "\iasdtask.ini"
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=e:\documents and settings\iasd - new almeida\meus documentos\iasdapps\task\frm2v2.kxf
$Form1_1 = GUICreate("IASD Instant Task Manager", 483, 439, 215, 139)
GUISetIcon("E:\Documents and Settings\IASD - NEW ALMEIDA\Meus documentos\IASDapps\task\IASD Task.ico")
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1_1Close")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "Form1_1Minimize")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "Form1_1Maximize")
GUISetOnEvent($GUI_EVENT_RESTORE, "Form1_1Restore")
$ListView1 = GUICtrlCreateListView("Descrição|Arquivo", 8, 8, 465, 369)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 300)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 150)
GUICtrlSetOnEvent(-1, "ListView1Click")
$Button1 = GUICtrlCreateButton("&Nova tarefa", 8, 384, 97, 25, 0)
GUICtrlSetOnEvent(-1, "novatarefa")
$Button2 = GUICtrlCreateButton("&Remover tarefa", 104, 384, 81, 25, 0)
GUICtrlSetOnEvent(-1, "removertarefa")
$Button3 = GUICtrlCreateButton("Executa&r tarefa", 280, 408, 193, 25, 0)
GUICtrlSetOnEvent(-1, "executar")
$Button4 = GUICtrlCreateButton("/\", 8, 408, 49, 25, 0)
GUICtrlSetOnEvent(-1, "subir")
$Button5 = GUICtrlCreateButton("\/", 56, 408, 49, 25, 0)
GUICtrlSetOnEvent(-1, "descer")
$Button6 = GUICtrlCreateButton("&Editar tarefa", 104, 408, 81, 25, 0)
GUICtrlSetOnEvent(-1, "editartarefa")
$Button7 = GUICtrlCreateButton("&Salvar sessão", 184, 384, 73, 25, 0)
GUICtrlSetOnEvent(-1, "salvarsessao")
$Button8 = GUICtrlCreateButton("A&brir sessão", 184, 408, 73, 25, 0)
GUICtrlSetOnEvent(-1, "abrirsessao")
$Button9 = GUICtrlCreateButton("Res&etar", 256, 384, 81, 25, 0)
GUICtrlSetOnEvent(-1, "resetar")
$Button10 = GUICtrlCreateButton("Resta&urar última sessão", 336, 384, 137, 25, 0)
GUICtrlSetOnEvent(-1, "restaurar")
$Checkbox1 = GUICtrlCreateCheckbox("A", 256, 408, 25, 25)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, "avancado")
GUICtrlSetTip(-1, "Avançado")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

__construct()

While 1
	Sleep(100)
WEnd

Func abrirsessao()
	$arquivo = FileOpenDialog("IASD", @MyDocumentsDir, "Task Manager List (*.tml)", 1+2)
	If Not $arquivo Then Return 0
	__carrega($arquivo)
EndFunc
Func avancado()
	If $advanced_mode Then
		GUICtrlSetState($Button4, $GUI_HIDE)
		GUICtrlSetState($Button5, $GUI_HIDE)
		GUICtrlSetState($Button6, $GUI_HIDE)
		GUICtrlSetState($Button7, $GUI_HIDE)
		GUICtrlSetState($Button8, $GUI_HIDE)
		GUICtrlSetState($Button9, $GUI_HIDE)
		GUICtrlSetState($Button10, $GUI_HIDE)
		$advanced_mode = False
	Else
		GUICtrlSetState($Button4, $GUI_SHOW)
		GUICtrlSetState($Button5, $GUI_SHOW)
		GUICtrlSetState($Button6, $GUI_SHOW)
		GUICtrlSetState($Button7, $GUI_SHOW)
		GUICtrlSetState($Button8, $GUI_SHOW)
		GUICtrlSetState($Button9, $GUI_SHOW)
		GUICtrlSetState($Button10, $GUI_SHOW)
		$advanced_mode = True
	EndIf
EndFunc
Func editartarefa()
	$index = Int(_GUICtrlListView_GetSelectedIndices($ListView1))
	$pega = _GUICtrlListView_GetItemTextString($ListView1, $index)
	$pega = StringSplit($pega, "|")
	$novo_desc = InputBox("IASD", "Edite a descrição para esta tarefa:", $pega[1])
	If Not $novo_desc Then Return 0
	$novo_file = FileOpenDialog("IASD", @DesktopDir, "Arquivos (*.*)", 3, $pega[2])
	If Not $novo_file Then Return 0
	__changetask($index, $novo_desc, $novo_file)
	#cs
	_GUICtrlListView_DeleteItem($ListView1, $index)
	GUICtrlCreateListViewItem($novo_desc & "|" & $novo_file, $ListView1)
	#ce
EndFunc
Func executar()
	$indice = Int(_GUICtrlListView_GetSelectedIndices($ListView1))
	$rodar = _GUICtrlListView_GetItemTextString($ListView1, $indice)
	$rodar = StringSplit($rodar, "|")
	$rodar = $rodar[2]
	
	ShellExecute($rodar)
EndFunc
Func Form1_1Close()
	Dim $iMsgBoxAnswer
	$iMsgBoxAnswer = MsgBox(292,"IASD","Deseja realmente fechar o aplicativo?")
	Select
	   Case $iMsgBoxAnswer = 6 ;Yes
			Exit
	   Case $iMsgBoxAnswer = 7 ;No
			__void()
	EndSelect
EndFunc
Func Form1_1Maximize()

EndFunc
Func Form1_1Minimize()

EndFunc
Func Form1_1Restore()

EndFunc
Func ListView1Click()

EndFunc
Func novatarefa()
	$descricao = InputBox("IASD", "Digite uma descrição para a tarefa:")
	If Not $descricao Then Return 0
	
	$filename = FileOpenDialog("IASD", @DesktopDir, "Arquivos (*.*)", 3)
	If Not $filename Then Return 0
	
	GUICtrlCreateListViewItem($descricao & "|" & $filename, $ListView1)
EndFunc
Func removertarefa()
	$indice = Int(_GUICtrlListView_GetSelectedIndices($ListView1))
	_GUICtrlListView_DeleteItem($ListView1, $indice)
EndFunc
Func resetar()
	Dim $iMsgBoxAnswer
	$iMsgBoxAnswer = MsgBox(308,"IASD","Você tem certeza que deseja resetar a sessão atual?")
	Select
	   Case $iMsgBoxAnswer = 6 ;Yes
		_GUICtrlListView_DeleteAllItems($ListView1)
	   Case $iMsgBoxAnswer = 7 ;No
		__void()
	EndSelect
EndFunc
Func restaurar()
;~ 	Dim $iMsgBoxAnswer
;~ 	$iMsgBoxAnswer = MsgBox(308,"IASD","Deseja realmente perder a sessão atual e restaurar a anterior?")
;~ 	Select
;~ 	   Case $iMsgBoxAnswer = 6 ;Yes
			__carregatemp()
;~ 	   Case $iMsgBoxAnswer = 7 ;No
;~ 			__void()
;~ 	EndSelect
EndFunc
Func salvarsessao()
	$arquivo = FileSaveDialog("IASD", @MyDocumentsDir, "Task Manager List (*.tml)", 2+16)
	If Not $arquivo Then Return 0
	__salva($arquivo & ".tml")
EndFunc

Func subir()
	$indice = Int(_GUICtrlListView_GetSelectedIndices($ListView1))
	If $indice = 0 Then Return 0
	$outra = $indice-1
	$linha_atual = _GUICtrlListView_GetItemTextString($ListView1, $indice)
	$linha_atual = StringSplit($linha_atual, "|")
	$linha_outra = _GUICtrlListView_GetItemTextString($ListView1, $outra)
	$linha_outra = StringSplit($linha_outra, "|")
	__changetask($indice, $linha_outra[1], $linha_outra[2])
	__changetask($outra, $linha_atual[1], $linha_atual[2])
EndFunc

Func descer()
	$indice = Int(_GUICtrlListView_GetSelectedIndices($ListView1))
	If $indice = Int(_GUICtrlListView_GetItemCount($ListView1))+1 Then Return 0
	$outra = $indice+1
	$linha_atual = _GUICtrlListView_GetItemTextString($ListView1, $indice)
	$linha_atual = StringSplit($linha_atual, "|")
	$linha_outra = _GUICtrlListView_GetItemTextString($ListView1, $outra)
	$linha_outra = StringSplit($linha_outra, "|")
	__changetask($indice, $linha_outra[1], $linha_outra[2])
	__changetask($outra, $linha_atual[1], $linha_atual[2])
EndFunc