//
//  WeekDayWidget.swift
//  WeekDayWidget
//
//  Created by Kngmin Kang on 9/30/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct WeekDayWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color(UIColor(red: 0x4E / 255.0, green: 0x6A / 255.0, blue: 0x78 / 255.0, alpha:1))
                .ignoresSafeArea() // Fill the entire widget area
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 400, alignment: .center)
            
            VStack {
                Text(entry.date.WeekDayFormat)
                    .font(Font.custom("KCC-Ganpan", size: 60))
                    .textCase(.uppercase)
                    .foregroundColor(Color(UIColor(red: 0xF1 / 255.0, green: 0xA0 / 255.0, blue: 0x8D / 255.0, alpha:1)))
                    .padding(.bottom)
                Text(entry.date.DateFormat)
                    .font(Font.custom("KCC-Ganpan", size: 20))
                    .textCase(.uppercase)
                    .foregroundColor(Color(UIColor(red: 0x1A / 255.0, green: 0x32 / 255.0, blue: 0x34 / 255.0, alpha:1)))
                    .padding(.top, -30)
            }
        }
    }
}

struct WeekDayWidget: Widget {
    let kind: String = "WeekDayWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WeekDayWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                WeekDayWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Weekday Widget")
        .description("요일을 표시하는 위젯입니다.")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    WeekDayWidget()
} timeline: {
    SimpleEntry(date: .now)
}

extension Date {
    var WeekDayFormat: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    var DateFormat: String {
        self.formatted(.dateTime.month(.wide).day())
    }
}

