//
//  Widgets.swift
//  Widgets
//
//  Created by 山口賢登 on 2022/08/01.
//

import WidgetKit
import SwiftUI

/// Widgetのエントリポイント
@main
struct Widgets: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        // 気象情報のWidget
        WeatherConditionsWidget()
        // 日没時刻のWidget
        SunSetTimeWidget()
        // ニュースのWidget
        NewsWidget()
        // 気温のWidget
        TemperatureWidget()
        // 降水確率のWidget
        RainyPercentWidget()
        // アプリ内で保存した文字を表示するWidget
        InputTextWidget()
    }
}
