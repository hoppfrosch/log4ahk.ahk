class PatternLayout {
    pattern := ""

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
        matchPos := RegExMatch(this.pattern, "%m({.*?})?", &match)
        if (matchPos) {
            formattedMessage := this.replaceMessage(formattedMessage, message, match)
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
        return StrReplace(formattedMessage, "%m", message)
    }
}