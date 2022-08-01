//
//  NewsWidget.swift
//  TryWidgetForLockScreen
//
//  Created by 山口賢登 on 2022/08/01.
//

import WidgetKit
import SwiftUI

/// ニュースのWidget
struct NewsWidget: Widget {
    let kind: String = "com.yamakentoc.TryWidgetForLockScreen.NewsWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            NewsWidgetView()
        }
        .configurationDisplayName("今日")
        .description("トップストーリーなど、今日のニュースをお届けします。")
        .supportedFamilies([.accessoryRectangular])
    }
}

/// ニュースWidgetのView
private struct NewsWidgetView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(Image(systemName: "applelogo")) | HUFFINGTONPOST")
                .lineLimit(1)
                .font(.system(size: 13, weight: .heavy, design: .default))
                .opacity(0.6)
            Text("『SPY×FAMILY』作者が描いたコラボ絵が「素敵すぎる」と反響。西森博之さん作品にコメント")
                .font(.system(size: 13, weight: .bold, design: .monospaced))
        }
    }
}

struct NewsWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        NewsWidgetView()
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
            .previewDisplayName("ニュースWidget")
    }
}
