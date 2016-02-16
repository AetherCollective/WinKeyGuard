#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "Misc.au3";Include to detect _ispressed.
#include "BlockInputEX.au3";Include to block specific keys.
OnAutoItExitRegister("deactivate");Failsafe, see function below.
_BlockInputEx(3, "", "{lwin}|{rwin}");Blocks windows keys.
Global $delay = 1500;Sets delay for Guard() Function.
MsgBox(0, "WinKeyGuard", "Windows Key Disabled." & @LF & @LF & "Press and hold F2 and F4 for " & $delay / 1000 & " seconds to simulate the Windows Key." & @LF & "Press and hold F2 and F12 for " & $delay / 1000 & " seconds to close WinKeyGuard.");Instructions
While 1;At any time
	If _IsPressed("71") And _IsPressed("73") Then Guard("71", "73");if F2 and F4 are pressed then do function Guard()
	If _IsPressed("71") And _IsPressed("7B") Then Guard("71", "7B");if F2 and F12 are pressed then do function Guard()
WEnd;Endloop Condition
Func Guard($ia, $ib);checks if Keys are pressed down for longer than $delay
	Local $timer = TimerInit();starts a local timer
	While _IsPressed($ia) And _IsPressed($ib);while keys are pressed down
		Sleep(20);sleep
		Local $timerdiff = TimerDiff($timer);check time
		If $timerdiff >= $delay Then;if timer is greater than or equal to the delay
			If $ib = "7B" Then Exit;if one of the keys held was F12 then Exit with Failsafe.
			Send("{lwin}");Simulates the Windows key since that is the only remaining action left.
			Sleep(500);Short delay after Simulated Windows Key.
			ExitLoop;Exits the While Loop in the Guard() function
		EndIf;endif condition
	WEnd;endloop condition
EndFunc   ;==>Guard
Func deactivate();In any event this program is exited...
	_BlockInputEx(0);Unblock all previously blocked keys
	MsgBox(0, "WinKeyGuard", "Windows Key enabled. AutoClosing in 5 seconds..." & @LF & "Thank you for using my software.", 5);Show Thanks. Exits when this window closes.
EndFunc   ;==>deactivate
