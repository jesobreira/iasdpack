#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <DateTimeConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#include <Date.au3>

Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=E:\Documents and Settings\IASD - NEW ALMEIDA\Meus documentos\IASDapps\escala\Form1.kxf
$Form1 = GUICreate("Escala da Louvor - IASD Nova Almeida", 515, 290, 199, 231)
GUISetIcon("C:\WINDOWS\system32\shell32.dll", 114)
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "Form1Minimize")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "Form1Maximize")
GUISetOnEvent($GUI_EVENT_RESTORE, "Form1Restore")
$iCal = GUICtrlCreateMonthCal(@YEAR & "/" & @MON & "/" & @MDAY, 8, 8, 170, 161)
GUICtrlSetOnEvent(-1, "selecionardia")
$Group1 = GUICtrlCreateGroup(" Louvor especial ", 184, 8, 321, 49)
$iEscalado = GUICtrlCreateInput("", 192, 24, 305, 21)
GUICtrlSetOnEvent(-1, "iEscaladoChange")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup(" Louvor congregacional ", 184, 64, 321, 49)
$iAprendiz = GUICtrlCreateInput("", 192, 80, 305, 21)
GUICtrlSetOnEvent(-1, "iAprendizChange")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup(" Agenda telefônica ", 8, 176, 169, 105)
$iSonoplastaTel = GUICtrlCreateCombo("Selecione um contato...", 16, 192, 153, 25)
GUICtrlSetOnEvent(-1, "iSonoplastaTelChange")
$Button1 = GUICtrlCreateButton("Salvar", 96, 240, 73, 25, 0)
GUICtrlSetOnEvent(-1, "salvartel")
$Button2 = GUICtrlCreateButton("Remover", 16, 240, 73, 25, 0)
GUICtrlSetOnEvent(-1, "removetel")
$iTelefone = GUICtrlCreateInput("", 16, 216, 153, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL,$ES_NUMBER))
GUICtrlSetOnEvent(-1, "iTelefoneChange")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group5 = GUICtrlCreateGroup(" Observação ", 184, 120, 321, 49)
$iObservacao = GUICtrlCreateInput("", 192, 136, 305, 21)
GUICtrlSetOnEvent(-1, "iObsevacaoChange")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button3 = GUICtrlCreateButton("Salvar", 432, 256, 73, 25, 0)
GUICtrlSetOnEvent(-1, "salvardia")
$iJA = GUICtrlCreateCheckbox("Culto Jovem", 184, 176, 81, 25) ; top = 232 (old)
GUICtrlSetOnEvent(-1, "mudaJA")
#cs
$Group3 = GUICtrlCreateGroup(" Visto ", 184, 176, 321, 49)
$Button4 = GUICtrlCreateButton("Fechar dia em nome de:", 192, 192, 129, 25, 0)
GUICtrlSetOnEvent(-1, "fechardia")
$iEmnomede = GUICtrlCreateInput("", 328, 192, 169, 21)
GUICtrlSetOnEvent(-1, "iEmnomedeChange")
#ce
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button5 = GUICtrlCreateButton("Gerar escala", 184, 256, 81, 25, 0)
GUICtrlSetOnEvent(-1, "gerar")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
__boot()
While 1
	Sleep(100)
WEnd

Func __boot()
	updatetels()
	estadata()
EndFunc

Func fechardia()
	$nome = GUICtrlRead($iEmnomede)
	$dia = getkeyname()
	IniWrite("db.ini", $dia, "visto", $nome)
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
Func gerar()
	$pegar = dataconvert(GUICtrlRead($iCal))
	$pegar = StringSplit($pegar, "/") ;d/m/y
	$month = $pegar[2]
	$year = $pegar[3]
	$htm = __generate($month, $year)
	;$file = _TempFile(@TempDir, "", ".html")
	$file = FileSaveDialog("Escala", @DesktopDir, "HTML (*.html,*.html)", 2+16, "Escala-" & $month & "_" & $year & ".html")
	$handle = FileOpen($file, 2)
	FileWrite($handle, $htm)
	FileClose($handle)
	ShellExecute($file)
	;FileDelete($file)
EndFunc
Func iAprendizChange()

EndFunc
Func iEmnomedeChange()

EndFunc
Func iEscaladoChange()

EndFunc
Func iObsevacaoChange()

