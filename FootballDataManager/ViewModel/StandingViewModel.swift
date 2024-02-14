//
//  StandingViewModel.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/02.
//

import Foundation
import SwiftUI

final class StandingViewModel: ObservableObject {
    @Published var list: [Standing] = []
    private let standingListAPIClient = StandingListAPIClient()
    // Concurrency実装
    func getStandings(_ id: String) {
        Task {
            do {
                let items = try await standingListAPIClient.getStanding(leagueID: id)
                self.list = items
            } catch {
                // エラー処理
                print("Error")
            }
        }
    }
    
    /*
     Concurrencyを使わない旧実装
     */
    func getTableList(_ id: String) {
        standingListAPIClient.getLeagueTable(leagueID: id) { result in
            switch result {
            case .success(let res):
                self.list = res.response.first?.league.standings.first ?? []
            case .failure(let failure):
                print("Error \(failure.title)")
            }
        }
    }
}
