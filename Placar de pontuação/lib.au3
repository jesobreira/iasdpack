Func getsel()
	Return Int(_GUICtrlListView_GetSelectedIndices($icList))
EndFunc

Func getscore($id)
	$data = __getdata($id)
	Return $data[2]
EndFunc

Func getname($id)
	$data = __getdata($id)
	Return $data[1]
EndFunc

Func setscore($id, $pontos)
	_GUICtrlListView_SetItemText($icList, $id, $pontos, 1)
	_GUICtrlListView_SetItemText($projecao, $id, $pontos, 1)
EndFunc

Func _save($file)
 	$count = _GUICtrlListView_GetItemCount($icList)-1
	For $i = 0 To $count Step +1
		IniWrite($file, $i, "name", getname($i))
		IniWrite($file, $i, "score", getscore($i))
	Next
	MsgBox(64,"","OK!",1)
EndFunc

Func _load($file)
	__reset()
	$sections = IniReadSectionNames($file)
	For $i = 0 To $sections[0]
		$nome = IniRead($file, $i, "name", "")
		$score = IniRead($file, $i, "score", "")
		GUICtrlCreateListViewItem($nome & "|" & $score, $icList)
		GUICtrlCreateListViewItem($nome & "|" & $score, $projecao)
	Next
	MsgBox(64,"","OK!",1)
EndFunc

Func __getdata($indice)
	$data = _GUICtrlListView_GetItemTextString($icList, $indice)
	$data = StringSplit($data, "|")
	Return $data
EndFunc

Func __reset()
	_GUICtrlListView_DeleteAllItems($icList)
	_GUICtrlListView_DeleteAllItems($projecao)
EndFunc