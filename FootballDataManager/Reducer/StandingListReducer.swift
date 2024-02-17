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
        let leagueID: String
        var standings: [Standing] = []
    }

    enum Action {
        case tapClubCell    // セルをタップ
        case fetchStandings
        case standingResponse(Result<[Standing], Error>)
    }

    @Dependency(\.standingClient) var standingClient
    private enum CancelID { case standing }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .tapClubCell:      // Cellタップ時
                return .none
            case .fetchStandings:   // データ取得開始
                return .run { [leagueID = state.leagueID] send in
                    await send(.standingResponse(Result { try await self.standingClient.getStanding(id: leagueID) }))
                }
                .cancellable(id: CancelID.standing)
            case .standingResponse(.failure):   // APIエラー時
                return .none
            case let .standingResponse(.success(response)): // データ取得正常終了時
                state.standings = response
                return .none
            }
        }
    }
}
