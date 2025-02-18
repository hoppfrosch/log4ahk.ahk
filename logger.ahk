class Logger {
    ; Definiere die verschiedenen Log-Level als statische Variablen
    static TRACE := 0
    static DEBUG := 1
    static INFO := 2
    static WARNING := 3
    static ERROR := 4
    static SEVERE := 5

    ; Konstruktor der Klasse, der das Log-Level initialisiert
    __New(logLevel := Logger.INFO) {
        this.logLevel := logLevel
        this.logFile := "log.txt" ; Standard-Log-Datei
    }

    ; Methode zum Schreiben einer Log-Nachricht
   log(level, message) {
		; Überprüfe, ob der aktuelle Log-Level das Mindestlevel erreicht hat
		if (level >= this.logLevel) {
			formattedTime := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") ; Formatierte Zeit
			logMessage := Format("[{}] [{}] {}", formattedTime, this.levelToString(level), message) ; Formatierte Log-Nachricht
			FileAppend(logMessage "`n", this.logFile) ; Nachricht in die Log-Datei schreiben
			this.output(logMessage) ; Nachricht ausgeben
		}
	}

    ; Methoden für die verschiedenen Log-Level
    trace(message) {
        this.log(Logger.TRACE, message)
    }

    debug(message) {
        this.log(Logger.DEBUG, message)
    }

    info(message) {
        this.log(Logger.INFO, message)
    }

    warning(message) {
        this.log(Logger.WARNING, message)
    }

    error(message) {
        this.log(Logger.ERROR, message)
    }

    severe(message) {
        this.log(Logger.SEVERE, message)
    }

    ; Methode zur Umwandlung des Log-Levels in einen String
    levelToString(level) {
        static levels := ["TRACE", "DEBUG", "INFO", "WARNING", "ERROR", "SEVERE"]
        return levels[level + 1]
    }

    ; Methode zur Ausgabe der Log-Nachricht (hier als ToolTip)
    output(message) {
        ; Du kannst diese Methode anpassen, um die Ausgabe zu ändern (z.B. MsgBox statt ToolTip)
        ToolTip(message)
    }

    ; Methode zum Setzen des Log-Levels
    setLogLevel(level) {
        this.logLevel := level
    }

    ; Methode zum Setzen der Log-Datei
    setLogFile(filePath) {
        this.logFile := filePath
    }
}