//
//  OceanWidget.swift
//  OceanWidget
//
//  Created by Kngmin Kang on 9/30/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> OceanEntry {
        OceanEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (OceanEntry) -> ()) {
        let entry = OceanEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [OceanEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = OceanEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct OceanEntry: TimelineEntry {
    let date: Date
}

struct OceanWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Image("Ocean")
                .resizable()
                .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 400, alignment: .center)
        }
    }
}

struct OceanWidget: Widget {
    let kind: String = "OceanWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                OceanWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                OceanWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Ocean Widget")
        .description("바다 배경 위젯입니다.")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    OceanWidget()
} timeline: {
    OceanEntry(date: .now)
}
