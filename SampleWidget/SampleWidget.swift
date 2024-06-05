//
//  SampleWidget.swift
//  SampleWidget
//
//  Created by Fabio Freitas on 24/05/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), n: Date().formatted(date: .complete, time: .complete))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), n: Date().formatted(date: .complete, time: .complete))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
//        let n = "\(SampleUserDefaultStorage.shared.fetchNumber())"
        var n: String = ""
        do {
            let context = CoreDataStack.shared.persistentContainer.viewContext
            let res = try context.fetch(SampleEntity.fetchRequest())
            if let f = res.first {
                n = f.date?.formatted(date: .complete, time: .complete) ?? ""
            }
        } catch {
            print(error.localizedDescription)
        }
        
        entries.append(.init(date: Date(), n: n))
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let n: String
}

struct SampleWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.showsWidgetLabel) var showsWidgetLabel
    
    var entry: Provider.Entry
    
    @State var test = "NOTHING"

    var body: some View {
        Group {
            
            switch widgetFamily {
            case .accessoryCorner:
                ZStack {
                    AccessoryWidgetBackground()
                    Image(systemName: "apple.logo")
                        .font(.title.bold())
                        .widgetAccentable()
                }
                .widgetLabel {
                    //                        Gauge(value: 100,
                    //                          in: 0...500) {
                    //                            Text("MG")
                    //                        } currentValueLabel: {
                    //                            Text("\(Int(100))")
                    //                        } minimumValueLabel: {
                    //                            Text("0")
                    //                        } maximumValueLabel: {
                    //                            Text("500")
                    //                        }
                    Text("Sample text")
                        .privacySensitive()
                }
                
            case .accessoryCircular:
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 4.0))
                    .foregroundStyle(.red)
                    .overlay {
                        VStack {
                            Text("Circular")
                                .font(.footnote)
                        }
                        .padding(2)
                    }
            case .accessoryRectangular:
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle())
                    .foregroundStyle(.orange.gradient)
                    .overlay {
                        HStack {
                            Image(systemName: "apple.logo")
                                .padding(.trailing)
                            VStack(alignment: .leading) {
//                                Text("Rectangle")
//                                    .bold()
                                Text(entry.n)
                                    .font(.footnote)
                            }
                            .padding(.leading)
                        }
                    }
            case .accessoryInline:
                ViewThatFits {
                    Text(entry.n)
                        .widgetAccentable()
                }
            default:
                EmptyView()
            }
        }
    }
}


struct SampleWidget: Widget {
    let kind: String = "SampleWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(watchOS 10.0, *) {
                SampleWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                SampleWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.accessoryCorner, .accessoryInline, .accessoryCircular, .accessoryRectangular])
    }
}

@main
struct SampleWidgetsBundle: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        SampleWidget()
    }
}

#Preview(as: .accessoryRectangular) {
    SampleWidget()
} timeline: {
    SimpleEntry(date: .now, n: Date().formatted(date: .complete, time: .complete))
}

