//
//  ScheduleViewModel.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/09.
//

import Foundation
import SwiftUI

final class ScheduleViewModel: ObservableObject {
    @Published var items: [Fixture] = []
    @Published var selectedDateIndex = 0
    
    // 日付のキー管理
    var dateKeys: [String] {
        Dictionary(grouping: items) { item in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: item.fixture.date)
        }.keys.sorted()
    }

    private let scheduleAPIClient = ScheduleAPIClient()
    
    func getShcedules(_ id: String) {
        Task {
            do {
                let item = try await scheduleAPIClient.getSchedule(leagueID: id)
                self.items = item.response
            } catch {
                // エラー処理
                print("Error")
            }
        }
    }
}

