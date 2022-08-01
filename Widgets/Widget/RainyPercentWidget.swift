//
//  RainyPercentWidget.swift
//  WidgetsExtension
//
//  Created by 山口賢登 on 2022/08/02.
//

import SwiftUI
import WidgetKit

/// 降水確率Widget
struct RainyPercentWidget: Widget {
    let kind: String = "com.yamakentoc.TryWidgetForLockScreen.RainyPercentWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            RainyPercentWidgetView()
        }
        .configurationDisplayName("降水")
        .description("現在地の雨、雪、みぞれ、霧または雹の予想を表示します。")
        .supportedFamilies([.accessoryCircular])
    }
}

/// 降水WidgetのView
private struct RainyPercentWidgetView: View {
    /// 現在の降水確率
    let currentRainyPercent = 60.0
    
    var body: some View {
        Gauge(value: currentRainyPercent, in: 0...100) {
            Image(systemName: "cloud.rain.fill")
        } currentValueLabel: {
            Text("\(Int(currentRainyPercent))%")
                .font(.headline)
        }
        .gaugeStyle(CustomGaugeStyle(currentValue: currentRainyPercent))
    }
}

/// ゲージのカスタムスタイル
private struct CustomGaugeStyle: GaugeStyle {
    /// 現在の値
    let currentValue: Double
    /// ゲージのView
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            ArcView(currentValue: currentValue)
            configuration.currentValueLabel
            VStack {
                Spacer()
                configuration.label
                    .font(.caption)
            }
        }
    }
    
    /// 円弧を最大値用と現在の値用の2つを生成
    struct ArcView: View {
        /// 現在の値
        let currentValue: Double
        /// 最大値
        let maximumValue: Double = 270.0
        
        init(currentValue: Double) {
            // 円のサイズに合わせるために2.7（最大値270/100）をかける
            self.currentValue = currentValue * 2.7
        }
        
        var body: some View {
            ZStack {
                // 最大値用
                Arc(end: maximumValue)
                    .stroke(lineWidth: 12)
                    .rotationEffect(Angle(degrees: 135), anchor: UnitPoint(x: 0.5, y: 0.5))
                    .opacity(0.5)
                // 現在の値用
                Arc(end: currentValue)
                    .stroke(lineWidth: 12)
                    .rotationEffect(Angle(degrees: 135), anchor: UnitPoint(x: 0.5, y: 0.5))
            }
        }
    }
    
    /// 円弧を生成
    struct Arc: Shape {
        /// 円弧の終了角度
        let end: Double
        
        init(end: Double) {
            self.end = end
        }
        
        func path(in rect: CGRect) -> Path {
            let radius = min(rect.width, rect.height) / 2
            return Path { path in
                path.addArc(center: CGPoint(x: rect.width / 2, y: rect.height / 2),
                            radius: radius,
                            startAngle: .degrees(0), // 円弧の開始角度
                            endAngle: .degrees(end),
                            clockwise: false) // false：時計回り、true：反時計回り
            }
        }
    }
    
}

struct RainyPercentWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        RainyPercentWidgetView()
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
            .previewDisplayName("降水Widget")
    }
}

