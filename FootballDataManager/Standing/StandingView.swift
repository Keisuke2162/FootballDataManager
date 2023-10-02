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
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(0 ..< viewModel.list.count, id: \.self) { index in
                        HStack(spacing: 16.0) {
                            Text("\(index + 1)")
                                .foregroundColor(Color.white)
                                .font(.custom("SSportsD-Medium", size: 16))
                                .frame(width: 16)
                            let imageURL = URL(string: viewModel.list[index].team.logo)
                            AsyncImage(url: imageURL) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            Text(viewModel.list[index].team.name)
                                .foregroundColor(Color.white)
                                .font(.custom("SSportsD-Medium", size: 16))
                        }
                        .frame(height: 46)
                        .listRowBackground(Color.clear)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.init("SkySportsBlue"))
                .listStyle(.grouped)
            }
            .onAppear {
                viewModel.getTableList(leagueID)
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
        StandingView(leagueID: "39")
    }
}
