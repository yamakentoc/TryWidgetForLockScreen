//
//  InputTextWidget.swift
//  WidgetsExtension
//
//  Created by 山口賢登 on 2022/08/04.
//

import WidgetKit
import SwiftUI

/// アプリ内で保存した文字を表示するWidget
struct InputTextWidget: Widget {
    let kind: String = "com.yamakentoc.TryWidgetForLockScreen.InputTextWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            InputTextWidgetView(entry: entry)
        }
        .configurationDisplayName("保存した文字列")
        .description("アプリ内でUserDefaultsを用いて保存した文字列を表示します。")
        .supportedFamilies([.accessoryRectangular])
    }
}

/// アプリ内で保存した文字を表示するWidgetのView
private struct InputTextWidgetView: View {
    
    let entry: SimpleEntry
    
    var body: some View {
        Text(
            """
            保存した文字列:
            \(entry.inputText)
            """
        )
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct InputTextWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        let entry = SimpleEntry(date: Date(), configuration: ConfigurationIntent(), inputText: "hoge")
        InputTextWidgetView(entry: entry)
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
            .previewDisplayName("アプリ内で保存した文字を表示するWidget")
    }
}
