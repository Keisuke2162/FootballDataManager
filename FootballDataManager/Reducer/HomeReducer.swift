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
        var fixtureSchedule = ScheduleReducer.State(leagueType: .england)
    }

    enum Action {
        case tapSelectLeagueButton
        case destination(PresentationAction<Destination.Action>)
        case standingList(StandingListReducer.Action)
        case fixtureSchedule(ScheduleReducer.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.standingList, action: \.standingList) {
            StandingListReducer()
        }
        Scope(state: \.fixtureSchedule, action: \.fixtureSchedule) {
            ScheduleReducer()
        }
        Reduce { state, action in
            switch action {
            case .tapSelectLeagueButton:
                state.destination = .changeLeague(SelectLeagueReducer.State(selectedLeagueType: state.selectedLeagueType))
                return .none
            case let .destination(.presented(.changeLeague(.delegate(.selectLeague(type))))):
                state.selectedLeagueType = type
                state.standingList = .init(leagueType: type)
                state.fixtureSchedule = .init(leagueType: type)
                return .run { send in
                    await send(.standingList(.fetchStandings))
                    await send(.fixtureSchedule(.fetchFixtures))
                }
            case .destination:
                return .none
            case .standingList:
                return .none
            case .fixtureSchedule:
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
        case fixtureSchedule(ScheduleReducer)
    }
}
