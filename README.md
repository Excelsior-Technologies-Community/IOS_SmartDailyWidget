
📱 Smart Daily Widget (WidgetKit + SwiftUI)

A simple, realistic Home Screen widget built using SwiftUI + WidgetKit that shows:
    •    🕒 Current time
    •    👋 Smart greeting (Morning / Afternoon / Evening / Night)
    •    📅 Today’s date
    •    ⏱️ Auto-updating using WidgetKit timeline

This project is intended for learning how iOS widgets work and follows Apple’s recommended APIs, including safe support for iOS 16 and iOS 17+.

⸻

✨ Features
    •    Home Screen widget (WidgetKit)
    •    Timeline-based updates (every minute)
    •    Smart greeting based on time of day
    •    Modern UI using containerBackground (iOS 17+) with fallback for iOS 16
    •    Works on simulator and real device
    •    No paid Apple Developer account required

⸻

🛠 Technologies Used
    •    SwiftUI
    •    WidgetKit
    •    TimelineProvider
    •    iOS 16+ compatible
    •    Conditional APIs for iOS 17+

⸻

📂 Project Structure

LiveActivityTimer
├── LiveActivityTimer (Main App)
│   ├── ContentView.swift
│   └── LiveActivityTimerApp.swift
│
└── LiveActivityWidget (Widget Extension)
    ├── LiveActivityWidget.swift
    └── LiveActivityWidgetBundle.swift

The main app exists only to host the widget.
All widget logic lives inside the Widget Extension.

⸻

▶️ How to Run the Project
    1.    Open the project in Xcode
    2.    Select the main app target (LiveActivityTimer)
    3.    Run on:
    •    Simulator or
    •    Real iPhone
    4.    Make sure the app launches once (widgets appear only after installation)

⸻

➕ How to Add the Widget to Home Screen
    1.    Go to the Home Screen
    2.    Long-press on any empty area
    3.    Tap the ➕ (plus) button (top-left)
    4.    Search for:

Smart Daily Widget


    5.    Select the Small widget size
    6.    Tap Add Widget
    7.    Place it anywhere and tap Done

⏱️ The widget updates automatically every minute.

⸻

🧠 How the Widget Works (Concept)

Widgets do not run continuously.
Instead, they use a timeline to decide when to refresh.

The system:
    •    Calls your provider
    •    Asks for the next update time
    •    Refreshes the UI automatically

This approach is battery efficient and Apple-recommended.

⸻

📌 Important Code Explanation

1️⃣ Timeline Entry

struct SmartEntry: TimelineEntry {
    let date: Date
}

This represents one snapshot of data shown by the widget.

⸻

2️⃣ Timeline Provider

struct SmartProvider: TimelineProvider {

This is the brain of the widget.
It tells iOS:
    •    What to show
    •    When to update next

func getTimeline(in context: Context, completion: @escaping (Timeline<SmartEntry>) -> Void) {
    let currentDate = Date()
    let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!

    let entry = SmartEntry(date: currentDate)

    completion(
        Timeline(entries: [entry], policy: .after(nextUpdate))
    )
}

🔹 Updates the widget every 1 minute
🔹 This is the recommended way to refresh time-based widgets

⸻

3️⃣ Smart Greeting Logic

var greeting: String {
    let hour = Calendar.current.component(.hour, from: entry.date)
    switch hour {
    case 5..<12:
        return "Good Morning ☀️"
    case 12..<17:
        return "Good Afternoon 🌤️"
    case 17..<22:
        return "Good Evening 🌙"
    default:
        return "Good Night 🌙"
    }
}

This makes the widget context-aware based on time of day.

⸻

4️⃣ containerBackground (iOS 17+) with Fallback

if #available(iOS 17.0, *) {
    VStack { ... }
        .containerBackground(.fill.tertiary, for: .widget)
} else {
    VStack { ... }
        .background(Color(.systemBackground))
}

✔ Uses modern API on iOS 17+
✔ Safely supports iOS 16
✔ Avoids build errors and warnings

⸻

5️⃣ Widget Configuration

StaticConfiguration(
    kind: "SmartDailyWidget",
    provider: SmartProvider()
) { entry in
    SmartWidgetView(entry: entry)
}
 
