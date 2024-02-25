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
            VStack(spacing: 16) {
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
                .background(store.state.leagueType.themaColor)
                // 得点者
                
                // スタッツ表示領域
                if let homeFixtureDetail = store.state.fixtureDetailHome, let awayFixtureDetail = store.state.fixtureDetailAway {
                    VStack(spacing: 24) {
                        // 総シュート
                        FixtureDetailStatsCell(statsType: .totalShots,
                                               homeValue: homeFixtureDetail.totalShots,
                                               awayValue: awayFixtureDetail.totalShots)
                        // 枠内シュート
                        FixtureDetailStatsCell(statsType: .shotsOnGoal,
                                               homeValue: homeFixtureDetail.shotsOnGoal,
                                               awayValue: awayFixtureDetail.shotsOnGoal)
                        // ポゼッション
                        FixtureDetailStatsCell(statsType: .ballPossession,
                                               homeValue: homeFixtureDetail.ballPossession,
                                               awayValue: awayFixtureDetail.ballPossession)
                        // xG
                        FixtureDetailStatsCell(statsType: .expectedGoals,
                                               homeValue: homeFixtureDetail.expectedGoals,
                                               awayValue: awayFixtureDetail.expectedGoals)
                    }
                }

                // メンバー
                
                
                
                Spacer()
            }
            .background(store.state.leagueType.themaColor)
        }
        .task {
            do {
                try await Task.sleep(for: .milliseconds(300))
                await store.send(.fetchFixtureDetail).finish()
            } catch {}
        }
    }
}

#Preview {
    FixtureDetailView(store: Store(initialState: FixtureDetailReducer.State(leagueType: .japan, fixture: Fixture.mock), reducer: {
        FixtureDetailReducer()
    }))
}
