//
//  StandingView.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/02.
//

import ComposableArchitecture
import SwiftUI

struct StandingListView: View {
    @Bindable var store: StoreOf<StandingListReducer>

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    HStack(spacing: 16) {
                        Text("Pos")
                            .font(.custom("SSportsD-Medium", size: 12))
                            .frame(width: 24)
                        Text("Club")
                            .font(.custom("SSportsD-Medium", size: 12))
                            .frame(width: 32)
                            .padding(.leading, 46)
                        Spacer()
                        Text("P")
                            .font(.custom("SSportsD-Medium", size: 12))
                            .frame(width: 24)
                        Text("GD")
                            .font(.custom("SSportsD-Medium", size: 12))
                            .frame(width: 24)
                        Text("Pts")
                            .font(.custom("SSportsD-Medium", size: 12))
                            .frame(width: 24)
                    }
                    ForEach(store.standings) { standing in
                        StandingCellView(standingItem: standing)
                            .frame(height: 46)
                            .listRowBackground(Color.clear)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.init("SkySportsBlue"))
                .listStyle(.grouped)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.white, for: .navigationBar)
    }
}

#Preview {
    StandingListView(store: Store(initialState: StandingListReducer.State(id: "39"), reducer: {
        StandingListReducer()
    }))
}
