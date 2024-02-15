//
//  StandingView.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/02.
//

import SwiftUI

struct StandingListView: View {
    let leagueID: String
    @ObservedObject private var viewModel = StandingViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
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
                    ForEach(0 ..< viewModel.list.count, id: \.self) { index in
                        StandingCellView(standingItem: viewModel.list[index])
                        .frame(height: 46)
                        .listRowBackground(Color.clear)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.init("SkySportsBlue"))
                .listStyle(.grouped)
            }
            .onAppear {
                viewModel.getStandings(leagueID)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.white, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 17, weight: .medium))
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        StandingListView(leagueID: "39")
    }
}
