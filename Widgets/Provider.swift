//
//  Provider.swift
//  TryWidgetForLockScreen
//
//  Created by 山口賢登 on 2022/08/01.
//

import Intents
import WidgetKit

/// Widgetの更新タイミングをWidgetKitに知らせるTimelineProvider
/// StaticConfigurationの場合：TimelineProvierプロトコルに準拠
/// IntentConfigurationの場合：IntentTimelineProviderプロトコルに準拠
struct Provider: IntentTimelineProvider {
    // 読み込み中などに表示するplaceholder
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }
    // ギャラリー用のViewを提供する
    // configuratoin.hogehogeで、Intentファイルに定義したhogehogeプロパティにアクセスできる
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    // WidgetはTimelineの更新に連動して更新される。そのTimelineを生成し、実際のWidget表示用のViewを提供する
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        /// TImelineEntryの配列を作成
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        /// 15分おきに更新する
        let entryDate = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate)!
        /// 更新時刻を設定したTImelineEntryを生成
        let entry = SimpleEntry(date: entryDate, configuration: configuration)
        entries.append(entry)
        /// TimelineEntryの配列からTimelineを生成
        /// policy（Timelineの更新タイミング）は以下の3種類
        /// .atEnd：最後のTimelineEntryを表示したとき
        /// .after(date)：指定した時間が経過したとき
        /// .never：アプリからWidgetCenterを利用して更新の通知がされたとき
        let timeline = Timeline(entries: entries, policy: .after(entryDate))
        // Timelineを返す
        completion(timeline)
    }
}
