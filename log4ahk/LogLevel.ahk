class LogLevel {
    static TRACE := 0
    static DEBUG := 1
    static INFO := 2
    static WARNING := 3
    static ERROR := 4
    static SEVERE := 5

    ; Methode zur Umwandlung des Log-Levels in einen String
    static toString(level) {
        static levels := ["TRACE", "DEBUG", "INFO", "WARNING", "ERROR", "SEVERE"]
        return levels[level + 1]
    }
}