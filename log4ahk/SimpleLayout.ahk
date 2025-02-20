#Include %A_LineFile%\..\LogLevel.ahk

class SimpleLayout {
	; Methode zum Formatieren der Log-Nachricht
	format(level, message) {
		formattedTime := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") ; Formatierte Zeit
		levelString := LogLevel.toString(level)
		return Format("[{}] [{}] {}", formattedTime, levelString, message)
	}
}