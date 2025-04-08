# 🔄 ShakenQuote - Motivation per Shake

Wir verbringen zu viel Zeit auf der Suche nach Motivation und Inspiration. **ShakenQuote** bietet eine einfache, aber kraftvolle Lösung: Eine minimalistische App, die dir inspirierende Zitate liefert - mit einem einfachen Schütteln deines Smartphones.

Statt komplizierter Menüs und ablenkender Elemente konzentriert sich ShakenQuote auf das Wesentliche: Das Zitat und du. Mit jedem Shake erhältst du eine neue Perspektive, einen neuen Gedanken, der dich durch den Tag begleitet.

Die App ist bewusst einfach gehalten: Keine Werbung, keine Ablenkungen, keine unnötigen Features – nur Weisheiten, die dich inspirieren und motivieren.

## ✨ Features

- **Shake-to-refresh**: Ein einfaches Schütteln deines Handys genügt für ein neues Zitat
- **Button-Alternative**: Kein Fan vom Schütteln? Drücke einfach den Button
- **Akustisches Feedback**: Ein dezenter Sound signalisiert jedes neue Zitat
- **Minimalistisches Design**: Ansprechender Farbverlauf von Blau zu Grün, fokussiert auf Lesbarkeit
- **ZenQuotes API**: Zugriff auf eine vielfältige Sammlung inspirierender Zitate

## 📱 Installation

So installierst du ShakenQuote auf deinem Android-Gerät / Emulator:

1. Besuche https://kyle006.github.io/ShakenQuote/ auf deinem Gerät
2. Aktiviere "Installation aus unbekannten Quellen" in deinen Einstellungen (falls nicht aktiviert, wirst du während der Installation dazu aufgefordert)
3. Tippe auf "APK herunterladen"
4. Öffne die heruntergeladene Datei aus deinem Download-Ordner
5. Folge den Anweisungen zur Installation
6. Erteile der App die erforderlichen Berechtigungen für Bewegungssensoren
7. Schüttle dein Handy für dein erstes Zitat!

## 🔍 Verwendung

Die Bedienung ist bewusst einfach gehalten:

1. **Schütteln**: Ein einfaches Schütteln deines Smartphones lädt ein neues Zitat
2. **Button drücken**: Alternativ kannst du den Button antippen
3. **Zuhören & Lesen**: Genieße den kurzen Bestätigungston und lass dich vom Zitat inspirieren

## 🔒 Berechtigungen
Folgende Berechtigungen werden gebraucht:
* `INTERNET`: Um aufs Internet zuzugreifen

## 🛠️ Technologien

- **Flutter**: Plattformübergreifende Entwicklung für konsistente Performance
- **ZenQuotes API**: Kuratierte Sammlung qualitativ hochwertiger Zitate
- **Audio Integration**: Dezentes akustisches Feedback für bessere User Experience
- **Kompatibilität**: Optimiert für Android 11 und höher

## 📋 Projektstruktur

ShakenQuote ist modular aufgebaut:

- **lib/**: Hauptcode der Anwendung
  - **main.dart**: Einstiegspunkt der App
  - **models/**: Datenmodelle für Zitate
    - **quote.dart**: Zitat-Datenmodell
  - **screens**/: Benutzeroberflächen
    - **quote_screen.dart**: Hauptbildschirm der App
  - **services/**: Backend-Integration
    - **quote_service.dart**: API-Anbindung und Datenverarbeitung
    - **sound_service.dart**: Audio-Feedback-Integration
    - **shake_service.dart**: Bewegungserkennung

ShakenQuote – Deine tägliche Dosis Inspiration, so einfach wie ein Schütteln deines Handys!