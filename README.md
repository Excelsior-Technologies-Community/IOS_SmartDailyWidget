# 📱 Smart Daily Widget

A simple, elegant Home Screen widget built with SwiftUI and WidgetKit that displays real-time information with smart contextual greetings.

![iOS](https://img.shields.io/badge/iOS-16.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)
![WidgetKit](https://img.shields.io/badge/WidgetKit-Compatible-green.svg)

## ✨ Features

- 🕒 **Real-time clock** with automatic updates
- 👋 **Smart greetings** that change based on time of day
- 📅 **Current date display** 
- ⏱️ **Auto-refresh** using WidgetKit timeline (updates every minute)
- 🎨 **Modern UI** with iOS 17 containerBackground and iOS 16 fallback support
- 📱 Works on both **simulator and real devices**
- 🆓 **No paid Apple Developer account required**

## 🖼️ Screenshots
 
 <img width="269" height="295" alt="Screenshot 2026-01-19 at 7 03 31 PM" src="https://github.com/user-attachments/assets/2e15e3f4-43ad-495c-a155-ff19dc0da510" />

## 🛠 Technologies Used

- **SwiftUI** - Modern declarative UI framework
- **WidgetKit** - Apple's widget framework
- **TimelineProvider** - Efficient widget updates 

## 📂 Project Structure

```
LiveActivityTimer/
├── LiveActivityTimer/              # Main App
│   ├── ContentView.swift
│   └── LiveActivityTimerApp.swift
│
└── LiveActivityWidget/              # Widget Extension
    ├── LiveActivityWidget.swift
    └── LiveActivityWidgetBundle.swift
```

The main app serves as the host for the widget. All widget logic is contained within the Widget Extension.

## 🚀 Getting Started

### Prerequisites

- Xcode 14.0 or later
- iOS 16.0+ deployment target
- macOS Ventura or later

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/smart-daily-widget.git
   cd smart-daily-widget
   ```

2. **Open in Xcode**
   ```bash
   open LiveActivityTimer.xcodeproj
   ```

3. **Select the main app target** (`LiveActivityTimer`)

4. **Run the project**
   - Choose your target device or simulator
   - Press `⌘ + R` or click the Run button
   - The app must launch at least once to register the widget

## ➕ Adding the Widget to Home Screen

1. Long-press on any empty area of your Home Screen
2. Tap the **➕** button in the top-left corner
3. Search for **"Smart Daily Widget"**
4. Select the **Small** widget size
5. Tap **Add Widget**
6. Position the widget and tap **Done**

The widget will automatically update every minute! 🎉

## 🧠 How It Works

Widgets use a **timeline-based approach** rather than continuous execution. This ensures battery efficiency while maintaining up-to-date information.

### Timeline Flow

1. System calls the `TimelineProvider`
2. Provider generates timeline entries
3. Widget UI updates at scheduled times
4. Process repeats automatically

### Key Components

#### 1. Timeline Entry

```swift
struct SmartEntry: TimelineEntry {
    let date: Date
}
```

Represents a single snapshot of data displayed by the widget.

#### 2. Timeline Provider

```swift
struct SmartProvider: TimelineProvider {
    func getTimeline(in context: Context, completion: @escaping (Timeline<SmartEntry>) -> Void) {
        let currentDate = Date()
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        
        let entry = SmartEntry(date: currentDate)
        
        completion(
            Timeline(entries: [entry], policy: .after(nextUpdate))
        )
    }
}
```

The brain of the widget that determines:
- What content to display
- When to schedule the next update

**Updates every 1 minute** following Apple's recommended practices.

#### 3. Smart Greeting Logic

```swift
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
```

Context-aware greetings that adapt throughout the day.

#### 4. Modern Background API with Fallback

```swift
if #available(iOS 17.0, *) {
    VStack { /* content */ }
        .containerBackground(.fill.tertiary, for: .widget)
} else {
    VStack { /* content */ }
        .background(Color(.systemBackground))
}
```

- ✅ Uses modern `containerBackground` API on iOS 17+
- ✅ Graceful fallback for iOS 16
- ✅ Avoids build warnings and errors

#### 5. Widget Configuration

```swift
StaticConfiguration(
    kind: "SmartDailyWidget",
    provider: SmartProvider()
) { entry in
    SmartWidgetView(entry: entry)
}
.configurationDisplayName("Smart Daily Widget")
.description("Stay updated with time, date, and smart greetings.")
```

## 🎨 Customization

You can easily customize the widget by modifying:

- **Update frequency** - Change the timeline interval in `SmartProvider`
- **Greeting messages** - Edit the switch statement in the greeting logic
- **UI styling** - Modify colors, fonts, and spacing in `SmartWidgetView`
- **Widget sizes** - Add medium or large widget variants

## 📖 Learning Resources

This project demonstrates:

- WidgetKit fundamentals
- Timeline-based updates
- iOS version compatibility handling
- SwiftUI widget layouts
- Best practices for battery-efficient widgets

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
