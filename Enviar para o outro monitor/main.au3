#NoTrayIcon
HotKeySet("^+{RIGHT}", "manda")
HotKeySet("^+{LEFT}", "volta")

While 1=1
   Sleep(10)
WEnd

Func manda()
   $window = WinGetPos("[ACTIVE]")
   $win_x = $window[0]
   WinMove("[ACTIVE]", "", $win_x+@DesktopWidth, $window[1])
EndFunc

Func volta()
   $window = WinGetPos("[ACTIVE]")
   $win_x = $window[0]
   WinMove("[ACTIVE]", "", $win_x-@DesktopWidth, $window[1])
EndFunc