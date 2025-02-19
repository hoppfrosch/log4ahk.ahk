#Include %A_LineFile%\..\log4ahk\PatternLayout.ahk
#Include %A_LineFile%\..\log4ahk\LogLevel.ahk

class SimpleLayout {
    ; Methode zum Formatieren der Log-Nachricht
    format(level, message) {
        formattedTime := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") ; Formatierte Zeit
        levelString := LogLevel.toString(level)
        return Format("[{}] [{}] {}", formattedTime, levelString, message)
    }
}

class Logger {
    ; Statische Variable zur Speicherung der Singleton-Instanz
    static instance := ""

    ; Konstruktor der Klasse, der das Log-Level initialisiert
    __New(logLvl := LogLevel.INFO, layout := "") {
        this.logLevel := logLvl
        this.logFile := "log.txt" ; Standard-Log-Datei
        this.layout := layout ? layout : SimpleLayout() ; Verwende SimpleLayout als Standard
        this.ensureLogFileExists()
    }

    ; Methode zum Abrufen der Singleton-Instanz
    static getInstance() {
        if (!Logger.instance) {
            Logger.instance := Logger()
        }
        return Logger.instance
    }

    ; Methode zum Schreiben einer Log-Nachricht
    log(level, message) {
        ; Überprüfe, ob der aktuelle Log-Level das Mindestlevel erreicht hat
        if (level >= this.logLevel) {
            logMessage := this.layout.format(level, message)
            FileAppend(logMessage "`n", this.logFile) ; Nachricht in die Log-Datei schreiben
            this.output(logMessage) ; Nachricht ausgeben
        }
    }

    ; Methoden für die verschiedenen Log-Level
    trace(message) {
        this.log(LogLevel.TRACE, message)
    }

    debug(message) {
        this.log(LogLevel.DEBUG, message)
    }

    info(message) {
        this.log(LogLevel.INFO, message)
    }

    warning(message) {
        this.log(LogLevel.WARNING, message)
    }

    error(message) {
        this.log(LogLevel.ERROR, message)
    }

    severe(message) {
        this.log(LogLevel.SEVERE, message)
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
        this.ensureLogFileExists()
    }

    ; Methode zum Setzen des Layouts
    setLayout(layout) {
        this.layout := layout
    }

    ; Methode zum Sicherstellen, dass die Log-Datei existiert
    ensureLogFileExists() {
        if !FileExist(this.logFile) {
            FileAppend("", this.logFile)
        }
    }
}