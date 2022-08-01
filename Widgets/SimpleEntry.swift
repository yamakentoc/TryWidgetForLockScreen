//
//  SimpleEntry.swift
//  TryWidgetForLockScreen
//
//  Created by 山口賢登 on 2022/08/01.
//

import WidgetKit

/// Widgetの更新情報。
struct SimpleEntry: TimelineEntry {
    /// Widgetを更新する時間（必須）
    let date: Date
    /// Intentの情報
    let configuration: ConfigurationIntent
    /// そのほかWidgetをレンダリングするのに必要な情報を追加する
}