EndFunc
Func iSonoplastaTelChange()
	$tel = db("telefone_" & GUICtrlRead($iSonoplastaTel), "tel")
	GUICtrlSetData($iTelefone, $tel)
EndFunc
Func iTelefoneChange()
	
EndFunc
Func mudaJA()
	estadata()
EndFunc
Func removetel()
	Dim $iMsgBoxAnswer
	$iMsgBoxAnswer = MsgBox(292,"Escala","Tem certeza que deseja remover este telefone?")
	Select
	   Case $iMsgBoxAnswer = 6 ;Yes
			IniDelete("db.ini", "telefone_" & GUICtrlRead($iSonoplastaTel))
			updatetels()
	   Case $iMsgBoxAnswer = 7 ;No
			Return 0
	EndSelect
EndFunc
Func salvardia()
	$key = getkeyname()
	IniWrite("db.ini", $key, "escalado", GUICtrlRead($iEscalado))
	IniWrite("db.ini", $key, "aprendiz", GUICtrlRead($iAprendiz))
	IniWrite("db.ini", $key, "observacao", GUICtrlRead($iObservacao))
EndFunc
Func salvartel()
	IniWrite("db.ini", "telefone_" & GUICtrlRead($iSonoplastaTel), "tel", GUICtrlRead($iTelefone))
	updatetels()
EndFunc
Func selecionardia()
	estadata()
EndFunc

Func estadata()
	$data = dataconvert(GUICtrlRead($iCal))
	showescala($data, GUICtrlRead($iJA))
EndFunc

Func showescala($data, $ja)
	If is_sabado() Then
		GUICtrlSetState($iJA, $GUI_ENABLE)
		If $ja = 1 Then $data = "ja" & $data
	Else
		GUICtrlSetState($iJA, $GUI_UNCHECKED)
		GUICtrlSetState($iJA, $GUI_DISABLE)
	EndIf
	$data = StringReplace($data, "/", "")
	$data = "escala_" & $data
	GUICtrlSetData($iEscalado, db($data, "escalado"))
	GUICtrlSetData($iAprendiz, db($data, "aprendiz"))
	GUICtrlSetData($iObservacao, db($data, "observacao"))
EndFunc

Func dataconvert($data)
	$data = StringSplit($data, "/")
	Return $data[3] & "/" & $data[2] & "/" & $data[1]
EndFunc

Func db($data, $key)
	Return IniRead("db.ini", $data, $key, "")
EndFunc

Func getkeyname()
	$dia = StringReplace(dataconvert(GUICtrlRead($iCal)), "/", "")
	$ja = GUICtrlRead($iJA)
	If $ja = 1 Then $dia = "ja" & $dia
	$dia = "escala_" & $dia
	Return $dia
EndFunc

Func is_sabado($data = False)
	If Not $data Then $data = GUICtrlRead($iCal)
	$gettime = StringSplit($data, "/")
	$tFile = _Date_Time_EncodeFileTime($gettime[2], $gettime[3], $gettime[1], 01, 00, 00)
	$aFile = _Date_Time_FileTimeToArray($tFile)
	If $aFile[7] = 6 Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func updatetels()
	Dim $comboStr
	GUICtrlSetData($iSonoplastaTel, "")
	$secs = IniReadSectionNames("db.ini")
	If IsArray($secs) Then
		For $i = 1 To $secs[0]
			If StringRegExp($secs[$i], "^telefone_") Then
				$nome = StringReplace($secs[$i], "telefone_", "")
				$comboStr &= "|" & $nome
			EndIf
		Next
	EndIf
	$comboStr = StringTrimLeft($comboStr, 1)
	GUICtrlSetData($iSonoplastaTel, $comboStr)
EndFunc

