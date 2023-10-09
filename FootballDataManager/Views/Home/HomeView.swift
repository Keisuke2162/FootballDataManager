//
//  HomeView.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/01.
//

import SwiftUI

struct HomeView: View {
    let leagues: [League] = [.init(leagueID: "39", name: "Premier", imageString: "logo-premier"),
                             .init(leagueID: "135", name: "SerieA", imageString: "logo-seriea"),
                             .init(leagueID: "140", name: "LaLiga", imageString: "logo-laliga"),
                             .init(leagueID: "78", name: "Bundes", imageString: "logo-bundes")]

    var body: some View {
        NavigationView {
            ZStack {
                List(leagues, id: \.self) { item in
                    NavigationLink {
                        StandingView(leagueID: item.leagueID)
                    } label: {
                        HStack(spacing: 16.0) {
                            Image(item.imageString)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Text(item.name)
                                .foregroundColor(Color.white)
                                .font(.custom("SSportsD-Medium", size: 16))
                        }
                    }
                    .frame(height: 46)
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
                .background(Color.init("SkySportsRed"))
                .listStyle(.grouped)
                SelectLeagueView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
