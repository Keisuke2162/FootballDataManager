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
//            StandingListView(store: Store(initialState: StandingListReducer.State(leagueID: "39")) {
//                StandingListReducer()
//            })
            ScheduleView(store: Store(initialState: ScheduleReducer.State(leagueType: .england), reducer: {
                ScheduleReducer()
            }))
        }
    }
}
