//
//  StatsContainerReducer.swift
//  FootballDataManager
//
//  Created by Kei on 2024/02/23.
//

import ComposableArchitecture
import Foundation

@Reducer
struct StatsContainerReducer {
    @ObservableState
    struct State: Equatable {
        var selectedStatsType: StatType = .topScorers
        var topScorerList = PlayerStatsReducer.State(leagueType: .england, statType: .topScorers)
        var topAssistList = PlayerStatsReducer.State(leagueType: .england, statType: .topAssists)
    }

    enum Action {
        case selectedType(StatType)
        case topScorerList(PlayerStatsReducer.Action)
        case topAssistList(PlayerStatsReducer.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.topScorerList, action: \.topScorerList) {
            PlayerStatsReducer()
        }
        Scope(state: \.topAssistList, action: \.topAssistList) {
            PlayerStatsReducer()
        }
        Reduce { state, action in
            switch action {
            case let .selectedType(type):
                state.selectedStatsType = type
                return .none
            case .topScorerList:
                return .none
            case .topAssistList:
                return .none
            }
        }
    }
}
