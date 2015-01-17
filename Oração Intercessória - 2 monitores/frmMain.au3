#Region ### START Koda GUI section ### Form=C:\Users\IASD\apps\display.kxf
$frmDisplay = GUICreate("Oração Intercessória", 1070, 584, (@DesktopWidth/2)-(1070/2), -1, BitOR($WS_SYSMENU,$WS_POPUP))
$Group1 = GUICtrlCreateGroup("", 8, 0, 681, 577, BitOR($GUI_SS_DEFAULT_GROUP,$BS_FLAT))
$List1 = GUICtrlCreateList("", 16, 16, 665, 546, BitOR($GUI_SS_DEFAULT_LIST,$LBS_MULTICOLUMN))
GUICtrlSetFont(-1, 24, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("", 696, 0, 369, 577, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER,$BS_FLAT))
$sorteados = GUICtrlCreateList("", 704, 16, 353, 546, BitOR($GUI_SS_DEFAULT_LIST,$LBS_MULTICOLUMN))
GUICtrlSetFont(-1, 18, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###