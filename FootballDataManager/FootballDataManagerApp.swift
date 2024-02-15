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
            StandingListView(store: Store(initialState: StandingListReducer.State(id: "39")) {
                StandingListReducer()
            })
        }
    }
}
