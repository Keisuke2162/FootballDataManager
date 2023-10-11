//
//  ScheduleView.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/09.
//

import SwiftUI

struct ScheduleView: View {
    let leagueID: String
    @ObservedObject private var viewModel = ScheduleViewModel()
    @Environment(\.dismiss) var dismiss

    // @State private var items: [Fixture] = []
    // @State private var selectedDateIndex = 0
    
    var groupedItems: [String: [Fixture]] {
        Dictionary(grouping: viewModel.items) { item in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: item.fixture.date)
        }
    }

    var dateKeys: [String] {
        groupedItems.keys.sorted()
    }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.items.isEmpty {
                    Text("Loading...")
                } else {
                    HStack {
                        Spacer()
                        Button {
                            if viewModel.selectedDateIndex > 0 {
                                viewModel.selectedDateIndex -= 1
                            }
                        } label: {
                            Text("←")
                                .foregroundColor(Color.init("SkySportsBlue"))
                                .font(.custom("SSportsD-Medium", size: 16))
                        }
                        Spacer()
                        Text(viewModel.dateKeys[viewModel.selectedDateIndex])
                            .foregroundColor(Color.init("SkySportsBlue"))
                            .font(.custom("SSportsD-Medium", size: 16))
                        Spacer()
                        Button {
                            if viewModel.selectedDateIndex < dateKeys.count - 1 {
                                viewModel.selectedDateIndex += 1
                            }
                        } label: {
                            Text("→")
                                .foregroundColor(Color.init("SkySportsBlue"))
                                .font(.custom("SSportsD-Medium", size: 16))
                        }
                        Spacer()
                    }
                    
                    let listItems = groupedItems[dateKeys[viewModel.selectedDateIndex]] ?? []
                    List {
                        ForEach(0 ..< listItems.count, id: \.self) { index in
                            let fixtureItem = listItems[index]
                            HStack {
                                Spacer()
                                let homeImageURL = URL(string: fixtureItem.teams.home.logo)
                                AsyncImage(url: homeImageURL) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                Spacer()
                                Text(fixtureItem.goals.home?.description ?? "")
                                    .foregroundColor(Color.white)
                                    .font(.custom("SSportsD-Medium", size: 16))
                                Text("-")
                                    .foregroundColor(Color.white)
                                    .font(.custom("SSportsD-Medium", size: 16))
                                Text(fixtureItem.goals.away?.description ?? "")
                                    .foregroundColor(Color.white)
                                    .font(.custom("SSportsD-Medium", size: 16))
                                Spacer()
                                let awayImageURL = URL(string: fixtureItem.teams.away.logo)
                                AsyncImage(url: awayImageURL) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                Spacer()
                            }
                            .frame(height: 56)
                            .listRowBackground(Color.clear)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.init("SkySportsBlue"))
                    .listStyle(.grouped)
                }
            }
            .onAppear {
                viewModel.getShcedules(leagueID)
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

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(leagueID: "39")
    }
}
