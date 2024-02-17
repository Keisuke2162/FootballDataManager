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

    @Dependency(\.fixtureScheduleClient) var fixtureScheduleClient
    private enum CancelID { case fixtures }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .tapFixtureCell:      // Cellタップ時
                return .none
            case .fetchFixtures:   // データ取得開始
                return .run { [leagueID = state.leagueID] send in
                    await send(.fixturesResponse(Result { try await self.fixtureScheduleClient.getFixtures(id: leagueID )}))
                }
                .cancellable(id: CancelID.fixtures)
            case .fixturesResponse(.failure):   // APIエラー時
                return .none
            case let .fixturesResponse(.success(response)): // データ取得正常終了時
                state.fixtures = response
                return .none
            }
        }
    }
}
