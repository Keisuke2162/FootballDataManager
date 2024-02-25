//
//  FixtureDetailReducer.swift
//  FootballDataManager
//
//  Created by Kei on 2024/02/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct FixtureDetailReducer {
    @ObservableState
    struct State: Equatable {
        let leagueType: LeagueType
        let fixture: Fixture
    }

    enum Action {
        case fetchFixtureDetail
        case fixturesResponse(Result<FixturesItem, Error>)
    }

    @Dependency(\.fixtureClient) var fixtureClient
    private enum CancelID { case fixtures }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchFixtureDetail:
                return .none
            case .fixturesResponse:
                return .none
            }
        }
    }
}
