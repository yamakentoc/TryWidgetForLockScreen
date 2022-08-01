//
//  SunSetTimeWidget.swift
//  TryWidgetForLockScreen
//
//  Created by 山口賢登 on 2022/08/01.
//

import SwiftUI
import WidgetKit

/// 日没時刻Widget
struct SunSetTimeWidget: Widget {
    let kind: String = "com.yamakentoc.TryWidgetForLockScreen.SunSetTimeWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            SunSetTimeWidgetView()
        }
        .configurationDisplayName("太陽の状況")
        .description("現在地の太陽の状況を表示できます。")
        .supportedFamilies([.accessoryCircular])
    }
}

/// 日没時刻WidgetのView
private struct SunSetTimeWidgetView: View {
    
    var sunsetDate: Date {
        let calendar = Calendar(identifier: .japanese)
        let date = calendar.date(from: DateComponents(hour: 18, minute: 53))!
        return date
    }
    
    var body: some View {
        ZStack {
            AccessoryWidgetBackground()
            VStack {
                Image(systemName: "sunset.fill")
                Text(sunsetDate, style: .time)
            }
        }
    }
}

struct SunSetTimeWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        SunSetTimeWidgetView()
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
            .previewDisplayName("日没時刻のWidget")
    }
}
