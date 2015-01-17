#NoTrayIcon
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <WindowsConstants.au3>

Opt("GUIOnEventMode", 1)
Opt("GUICloseOnEsc", 0)
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("IASD WinMonitor", 154, 203, 380, 227)
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "Form1Minimize")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "Form1Maximize")
GUISetOnEvent($GUI_EVENT_RESTORE, "Form1Restore")
$janelas = GUICtrlCreateList("", 0, 0, 153, 175)
GUICtrlSetOnEvent(-1, "janelasClick")
$Button1 = GUICtrlCreateButton("<<", 0, 176, 81, 25, 0)
GUICtrlSetOnEvent(-1, "left")
$Button2 = GUICtrlCreateButton(">>", 80, 176, 73, 25, 0)
GUICtrlSetOnEvent(-1, "right")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
update()
AdlibRegister("upd_loop", 5000)
While 1
	Sleep(100)
WEnd

Func Form1Close()
	Exit
EndFunc
Func Form1Maximize()

EndFunc
Func Form1Minimize()

EndFunc
Func Form1Restore()

EndFunc
Func janelasClick()

EndFunc
Func left()
	$janela = GUICtrlRead($janelas)
	$pos = WinGetPos($janela)
	$x = $pos[0]
	$y = $pos[1]
	If $x >= @DesktopWidth Then WinMove($janela, "", $x - @DesktopWidth, $y)
EndFunc
Func right()
	$janela = GUICtrlRead($janelas)
	$pos = WinGetPos($janela)
	$x = $pos[0]
	$y = $pos[1]
	If $x <= @DesktopWidth Then WinMove($janela, "", $x + @DesktopWidth, $y)
EndFunc

Func update()
  $blacklist = "OpenLP 2.0|Program Manager|Saída do OpenLP|IASD WinMonitor|"
	$list = WinList()
	For $i = 1 To $list[0][0]
		If IsVisible($list[$i][1]) AND $list[$i][0] <> "" AND Not StringInStr($blacklist, $list[$i][0] & "|") Then
			_GUICtrlListBox_AddString($janelas, $list[$i][0])
		EndIf
	Next
EndFunc

Func IsVisible($handle)
  If BitAnd( WinGetState($handle), 2 ) Then 
    Return 1
  Else
    Return 0
  EndIf

EndFunc

Func upd_loop()
	_GUICtrlListBox_ResetContent($janelas)
	update()
EndFunc