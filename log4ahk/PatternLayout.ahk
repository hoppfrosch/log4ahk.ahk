#Include %A_LineFile%\..\LogLevel.ahk
#Include %A_LineFile%\..\BaseLayout.ahk

class PatternLayout extends BaseLayout {
    pattern := ""
    placeholders := []

    ; Konstruktor: Initialisiere die Klasse mit dem angegebenen Muster
    __New(pattern) {
        this.pattern := pattern
        this.extractPlaceholders()
		X:= 0
    }

    ; Neue Methode zum Extrahieren der Platzhalter
    extractPlaceholders() {
        regex := "%(?:(?<quantifier>-?\d{1,3}|\.\d{1,3}))?(?<type>[mpPd])(?:\{(?<options>.*?)\})?"
        startPos := 1
        while (match := RegExMatch(this.pattern, regex, &placeholder, startPos)) {
            this.placeholders.Push({
                fullMatch: placeholder[0],
                quantifier: placeholder.quantifier,
                type: placeholder.type,
                options: placeholder.options,
                startPos: match,
                endPos: match + StrLen(placeholder[0]) - 1
            })
            startPos := match + StrLen(placeholder[0])
        }
    }

    ; Der Rest des Codes bleibt unverändert
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

    ; Die restlichen Methoden bleiben unverändert
    replaceDate(formattedMessage, match) {
        return StrReplace(formattedMessage, "%d", FormatTime(A_Now, "yyyy/MM/dd HH:mm:ss"))
    }

    replaceMessage(formattedMessage, message, match) {
        option := match[1]
        if (option = "{chomp}") {
            message := RTrim(message, "`n")
            return StrReplace(formattedMessage, match[0], message)
        }
        if (option != "") {
            OutputDebug("[PatternLayout.replaceMessage] [WARN] Unbekannte Option " . option . " für %m. Verwende Standard %m.`n")
        }
        return StrReplace(formattedMessage, match[0], message)
    }

    replaceLevel(formattedMessage, level, match) {
        option := match[1]
        levelString := LogLevel.toString(level)
        if RegExMatch(option, "{([1-9])}", &length) {
            levelString := SubStr(levelString, 1, length[1])
            while (StrLen(levelString) < length[1]) {
                levelString .= " "
            }
            return StrReplace(formattedMessage, match[0], levelString)
        }
        return StrReplace(formattedMessage, match[0], levelString)
    }

    replacePID(formattedMessage, match) {
        return StrReplace(formattedMessage, "%P", DllCall("GetCurrentProcessId"))
    }
}
