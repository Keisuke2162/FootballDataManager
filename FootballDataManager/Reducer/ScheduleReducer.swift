//
//  ScheduleReducer.swift
//  FootballDataManager
//
//  Created by Kei on 2024/02/18.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ScheduleReducer {
    @ObservableState
    struct State: Equatable {
        let leagueID: String
        var fixtures: [Fixture] = []
    }

    enum Action {
        case tapFixtureCell    // セルをタップ
        case fetchFixtures
        case fixturesResponse(Result<[Fixture], Error>)
    }

    @Dependency(\.standingClient) var standingClient
    private enum CancelID { case standing }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .tapFixtureCell:      // Cellタップ時
                return .none
            case .fetchFixtures:   // データ取得開始
                return .run { [leagueID = state.leagueID] send in
                    await send(.standingResponse(Result { try await self.standingClient.getStanding(id: leagueID) }))
                }
                .cancellable(id: CancelID.standing)
            case .fixturesResponse(.failure):   // APIエラー時
                return .none
            case let .fixturesResponse(.success(response)): // データ取得正常終了時
                state.standings = response
                return .none
            }
        }
    }
}
