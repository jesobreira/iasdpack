Func consultar()
   If Not GUICtrlRead($iConsultaNumero) Then Return 0
   $familia = IniRead("familias.ini", GUICtrlRead($iConsultaNumero), "nome", "")
   $status = IniRead("familias.ini", GUICtrlRead($iConsultaNumero), "status", "")
   If $familia = "" Then
	  MsgBox(0, "Consulta de fam�lia", "Fam�lia n�o existe")
   Else
	  If $status = "true" Then
		 $status = "J� sorteado"
	  Else
		 $status = "Ainda n�o sorteado"
	  EndIf
	  MsgBox(0, "Consulta de fam�lia", $familia & " e fam�lia" & @CRLF & "Status: " & $status)
   EndIf
EndFunc
Func editarfamilias()
   MsgBox(0, "Editar fam�lias", "Ap�s a edi��o, reinicie o programa.")
   ShellExecute("familias.ini")
EndFunc
Func frmControleClose()
   Exit
EndFunc
Func sortear()
   $numero = Int(GUICtrlRead($iSorteioNumero))
   If Not $numero Then Return 0
   $nome = IniRead("familias.ini", $numero, "nome", "Erro")
   $status = IniRead("familias.ini", $numero, "status", "Erro")
   If $status = "false" Then
	  mostrafamilia($nome)
	  Dim $iMsgBoxAnswer
	  $iMsgBoxAnswer = MsgBox(4,"OI","Fam�lia selecionada: " & $nome & " e fam�lia" & @CRLF & "Est� presente?")
	  Select
		 Case $iMsgBoxAnswer = 6 ;Yes
			IniWrite("familias.ini", $numero, "status", "true")
			_GUICtrlListBox_AddString($sorteados, $nome)
			_GUICtrlListBox_DeleteString($List1, Int(_GUICtrlListBox_FindString($List1, $numero, True)))
			GUISetState(@SW_HIDE, $exibefrm)
		 Case $iMsgBoxAnswer = 7 ;No
			GUISetState(@SW_HIDE, $exibefrm)
	  EndSelect
   Else
	  jasorteada()
	  MsgBox(0, "OI", "Fam�lia j� foi escolhida.")
	  GUISetState(@SW_HIDE, $exibefrm)
   EndIf
EndFunc
Func __init()
   $familias = IniReadSectionNames("familias.ini")
   For $i = 1 To $familias[0]
	  $nome = IniRead("familias.ini", $familias[$i], "nome", "Error")
	  $status = IniRead("familias.ini", $familias[$i], "status", "Error")
	  If $status = "true" Then
		 _GUICtrlListBox_AddString($sorteados, $nome)
	  Else
		 _GUICtrlListBox_AddString($List1, $familias[$i])
	  EndIf
   Next
EndFunc

Func mostrafamilia($nome)
   GUICtrlSetData($familia_nome, $nome)
   GUICtrlSetData($Label2, "e fam�lia")
   GUISetState(@SW_SHOW, $exibefrm)
EndFunc

Func jasorteada()
   GUICtrlSetData($familia_nome, "Fam�lia j� sorteada")
   GUICtrlSetData($Label2, "")
   GUISetState(@SW_SHOW, $exibefrm)
EndFunc