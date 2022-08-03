//
//  ContentView.swift
//  TryWidgetForLockScreen
//
//  Created by 山口賢登 on 2022/08/01.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    
    @State var text = ""
    
    let appGroupIdentifier = "group.com.yamakentoc.TryWidgetForLockScreen"
        
    var body: some View {
        VStack {
            TextField("Widgetへ表示するテキスト", text: $text)
                .textFieldStyle(.roundedBorder)
                
            Button(action: {
                // suiteNameにApp GroupsのIdentifierを指定する
                let userDefaults = UserDefaults(suiteName: appGroupIdentifier)
                userDefaults?.setValue(text, forKey: "inputText")
                // ボタンタップ時すぐにWidgetを更新する
                WidgetCenter.shared.reloadAllTimelines()
            }) {
                Text("保存")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
