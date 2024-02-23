//
//  StatsView.swift
//  FootballDataManager
//
//  Created by Kei on 2024/02/21.
//

import ComposableArchitecture
import SwiftUI

struct StatsView: View {
    @Bindable var store: StoreOf<StatsReducer>

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.topScorer) { topScorer in
                    
                    
                    
                    
                    Text(topScorer.player.name)
                }
                Spacer().frame(height: 50).listRowBackground(EmptyView())
            }
            .scrollContentBackground(.hidden)
            .background(store.state.leagueType.themaColor)
            .listStyle(.grouped)
        }
        .task {
            do {
                try await Task.sleep(for: .milliseconds(300))
                await store.send(.fetchTopScorer).finish()
            } catch {}
        }
    }
}

#Preview {
    StatsView(store: Store(initialState: StatsReducer.State(leagueType: .england), reducer: {
        StatsReducer()
    }))
}
