//
//  StandingView.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/02.
//

import SwiftUI

struct StandingView: View {
    let leagueID: String
    @ObservedObject private var viewModel = StandingViewModel()

    var body: some View {
        VStack {
            List {
                ForEach(0 ..< viewModel.list.count, id: \.self) { index in
                    HStack(spacing: 16.0) {
                        let imageURL = URL(string: viewModel.list[index].team.logo)
                        AsyncImage(url: imageURL) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        Text(viewModel.list[index].team.name)
                    }
                    .frame(height: 46)
                }
            }
        }
        .onAppear {
            viewModel.getTableList(leagueID)
        }
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        StandingView(leagueID: "39")
    }
}
