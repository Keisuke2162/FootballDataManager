//
//  StandingListReducer.swift
//  FootballDataManager
//
//  Created by Kei on 2024/02/16.
//

import Foundation
import ComposableArchitecture

@Reducer
struct StandingListReducer {
    @ObservableState
    struct State: Equatable {
        let id: String
        var standings: [Standing] = []
    }

    enum Action {
        case tapClubCell    // セルをタップ
        case fetchStandings(id: String)
    }

    @Dependency(\.standingClient) var standingClient
    private enum CancelID { case standing }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .tapClubCell:
                return .none
            case let .fetchStandings(_):
                return .none
            }
        }
    }
}
