#NoTrayIcon

#include <File.au3>
#include <Constants.au3>

Global $tooltiptext

Opt("TrayMenuMode", 1)
TraySetClick(8)
TraySetToolTip("IASD Controle - Servidor")
TraySetIcon(@ScriptFullPath)
Opt("TrayOnEventMode", 1)
TraySetOnEvent($TRAY_EVENT_PRIMARYDOWN, "showtooltip")
TrayCreateItem("Fechar Controle Servidor")
TrayItemSetOnEvent(-1, "ExitEvent")

Func ExitEvent()
   Exit
EndFunc

Func showtooltip()
   ToolTip($tooltiptext)
   TrayTip("Controle Servidor", $tooltiptext, 5)
EndFunc

#Region HTML files
; for security we wont allow the user to modify the server files
; he can do it only if he is a developer, by compiling the app again
If FileExists("controle.index.html") Then FileDelete("controle.index.html")
If FileExists("controle.jquery.js") Then FileDelete("controle.jquery.js")

$jqueryfile = @ScriptDir & "\controle.jquery.js"
FileInstall("jquery.js", $jqueryfile)
FileSetAttrib($jqueryfile, "+H")

$indexfile = @ScriptDir & "\controle.index.html"
FileInstall("index.html", $indexfile)
FileSetAttrib($indexfile, "+H")
#EndRegion

Local $sRootDir = @ScriptDir & "\www"
Local $sIP = @IPAddress1
;Local $iPort = 8080
Local $iPort = FileRead(@ScriptDir & "\porta.ini")
Local $sServerAddress = "http://" & $sIP & ":" & $iPort & "/"
Local $iMaxUsers = 15
Local $sServerName = "wdControleIASD/1.0"

Local $aSocket[$iMaxUsers]
Local $sBuffer[$iMaxUsers]

For $x = 0 To UBound($aSocket)-1
   $aSocket[$x] = -1
Next

TCPStartup()

$iMainSocket = TCPListen($sIP, $iPort)
If @error Then
   MsgBox(0x20, "Controle Servidor", "Não foi possível abrir a porta.")
   Exit
EndIf

TrayTip("Controle", "Servidor aberto em " & $sIP & ":" & $iPort, 5)
$tooltiptext = "Servidor aberto em " & $sIP & ":" & $iPort

While True
   $iNewSocket = TCPAccept($iMainSocket)
   
   If $iNewSocket >= 0 Then
	  For $x = 0 To UBound($aSocket)
		 If $aSocket[$x] = -1 Then
			$aSocket[$x] = $iNewSocket
			ExitLoop
		 EndIf
	  Next
   EndIf
   
   For $x = 0 To UBound($aSocket)-1
	  If $aSocket[$x] = -1 Then ContinueLoop
	  $sNewData = TCPRecv($aSocket[$x], 1024)
	  If @error Then
		 $aSocket[$x] = -1
		 ContinueLoop
	  ElseIf $sNewData Then
		 $sBuffer[$x] &= $sNewData
		 If StringInStr(StringStripCR($sBuffer[$x]), @LF&@LF) Then
			$sFirstLine = StringLeft($sBuffer[$x], StringInStr($sBuffer[$x], @LF)-1)
			$sRequestType = StringLeft($sFirstLine, StringInStr($sFirstLine, " ")-1)
			If $sRequestType = "GET" Then
			   $sRequest = StringTrimLeft(StringTrimRight(StringTrimLeft($sFirstLine, 4), 10), 1)
			   If StringInStr(StringReplace($sRequest, "\","/"), "/.") Then
				  _HTTP_SendError($aSocket[$x])
			   Else
				  If $sRequest = "" Then
					 _EnviaIndex($aSocket[$x])
				  ElseIf $sRequest = "direita" OR $sRequest = "esquerda" Then
					 _Action($sRequest)
					 _EnviaOK($aSocket[$x])
				  ElseIf $sRequest = "jquery.js" Then
					 _HTTP_SendFile($aSocket[$x], $jqueryfile, "text/javascript")
				  Else
					 _HTTP_SendFileNotFoundError($aSocket[$x])
				  EndIf
			   EndIf
			EndIf
			
			$sBuffer[$x] = ""
			$aSocket[$x] = -1
			
		 EndIf
	  EndIf
   Next
   
   Sleep(10)
WEnd
   

Func _HTTP_ConvertString(ByRef $sInput)
   $sInput = StringReplace($input, "+", ' ')
   StringReplace($sInput, '%', '')
   For $t = 0 To @extended
	  $Find_Char = StringLeft(StringTrimLeft($sInput, StringInStr($sInput, '%')), 2)
	  $sInput = StringReplace($sInput, '%' & $Find_Char, Chr(Dec($Find_Char)))
   Next
EndFunc

Func _HTTP_SendHTML($hSocket, $sHTML, $sReply = "200 OK")
   _HTTP_SendData($hSocket, Binary($sHTML), "text/html", $sReply)
EndFunc

Func _HTTP_SendFile($hSocket, $sFileLoc, $sMimeType, $sReply = "200 OK")
   Local $hFile, $sImgBuffer, $sPacket, $a
   
   $hFile = FileOpen($sFileLoc, 16)
   $bFileData = FileRead($hFile)
   FileClose($hFile)
   
   _HTTP_SendData($hSocket, $bFileData, $sMimeType, $sReply)
EndFunc

Func _HTTP_SendData($hSocket, $bData, $sMimeType, $sReply = "200 OK")
   $sPacket = Binary("HTTP/1.1 " & $sReply & @CRLF & _
	  "Server: " & $sServerName & @CRLF & _
	  "Connection: close" & @CRLF & _
	  "Content-Lenght: " & BinaryLen($bData) & @CRLF & _
	  "Content-Type: " & $sMimeType & @CRLF & _
	  @CRLF)
   TCPSend($hSocket, $sPacket)
   
   While BinaryLen($bData)
	  $a = TCPSend($hSocket, $bData)
	  $bData = BinaryMid($bData, $a+1, BinaryLen($bData)-$a)
   WEnd
   
   $sPacket = Binary(@CRLF & @CRLF)
   TCPSend($hSocket, $sPacket)
   TCPCloseSocket($hSocket)
EndFunc

Func _HTTP_SendFileNotFoundError($hSocket)
   Local $s404Loc = $sRootDir & "\404.html"
   If FileExists($s404Loc) Then
	  _HTTP_SendFile($hSocket, $s404Loc, "text/html")
   Else
	  _HTTP_SendHTML($hSocket, "<h1>Page not found</h1>" & @CRLF & @CRLF & "<p>The file you requested wasn't found on this server.</p><hr><addr>ControleServer at " & $sIP & " on port " & $iPort & ".</addr>")
   EndIf
EndFunc
	  
	  
Func _Action($act)
   If $act = "direita" Then
	  Send("{RIGHT}")
	  TrayTip(">", "Direita pressionada", 1)
   ElseIf $act = "esquerda" Then
	  Send("{LEFT}")
	  TrayTip("<", "Esquerda pressionada", 1)
   EndIf
EndFunc

Func _EnviaIndex($hSocket)
   _HTTP_SendHTML($hSocket, FileRead($indexfile))
EndFunc

Func _EnviaOK($hSocket)
   _HTTP_SendHTML($hSocket, "ok")
EndFunc