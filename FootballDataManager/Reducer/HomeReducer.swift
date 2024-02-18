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
    }

    enum Action {
        case tapSelectLeagueButton
        case destination(PresentationAction<Destination.Action>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .tapSelectLeagueButton:
                state.destination = .changeLeague(SelectLeagueReducer.State(selectedLeagueType: state.selectedLeagueType))
                return .none
            case let .destination(.presented(.changeLeague(.delegate(.selectLeague(type))))):
                state.selectedLeagueType = type
                return .none
            case .destination:
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
