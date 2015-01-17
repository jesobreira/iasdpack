#include-once


OnAutoItExitRegister("__salvatemp")
AdlibRegister("__salvabak", 30000)

Func __salvatemp()
	FileDelete(@TempDir & "\iasdtask_bak.ini")
	__salva(@TempDir & "\iasdtask.ini")
EndFunc

Func __salvabak()
	__salva(@TempDir & "\iasdtask_bak.ini")
EndFunc
	
Func __carregatemp()
	__carrega(@TempDir & "\iasdtask.ini")
EndFunc

Func __carrega($file)
	Dim $iMsgBoxAnswer
	$iMsgBoxAnswer = MsgBox(35,"IASD","Deseja mesclar com a sessão atual?" & @CRLF & "(Respondendo afirmativamente, a sessão a ser carregada será adicionada, e a sessão atual não será perdida)")
	Select
	   Case $iMsgBoxAnswer = 6 ;Yes
		__void()
	   Case $iMsgBoxAnswer = 7 ;No
		_GUICtrlListView_DeleteAllItems($ListView1)
	   Case $iMsgBoxAnswer = 2 ;Cancel
		Return 0
	EndSelect
	$tasks = IniReadSectionNames($file)
	For $i = 1 To $tasks[0]
		$filename = IniRead($file, $tasks[$i], "file", "")
		$descricao = IniRead($file, $tasks[$i], "descricao", "")
		GUICtrlCreateListViewItem($descricao & "|" & $filename, $ListView1)
	Next
EndFunc

Func __salva($file)
	$j = _GUICtrlListView_GetItemCount($ListView1)
	__debug($j & " items")
	For $i = 1 To $j
		$item = _GUICtrlListView_GetItemTextString($ListView1, $i-1)
		$item = StringSplit($item, "|")
		IniWrite($file, $i, "descricao", $item[1])
		IniWrite($file, $i, "file", $item[2])
	Next
EndFunc

Func __changetask($index, $desc, $file)
	_GUICtrlListView_SetItemText($ListView1, $index, $desc, 0)
	_GUICtrlListView_SetItemText($ListView1, $index, $file, 1)
EndFunc
	
Func __debug($msg)
	ConsoleWrite($msg & @CRLF)
EndFunc

Func __void()
	; do nothing
EndFunc

Func __construct()
	If FileExists(@TempDir & "\iasdtask_bak.ini") Then
		Dim $iMsgBoxAnswer
		$iMsgBoxAnswer = MsgBox(68,"IASD","Há um backup automático não salvo da última sessão." & @CRLF & "Deseja restaurá-lo?")
		Select
		   Case $iMsgBoxAnswer = 6 ;Yes
			__carrega(@TempDir & "\iasdtask_bak.ini")
		   Case $iMsgBoxAnswer = 7 ;No
			__void()
		EndSelect
	Else
		__debug("backup not found")
	EndIf
EndFunc