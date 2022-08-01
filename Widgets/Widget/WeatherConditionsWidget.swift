//
//  WeatherConditionsWidget.swift
//  TryWidgetForLockScreen
//
//  Created by 山口賢登 on 2022/08/01.
//

import WidgetKit
import SwiftUI

/// 気象情報Widget
struct WeatherConditionsWidget: Widget {
    /// Widgetは複数設定できるのでWidgetごとの識別子を設定する
    let kind: String = "com.yamakentoc.TryWidgetForLockScreen.WeatherConditionsWidget"

    var body: some WidgetConfiguration {
        // provider：このWidgetの更新タイミングを設定する
        // entry：Widgetの更新情報
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            // 本来はentryをViewに渡し、Viewはentryを基にWidgetを更新（レンダリング）する
            WeathreConditionsWidgetView()
        }
        // ギャラリーで表示するWidgetの名前
        .configurationDisplayName("気象情報")
        // Widgetの説明
        .description("現在地の気象状況を表示できます。")
        // このWidgetがサポートするWidgetの種類
        .supportedFamilies([.accessoryRectangular])
    }
}

/// 気象情報WidgetのView
private struct WeathreConditionsWidgetView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Image(systemName: "sun.max.fill")
                Text("32")
            }
            .font(.headline)
            .widgetAccentable()
            Text("ほぼ晴れ")
                .font(.body)
            Text("最高:33° 最低:23°")
                .font(.headline)
                .fontWeight(.medium)
                .opacity(0.6)
        }
    }
}

struct WeathreConditionsWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WeathreConditionsWidgetView()
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
            .previewDisplayName("気象状況Widget")
    }
}
