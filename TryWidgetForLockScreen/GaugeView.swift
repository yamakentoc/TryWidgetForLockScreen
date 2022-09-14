//
//  GaugeView.swift
//  TryWidgetForLockScreen
//
//  Created by 山口賢登 on 2022/09/14.
//

import SwiftUI

struct GaugeView: View {
    var body: some View {
        List {
            Section(header: Text("basic")) {
                //　単純な横長のゲージ（ProgressView的なもの）
                Gauge(value: 0.5) {
                    Text("Default")
                }
                
                // ゲージに最小値、最大値、現在の値と、それぞれにViewを置けるようになったもの
                Gauge(value: 200, in: 100...500) {
                    Text("max, min")
                } currentValueLabel: {
                    Text("200")
                } minimumValueLabel: {
                    Text("100")
                } maximumValueLabel: {
                    Text("500")
                }
                .tint(.red)
            }

            Section(header: Text("linear")) {
                // .gaugeStyle(_:)を指定することで円形、線形、カスタムの形状を指定できる
                // .linearCapacity：デフォルトのスタイル
                Gauge(value: 0.3) {
                    Text("linearCapacity")
                }
                .gaugeStyle(.linearCapacity)
                .tint(.orange)
                
                // acessoryLinear：線形。端から端まで塗りつぶし、現在の値を点で表す
                VStack {
                    // なぜかGauge内のTextが表示されない
                    Text("acessoryLinear")
                    Gauge(value: 0.7) {
                        Text("表示されない")
                    } currentValueLabel: {
                        Text("0.7")
                    }
                    .gaugeStyle(.accessoryLinear)
                    .tint(.green)
                }
                
                // accessoryLinearCapacity：線形。現在の値までを塗りつぶし、現在の値を表す
                Gauge(value: 0.3) {
                    Text("accessoryLinearCapacity")
                } currentValueLabel: {
                    Text("0.3")
                }
                .gaugeStyle(.accessoryLinearCapacity)
                .tint(.orange)
            }
            
            Section(header: Text("Circular")) {
                // accessoryCircular：円形。accessoryLinearの円バージョン
                HStack {
                    Text("accessoryCircular")
                    Spacer()
                    Gauge(value: 0.6) {
                        Image(systemName: "swift")
                            .foregroundColor(.orange)
                    } currentValueLabel: {
                        Text("0.6")
                    }
                    .gaugeStyle(.accessoryCircular)
                    
                    
                    Gauge(value: 180, in: 0...200) {
                        
                    } currentValueLabel: {
                        Text("180")
                            .font(.headline)
                            .foregroundColor(.red)
                    } minimumValueLabel: {
                        Text("0")
                            .foregroundColor(.green)
                    } maximumValueLabel: {
                        Text("200")
                            .foregroundColor(.red)
                    }
                    .gaugeStyle(.accessoryCircular)
                    .tint(Gradient(colors: [.green, .yellow, .orange, .red]))
                }
                // accessoryCircular：円形。accessoryLinearの円バージョン
                HStack {
                    Text("accessoryCircular")
                    Spacer()
                    Gauge(value: 30, in: 0...100) {
                    } currentValueLabel: {
                        Text("30%")
                            .font(.headline)
                    }
                    .gaugeStyle(.accessoryCircularCapacity)
                    .tint(.cyan)
                    
                    Gauge(value: 0.5) {
                    } currentValueLabel: {
                        Image(systemName: "speaker.wave.3", variableValue: 0.5)
                            .font(.title)
                    }
                    .gaugeStyle(.accessoryCircularCapacity)
                    .tint(.cyan)
                }
            }
        }
    }
}

struct PractiveShapeView: View {
    var body: some View {
        VStack {
            // Pathの基本
            Path { path in
                path.addEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 100))
            }
            .fill(Color.pink)

            // 楕円のView
            CustomEllipse()
                .fill(Color.orange)
                .frame(width: 200, height: 200)
            
            // 円弧のView
            HStack {
                Text("180")
                CustomArc(0, 120)
                    .fill(Color.blue)
                Text("0")
            }
            .padding()
            
            CustomArc(135, 405)
                .stroke(lineWidth: 10)
                .fill(Color.yellow)
                
            CustomArc(0, 270)
                .stroke(lineWidth: 10)
                .fill(Color.yellow)
                // 135度回転させることによって、0度から円弧の描画が始まっても実質135度の位置から始まるようになる
                .rotationEffect(Angle(degrees: 135), anchor: UnitPoint(x: 0.5, y: 0.5))
                // 参考：https://stackoverflow.com/questions/57992780/how-to-change-anchor-of-rotation-angle-to-center-with-cgaffinetransform
            
        }
    }
    
    // 楕円を描くShapeのカスタムView
    struct CustomEllipse: Shape {
        func path(in rect: CGRect) -> Path {
            Path { path in
                path.addEllipse(in: CGRect(x: 0, y: 0, width: rect.width, height: rect.height))
            }
        }
    }
    
    // 円弧を描くShapeのカスタムView
    struct CustomArc: Shape {
        
        var start = 0.0
        var end = 0.0
        
        init(_ start: Double = 0.0, _ end: Double = 0.0) {
            self.start = start
            self.end = end
        }
        
        func path(in rect: CGRect) -> Path {
            /// 半径
            let radius = min(rect.width, rect.height) / 2
                        
            return Path { path in
                path.addArc(center: CGPoint(x: rect.width / 2, y: rect.height / 2),
                            radius: radius,
                            startAngle: .degrees(start), // 円弧の開始角度。degrees 角度指定
                            endAngle: .degrees(end),
                            clockwise: false) // 時計回り: false、反時計: true
            }
        }
    }
    
}



struct GaugeView_Previews: PreviewProvider {
    static var previews: some View {
        GaugeView()
        PractiveShapeView()
    }
}

