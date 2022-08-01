//
//  TemperatureWidget.swift
//  WidgetsExtension
//
//  Created by 山口賢登 on 2022/08/02.
//

import SwiftUI
import WidgetKit

/// 気温Widget
struct TemperatureWidget: Widget {
    let kind: String = "com.yamakentoc.TryWidgetForLockScreen.TemperatureWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            TemperatureWidgetView()
        }
        .configurationDisplayName("気温")
        .description("現在地の気温を表示できます。")
        .supportedFamilies([.accessoryCircular])
    }
}

/// 気温WidgetのView
private struct TemperatureWidgetView: View {
        
    var body: some View {
        Gauge(value: 28, in: 26...37) {
            // ゲージの中央下に表示するView
        } currentValueLabel: {
            Text("28")
        } minimumValueLabel: {
            Text("26")
        } maximumValueLabel: {
            Text("37")
        }
        .gaugeStyle(.accessoryCircular)
    }
}

struct TemperatureWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureWidgetView()
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
            .previewDisplayName("気温Widget")
    }
}

