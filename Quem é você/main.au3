#NoTrayIcon
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>

Opt("GUIOnEventMode", 1)
Opt("GUICloseOnESC", 0)
HotKeySet("^A", "emergency")

#Region Overlay
$Form1 = GUICreate("BLOQUEADO OVERLAY IASD SONOPLASTIA", @DesktopWidth+3, @DesktopHeight+30, -1, -1, $WS_POPUP)
GUISetBkColor(0x000000)
GUISetState(@SW_SHOW)
WinSetOnTop("BLOQUEADO OVERLAY IASD SONOPLASTIA", "", 1)
#EndRegion ### END Koda GUI section ###


#Region Perguntas
$Form2 = GUICreate("BLOQUEADO PERGUNTA IASD SONOPLASTIA", 793, 574, 345, 163, $WS_POPUP)
GUISetBkColor(0xFFFFFF)
$Label1 = GUICtrlCreateLabel("Por segurança e para controle interno da Igreja Adventista, responda as perguntas abaixo.", 16, 8, 761, 26)
GUICtrlSetFont(-1, 14, 400, 0, "Arial")
$Label2 = GUICtrlCreateLabel("O não preenchimento levará ao desligamento do computador.", 16, 40, 524, 26)
GUICtrlSetFont(-1, 14, 400, 0, "Arial")
$Label3 = GUICtrlCreateLabel("A inserção de dados falsos levará ao bloqueio PERMANENTE de uso deste ambiente.", 16, 72, 735, 26)
GUICtrlSetFont(-1, 14, 400, 0, "Arial")
$Label4 = GUICtrlCreateLabel("Qual o seu nome completo ou nome do seu grupo de louvor?", 16, 120, 584, 28)
GUICtrlSetFont(-1, 15, 800, 0, "Arial")
$nome = GUICtrlCreateInput("", 16, 152, 753, 30)
GUICtrlSetFont(-1, 14, 400, 0, "Arial")
$Label5 = GUICtrlCreateLabel("Por que você está aqui? Explique, claramente, o que você pretende fazer.", 16, 200, 701, 28)
GUICtrlSetFont(-1, 15, 800, 0, "Arial")
$porque = GUICtrlCreateEdit("", 16, 232, 753, 177)
GUICtrlSetFont(-1, 14, 400, 0, "Arial")
$ciente = GUICtrlCreateCheckbox("Estou ciente de minha responsabilidade quanto a objetos e sistemas computacionais danificados enquanto eu estiver neste ambiente.", 16, 432, 753, 49, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_MULTILINE))
GUICtrlSetFont(-1, 14, 400, 0, "Arial")
$Button1 = GUICtrlCreateButton("Iniciar uso da sonoplastia", 16, 504, 761, 57)
GUICtrlSetFont(-1, 14, 400, 0, "Arial")
GUICtrlSetOnEvent(-1, "enviar")
GUISetState(@SW_SHOW)
WinSetOnTop("BLOQUEADO PERGUNTA IASD SONOPLASTIA", "", 1)
#EndRegion ### END Koda GUI section ###

AdlibRegister("verificajanela")

While 1
	Sleep(100)
WEnd

Func MyMsgBox($a, $b, $c, $d=0)
   WinSetOnTop("BLOQUEADO OVERLAY IASD SONOPLASTIA", "", 0)
   WinSetOnTop("BLOQUEADO PERGUNTA IASD SONOPLASTIA", "", 0)
   $ret = MsgBox($a, $b, $c, $d)
   WinSetOnTop("BLOQUEADO OVERLAY IASD SONOPLASTIA", "", 1)
   WinSetOnTop("BLOQUEADO PERGUNTA IASD SONOPLASTIA", "", 1)
   Return $ret
EndFunc

Func enviar()
   $sNome = GUICtrlRead($nome)
   $sPorque = GUICtrlRead($porque)
   $bCiente = GUICtrlRead($ciente)
   
   If $sNome = "" Then
	  MyMsgBox(0, "Erro - BLOQUEIO IASD SONOPLASTIA", "Insira seu nome.", 5)
	  Return 0
   EndIf
   
   If Not StringInStr($sNome, " ") Then
	  MyMsgBox(0, "Erro - BLOQUEIO IASD SONOPLASTIA", "Insira seu nome COMPLETO!", 5)
	  Return 0
   EndIf
   
   If StringLen($sPorque)  <= 5 Then
	  MyMsgBox(0, "Erro - BLOQUEIO IASD SONOPLASTIA", "Explique melhor o motivo de estar aqui.", 5)
	  Return 0
   EndIf
   
   If $ciente <> 1 Then
	  Dim $iMsgBoxAnswer
	  $iMsgBoxAnswer = MyMsgBox(292,"Pergunta - BLOQUEIO IASD SONOPLASTIA","Você está ciente de sua responsabilidade quanto a objetos e sistemas computacionais danificados enquanto você estiver neste ambiente?")
	  Select
		 Case $iMsgBoxAnswer = 6 ;Yes
			; ok
		 Case $iMsgBoxAnswer = 7 ;No
			gravar($sNome, $sPorque, "foi bloqueado")
			MyMsgBox(16,"Pergunta - BLOQUEIO IASD SONOPLASTIA","Neste caso, você não está autorizado a utilizar o ambiente da sonoplastia." & @CRLF & "O computador será desligado.",10)
			Shutdown(1+4+8)
			Return 0
	  EndSelect
   EndIf
   
   ; tudo ok, gravar
   gravar($sNome, $sPorque, "entrou")
   MyMsgBox(64,"Sonoplastia","Bem-vindo ao ambiente da sonoplastia." & @CRLF & "Seu uso está sendo registrado.")
   Exit
EndFunc


While 1
	Sleep(100)
WEnd

Func emergency()
   Exit
EndFunc

Func gravar($fNome, $fPorque, $fAcao)
   $line = @CRLF & "[" & @MDAY & "/" & @MON & "/" & @YEAR & " " & @HOUR & ":" & @MIN & ":" & @SEC & "] - " & $fNome & " " & $fAcao & " " & $fPorque
   FileWriteLine(@ScriptDir & "\log.txt", $line)
EndFunc

Func verificajanela()
   $title = WinGetTitle("[ACTIVE]")
   If $title <> "BLOQUEADO PERGUNTA IASD SONOPLASTIA" Then
	  WinActivate("BLOQUEADO OVERLAY IASD SONOPLASTIA")
	  WinActivate("BLOQUEADO PERGUNTA IASD SONOPLASTIA")
   EndIf
EndFunc