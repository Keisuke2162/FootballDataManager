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

    func getFixtures(_ id: String) {
        scheduleAPIClient.getLeagueTable(leagueID: id) { result in
            switch result {
            case .success(let res):
                // 取得したデータ
                self.items = res.response
                
                // 取得した試合データのうち、試合日付が当日に近い未来日付を選択
                
            case .failure(let failure):
                print("Error \(failure.title)")
            }
        }
    }
}

