class BaseLayout {
    ; Generische Methode zum Formatieren der Log-Nachricht
    format(level, message) {
        throw Error("Die Methode 'format' muss in der abgeleiteten Klasse implementiert werden.", "NotImplementedError", -1)
    }
}