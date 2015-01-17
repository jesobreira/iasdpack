#NoTrayIcon
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#Include <ScreenCapture.au3>

Opt("GUIOnEventMode", 1)
$Form1 = GUICreate("IASD AnotherMonitor", 788, 656, 139, 24)
GUISetIcon("E:\Documents and Settings\IASD - NEW ALMEIDA\Desktop\oracao_intercessoria\resources\iasd.ico")
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "Form1Minimize")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "Form1Maximize")
GUISetOnEvent($GUI_EVENT_RESTORE, "Form1Restore")
$Pic1 = GUICtrlCreatePic("", 8, 8, 769, 641, BitOR($SS_NOTIFY,$WS_GROUP,$WS_CLIPSIBLINGS))
GUICtrlSetOnEvent(-1, "Pic1Click")
GUISetState(@SW_SHOW)
AdlibRegister("mainloop", 1)
While 1
	Sleep(100)
WEnd

Func mainloop()
	$file = _TempFile(@TempDir, "", ".jpg")
	;_ScreenCapture_Capture($file, @DesktopWidth, 0, @DesktopWidth*2, 0, True) ; ilusao de otica lol
	_ScreenCapture_Capture($file, @DesktopWidth, 0, @DesktopWidth*2, @DesktopHeight, True)
	GUICtrlSetImage($Pic1, $file)
	FileDelete($file)
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
Func Label1Click()

EndFunc
Func Pic1Click()
	
EndFunc
