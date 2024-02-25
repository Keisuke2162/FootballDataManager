//
//  FootballDataManagerApp.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/01.
//

import ComposableArchitecture
import SwiftUI

@main
struct FootballDataManagerApp: App {
    var body: some Scene {
        WindowGroup {
//            HomeView(store: Store(initialState: HomeReducer.State(), reducer: {
//                HomeReducer()
//            }))
            FixtureDetailView(store: Store(initialState: FixtureDetailReducer.State(leagueType: .england, fixture: Fixture.mock), reducer: {
                FixtureDetailReducer()
            }))
        }
    }
}