Func __generate($month, $year=@YEAR)
	$html = '<!DOCTYPE html>' & @CRLF & '<html>' & @CRLF & '<head>' & @CRLF & '	<meta charset="utf-8" />' & @CRLF & '	<title>Escala de Louvor - ' & mes($month) & ' de ' & $year & '</title>' & @CRLF
	$html &= '	<style type="text/css">' & @CRLF & '	* {' & @CRLF & '		text-align: center;' & @CRLF & '	}' & @CRLF & '	body {' & @CRLF & '		font-family: Verdana,Arial,Sans-serif;' & @CRLF & '	}' & @CRLF & '	table,tr,th,td {' & @CRLF & '		border: 1px solid black;' & @CRLF & '		padding: 1px;' & @CRLF & '	}' & @CRLF & '	</style>' & @CRLF & '</head>' & @CRLF & '<body onLoad="javascript:window.print()">'
	$html &= @CRLF & '	<h1>Escala de Louvor - ' & mes($month) &' de ' & $year & '</h1>' & @CRLF
	
	$html &= '	<table>' & @CRLF & '		<tr>' & @CRLF & '			<th>' & @CRLF & '				Dia' & @CRLF & '			</th>' & @CRLF & '			<th>' & @CRLF & '				Louvor especial' & @CRLF & '			</th>' & @CRLF & '			<th>' & @CRLF & '				Louvor congregacional' & @CRLF & '			</th>' & @CRLF & '			<th>' & @CRLF & '				Obs.' & @CRLF & '			</th>' & @CRLF & '		</tr>' & @CRLF
	$sections = IniReadSectionNames("db.ini")
	; obter escala
	For $i = 1 To 31
		$day = String($i)
		If StringLen($day) = 1 Then $day = "0" & $day
		$dia = $day & "/" & $month & "/" & $year
		$escalado = IniRead("db.ini", "escala_" & $day & $month & $year, "escalado", "")
		If $escalado Then
			$aprendiz = IniRead("db.ini", "escala_" & $day & $month & $year, "aprendiz", "")
			$obs = IniRead("db.ini", "escala_" & $day & $month & $year, "observacao", "")
			$html &= '<tr><td>' & $dia & "</td><td>" & $escalado & "</td><td>" & $aprendiz & "</td><td>" & $obs
		EndIf
		
		$dia = $day & "/" & $month & "/" & $year & " (JA)"
		$escalado = IniRead("db.ini", "escala_ja" & $day & $month & $year, "escalado", "")
		If $escalado Then
			$aprendiz = IniRead("db.ini", "escala_" & $day & $month & $year, "aprendiz", "")
			$obs = IniRead("db.ini", "escala_" & $day & $month & $year, "observacao", "")
			$html &= '<tr><td>' & $dia & "</td><td>" & $escalado & "</td><td>" & $aprendiz & "</td><td>" & $obs
		EndIf
	Next
	; fim obter escala
	
	$html &= '	</table>' ; & @CRLF & '	<h2>Telefones</h2>' & @CRLF & '	<table>' & @CRLF & '		<tr>' & @CRLF & '			<th>' & @CRLF & '				Sonoplasta' & @CRLF & '			</th>' & @CRLF & '			' & @CRLF
	#cs
	; obter nomes dos sonoplastas
	Dim $nomes[2]
	$sections = IniReadSectionNames("db.ini")
	For $i = 1 To $sections[0]
		If StringRegExp($sections[$i], "^telefone_") Then
			$new = UBound($nomes)+1
			ReDim $nomes[$new]
			$nome = StringReplace($sections[$i], "telefone_", "")
			$nomes[$new-1] = $nome
			$html &= '<td>' & $nome & '</td>'
		EndIf
	Next
	; fim obter nomes dos sonoplastas
	
	$html &= '		</tr>' & @CRLF & '		<tr>' & @CRLF & '			<th>' & @CRLF & '				Telefone' & @CRLF & '			</th>' & @CRLF & '			' & @CRLF
	
	;obter telefones
	For $nome In $nomes
		$tel = IniRead("db.ini", "telefone_" & $nome, "tel", "")
		If $tel Then
			$html &= '<td>' & $tel & '</td>'
		EndIf
	Next
	; fim obter telefones
	
	$html &= '		</tr>' & @CRLF & '	</table>' & @CRLF & '</body>' & @CRLF & '</html>'
	#ce
	$html &= '</body></tml>'
	Return $html
EndFunc

Func mes($number)
	Dim $arr[13]
	$arr[1] = "Janeiro"
	$arr[2] = "Fevereiro"
	$arr[3] = "Março"
	$arr[4] = "Abril"
	$arr[5] = "Maio"
	$arr[6] = "Junho"
	$arr[7] = "Julho"
	$arr[8] = "Agosto"
	$arr[9] = "Setembro"
	$arr[10] = "Outubro"
	$arr[11] = "Novembro"
	$arr[12] = "Dezembro"
	Return $arr[$number]
EndFunc