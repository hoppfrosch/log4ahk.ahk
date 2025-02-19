#Include %A_LineFile%\..\LogLevel.ahk

class PatternLayout {
    pattern := ""
    version := "1.0.0" ; Versionsnummer der Klasse

    ; Konstruktor: Initialisiere die Klasse mit dem angegebenen Muster
    __New(pattern) {
        this.pattern := pattern
    }

    ; Format-Methode: Formatiere die Nachricht basierend auf dem Muster
    format(level, message) {
        formattedMessage := this.pattern
        ; Überprüfe, ob das Muster %d enthält, und ersetze es durch das aktuelle Datum und die Uhrzeit
        if InStr(this.pattern, "%d") {
            formattedMessage := this.replaceDate(formattedMessage)
        }
        ; Überprüfe, ob das Muster %m oder %m{.*} enthält, und ersetze es durch die Nachricht
        match := ""
        matchPos := RegExMatch(this.pattern, "%m({.*})?", &match)
        if (matchPos) {
            formattedMessage := this.replaceMessage(formattedMessage, message, match)
        }
        ; Überprüfe, ob das Muster %p oder %p{[1-9]} enthält, und ersetze es durch das Logging-Level
        match := ""
        matchPos := RegExMatch(this.pattern, "%p({[1-9]})?", &match)
        if (matchPos) {
            formattedMessage := this.replaceLevel(formattedMessage, level, match)
        }
        return formattedMessage
    }

    ; Ersetze %d im formatierten Nachrichtentext durch das aktuelle Datum und die Uhrzeit
    replaceDate(formattedMessage) {
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
            MsgBox("Warnung: Unbekannte Option " . option . " für %m. Verwende Standard %m.")
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
}