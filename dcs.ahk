RunAs %1%, %2%
Run %3%
Sleep, 50000
WinActivate, ahk_exe %3%
Sleep,   2000
WinMove, A, , %4%, %5%
click, %6%, %7% left
Sleep,   2000
click, %8%, %9% left
Sleep,   2000
click, %10%, %11% left
Exit
