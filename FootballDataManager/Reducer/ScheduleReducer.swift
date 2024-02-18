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
        let leagueType: LeagueType
        var fixtures: [Fixture] = []
        var selectedDateIndex: Int = 0
        var groupedItems: [String: [Fixture]] = [:]
        var dateKeys: [String] = []
    }

    enum Action {
        case tapFixtureCell    // セルをタップ
        case fetchFixtures
        case fixturesResponse(Result<FixturesItem, Error>)
        case backDateButton
        case forwardDateButton
    }

    @Dependency(\.fixtureScheduleClient) var fixtureScheduleClient
    private enum CancelID { case fixtures }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .tapFixtureCell:      // Cellタップ時
                return .none
            case .fetchFixtures:   // データ取得開始
                return .run { [leagueType = state.leagueType] send in
                    await send(.fixturesResponse(Result { try await self.fixtureScheduleClient.getFixtures(leagueType) }))
                }
                .cancellable(id: CancelID.fixtures)
            case .fixturesResponse(.failure):   // APIエラー時
                return .none
            case let .fixturesResponse(.success(response)): // データ取得正常終了時
                state.fixtures = response.response
                state.groupedItems = response.groupedItems
                state.dateKeys = response.dateKeys
                return .none
            case .backDateButton:
                if state.selectedDateIndex > 0 {
                    state.selectedDateIndex -= 1
                }
                return .none
            case .forwardDateButton:
                if state.selectedDateIndex < state.dateKeys.count - 1 {
                    state.selectedDateIndex += 1
                }
                return .none
            }
        }
    }
}
