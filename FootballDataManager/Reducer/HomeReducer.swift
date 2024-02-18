//
//  HomeReducer.swift
//  FootballDataManager
//
//  Created by Kei on 2024/02/18.
//

import Foundation
import ComposableArchitecture

@Reducer
struct HomeReducer {
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
        var selectedLeagueType: LeagueType = .england
        var standingList = StandingListReducer.State(leagueType: .england)
    }

    enum Action {
        case tapSelectLeagueButton
        case destination(PresentationAction<Destination.Action>)
        case standingList(StandingListReducer.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.standingList, action: \.standingList) {
            StandingListReducer()
        }
        Reduce { state, action in
            switch action {
            case .tapSelectLeagueButton:
                state.destination = .changeLeague(SelectLeagueReducer.State(selectedLeagueType: state.selectedLeagueType))
                return .none
            case let .destination(.presented(.changeLeague(.delegate(.selectLeague(type))))):
                state.selectedLeagueType = type
                state.standingList = .init(leagueType: type)
                return .run { send in
                    await send(.standingList(.fetchStandings))
                }
            case .destination:
                return .none
            case .standingList:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

extension HomeReducer {
    @Reducer(state: .equatable)
    enum Destination {
        case changeLeague(SelectLeagueReducer)
    }
}
