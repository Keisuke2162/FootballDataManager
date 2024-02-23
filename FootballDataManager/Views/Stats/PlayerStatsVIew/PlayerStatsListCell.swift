//
//  PlayerStatsCellView.swift
//  FootballDataManager
//
//  Created by Kei on 2024/02/23.
//

import Kingfisher
import SwiftUI

struct PlayerStatsListCell: View {
    let playerStatsItem: PlayerStats

    var body: some View {
        HStack(spacing: 16.0) {
            let imageURL = URL(string: playerStatsItem.statistics[0].team.logo)
            KFImage(imageURL)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            Text(playerStatsItem.player.name)
                .foregroundColor(Color.white)
                .font(.custom("SSportsD-Medium", size: 12))
            Spacer()
            Text("\(playerStatsItem.statistics[0].goals.total ?? 0)")
                .foregroundColor(Color.white)
                .font(.custom("SSportsD-Medium", size: 16))
        }
    }
}
