import WidgetKit
import SwiftUI

// MARK: - Timeline Entry
struct SmartEntry: TimelineEntry {
    let date: Date
}

// MARK: - Timeline Provider
struct SmartProvider: TimelineProvider {

    func placeholder(in context: Context) -> SmartEntry {
        SmartEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SmartEntry) -> Void) {
        completion(SmartEntry(date: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SmartEntry>) -> Void) {

        let currentDate = Date()
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!

        let entry = SmartEntry(date: currentDate)

        completion(
            Timeline(entries: [entry], policy: .after(nextUpdate))
        )
    }
}

// MARK: - Widget View
struct SmartWidgetView: View {

    let entry: SmartProvider.Entry

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

    var body: some View {
        content
    }

    @ViewBuilder
    private var content: some View {
        if #available(iOS 17.0, *) {
         
            VStack(alignment: .leading, spacing: 8) {
                widgetContent
            }
            .padding()
            .containerBackground(.fill.tertiary, for: .widget)
        } else {
            
            VStack(alignment: .leading, spacing: 8) {
                widgetContent
            }
            .padding()
            .background(Color(.systemBackground))
        }
    }

    private var widgetContent: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text(greeting)
                .font(.system(size: 10, weight: .bold))

            Text(entry.date, style: .time)
                .font(.system(size: 18, weight: .bold))
                .monospacedDigit()

            Text(entry.date, format: .dateTime.weekday(.wide).month().day())
                .font(.caption)
                .foregroundColor(.secondary)

            Spacer()
        }
    }
}

// MARK: - Widget Definition
struct LiveActivityWidget: Widget {

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "SmartDailyWidget",
            provider: SmartProvider()
        ) { entry in
            SmartWidgetView(entry: entry)
        }
        .configurationDisplayName("Smart Daily Widget")
        .description("Shows greeting, time, and date.")
        .supportedFamilies([.systemSmall])
    }
}
