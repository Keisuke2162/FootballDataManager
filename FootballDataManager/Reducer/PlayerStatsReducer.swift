//
//  PlayerStatsReducer.swift
//  FootballDataManager
//
//  Created by Kei on 2024/02/23.
//

import Foundation
import ComposableArchitecture

@Reducer
struct PlayerStatsReducer {
    @ObservableState
    struct State: Equatable {
        let leagueType: LeagueType
        var topScorerStats: [PlayerStats] = []
    }

    enum Action {
        case fetchTopScorer
        case topScorerResponse(Result<[PlayerStats], Error>)
    }

    @Dependency(\.statsAPIClient) var statsAPIClient
    private enum CancelID { case stats }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchTopScorer:
                return .run { [leagueType = state.leagueType] send in
                    await send(.topScorerResponse(Result { try await self.statsAPIClient.getTopScorers(leagueType) }))
                }
                .cancellable(id: CancelID.stats)
            case .topScorerResponse(.failure):
                return .none
            case let .topScorerResponse(.success(response)):
                state.topScorerStats = response
                return .none
            }
        }
    }
}
