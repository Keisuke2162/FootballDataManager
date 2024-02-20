//
//  HomeView.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/01.
//

import ComposableArchitecture
import SwiftUI

@MainActor
struct HomeView: View {
    @Bindable var store: StoreOf<HomeReducer>

    var body: some View {
        NavigationView {
            ZStack {
                TabView {
                    StandingView(store: store.scope(state: \.standingList, action: \.standingList))
                        .tabItem {
                            Image(systemName: "clock")
                            Text("Table")
                        }
                        .toolbarBackground(.white, for: .tabBar)
                        .toolbarBackground(.visible, for: .tabBar)
                    FixturesView(store: store.scope(state: \.fixtureSchedule, action: \.fixtureSchedule))
                        .tabItem {
                            Image(systemName: "clock")
                            Text("Fixture")
                        }
                        .toolbarBackground(.white, for: .tabBar)
                        .toolbarBackground(.visible, for: .tabBar)
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            store.send(.tapSelectLeagueButton)
                        } label: {
                            store.state.selectedLeagueType.iconImage
                                .resizable()
                                .frame(width: 40, height: 40)
                                .padding()
                        }
                        .background(Color.white)
                        .cornerRadius(40)
                        .padding(20)
                    }
                    
                    Spacer().frame(height: 50).listRowBackground(EmptyView())
                }
            }
        }
        .sheet(item: $store.scope(state: \.destination?.changeLeague, action: \.destination.changeLeague)) { changeLeagueStore in
            SelectLeagueView(store: changeLeagueStore)
        }
    }
}

#Preview {
    HomeView(store: .init(initialState: HomeReducer.State(), reducer: {
        HomeReducer()
    }))
}
