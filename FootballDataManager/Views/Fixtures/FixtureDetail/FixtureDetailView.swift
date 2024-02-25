//
//  FixtureDetailView.swift
//  FootballDataManager
//
//  Created by Kei on 2024/02/25.
//

import ComposableArchitecture
import Kingfisher
import SwiftUI

struct FixtureDetailView: View {
    @Bindable var store: StoreOf<FixtureDetailReducer>

    var body: some View {
        NavigationStack {
            VStack {
                // スコア表示領域
                HStack {
                    Spacer()
                    KFImage(URL(string: store.state.fixture.teams.home.logo))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 56, height: 56)
                    Spacer()
                    Text(store.state.fixture.goals.home?.description ?? "")
                        .foregroundColor(Color.white)
                        .font(.custom("SSportsD-Medium", size: 24))
                    Text("-")
                        .foregroundColor(Color.white)
                        .font(.custom("SSportsD-Medium", size: 24))
                    Text(store.state.fixture.goals.away?.description ?? "")
                        .foregroundColor(Color.white)
                        .font(.custom("SSportsD-Medium", size: 24))
                    Spacer()
                    KFImage(URL(string: store.state.fixture.teams.away.logo))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 56, height: 56)
                    Spacer()
                }
                .frame(height: 160)
                .background(Color.blue)
                
                // 得点表示領域
                
                
                
                // スタッツ表示領域
                
                
                // メンバー表示領域
                
                
                
                Spacer()
            }
            .background(store.state.leagueType.themaColor)
        }
    }
}

#Preview {
    FixtureDetailView(store: Store(initialState: FixtureDetailReducer.State(leagueType: .england, fixture: Fixture.mock), reducer: {
        FixtureDetailReducer()
    }))
}
