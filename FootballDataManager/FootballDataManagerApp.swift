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
            HomeView(store: Store(initialState: HomeReducer.State(), reducer: {
                HomeReducer()
            }))
        }
    }
}
