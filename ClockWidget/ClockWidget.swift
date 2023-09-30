//
//  ClockWidget.swift
//  ClockWidget
//
//  Created by Kngmin Kang on 9/30/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ClockEntry {
        ClockEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (ClockEntry) -> ()) {
        let entry = ClockEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [ClockEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = ClockEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct ClockEntry: TimelineEntry {
    let date: Date
}

struct ClockWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color(UIColor(red: 0x4E / 255.0, green: 0x6A / 255.0, blue: 0x78 / 255.0, alpha:1))
                .ignoresSafeArea() // Fill the entire widget area
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 400, alignment: .center)

            VStack {
                Text(entry.date.HourFormat)
                    .font(Font.custom("KCC-Ganpan", size: 65))
                    .foregroundColor(Color(UIColor(red: 0xF1 / 255.0, green: 0xA0 / 255.0, blue: 0x8D / 255.0, alpha:1)))
                    .multilineTextAlignment(.leading)
                    .padding(.leading, -50)
                    .padding(.bottom, -60)
                Text(entry.date.MinuteFormat)
                    .font(Font.custom("KCC-Ganpan", size: 65))
                    .foregroundColor(Color(UIColor(red: 0x1A / 255.0, green: 0x32 / 255.0, blue: 0x34 / 255.0, alpha:1)))
                    .multilineTextAlignment(.leading)
                    .padding(.leading, -15)
            }
        }
    }
}

struct ClockWidget: Widget {
    let kind: String = "ClockWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                ClockWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                ClockWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Clock Widget")
        .description("디지털 시계 모양 위젯입니다.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    ClockWidget()
} timeline: {
    ClockEntry(date: .now)
}

extension Date {
    var HourFormat: String {
        let formatter=DateFormatter()
            formatter.dateFormat="HH"
                       
            return formatter.string(from:self)
    }
    var MinuteFormat: String {
        let formatter=DateFormatter()
            formatter.dateFormat=":mm"
                       
            return formatter.string(from:self)
    }
}
