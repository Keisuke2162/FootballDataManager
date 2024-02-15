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
}
