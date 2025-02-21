#Include %A_LineFile%\..\LogLevel.ahk
#Include %A_LineFile%\..\BaseLayout.ahk

class PatternLayout extends BaseLayout {
	pattern := ""

	; Konstruktor: Initialisiere die Klasse mit dem angegebenen Muster
	__New(pattern) {
		this.pattern := pattern
	}

	; Format-Methode: Formatiere die Nachricht basierend auf dem Muster
	format(level, message) {
		formattedMessage := this.pattern

		match := ""
		if RegExMatch(this.pattern, "%d", &match) {
			formattedMessage := this.replaceDate(formattedMessage, match)
		}

		match := ""
		if RegExMatch(this.pattern, "%m({.*})?", &match) {
			formattedMessage := this.replaceMessage(formattedMessage, message, match)
		}

		match := ""
		if RegExMatch(this.pattern, "%p({[1-9]})?", &match) {
			formattedMessage := this.replaceLevel(formattedMessage, level, match)
		}

		match := ""
		if RegExMatch(this.pattern, "%P", &match) {
			formattedMessage := this.replacePID(formattedMessage, match)
		}

		return formattedMessage
	}

	; Ersetze %d im formatierten Nachrichtentext durch das aktuelle Datum und die Uhrzeit
	replaceDate(formattedMessage, match) {
		return StrReplace(formattedMessage, "%d", FormatTime(A_Now, "yyyy/MM/dd HH:mm:ss"))
	}

	; Ersetze %m oder %m{chomp} im formatierten Nachrichtentext durch die Nachricht
	replaceMessage(formattedMessage, message, match) {
		; Extrahiere die Option aus dem Match-Objekt
		option := match[1]
		; Überprüfe, ob die Option {chomp} ist
		if (option = "{chomp}") {
			message := RTrim(message, "`n")
			return StrReplace(formattedMessage, match[0], message)
		}
		; Wenn eine andere Option als {chomp} angegeben wird, gebe einen Warnhinweis aus und verwende %m
		if (option != "") {
			OutputDebug("[PatternLayout.replaceMessage] [WARN] Unbekannte Option " . option . " für %m. Verwende Standard %m.`n")
		}
		return StrReplace(formattedMessage, match[0], message)
	}

	; Ersetze %p oder %p{1} im formatierten Nachrichtentext durch das Logging-Level
	replaceLevel(formattedMessage, level, match) {
		; Extrahiere die Option aus dem Match-Objekt
		option := match[1]
		levelString := LogLevel.toString(level)
		; Überprüfe, ob die Option {1-9} ist
		if RegExMatch(option, "{([1-9])}", &length) {
			levelString := SubStr(levelString, 1, length[1])
			; Füge Leerzeichen hinzu, um die gewünschte Länge zu erreichen
			while (StrLen(levelString) < length[1]) {
				levelString .= " "
			}
			return StrReplace(formattedMessage, match[0], levelString)
		}
		return StrReplace(formattedMessage, match[0], levelString)
	}

    ; Ersetze %P im formatierten Nachrichtentext durch die PID des aktuellen Prozesses
    replacePID(formattedMessage, match) {
        return StrReplace(formattedMessage, "%P", DllCall("GetCurrentProcessId"))
    }
}
