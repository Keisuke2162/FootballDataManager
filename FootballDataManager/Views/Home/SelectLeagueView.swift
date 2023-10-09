//
//  SelectLeagueView.swift
//  FootballDataManager
//
//  Created by Kei on 2023/10/06.
//

import SwiftUI

struct SelectLeagueView: View {
    let leagues: [League] = [.init(leagueID: "39", name: "Premier", imageString: "logo-premier"),
                             .init(leagueID: "135", name: "SerieA", imageString: "logo-seriea"),
                             .init(leagueID: "140", name: "LaLiga", imageString: "logo-laliga"),
                             .init(leagueID: "78", name: "Bundes", imageString: "logo-bundes")]
    @State private var isShowAddingButton: Bool = false

    var body: some View {
        ZStack {
            if isShowAddingButton {
                Color.black.opacity(0.6).edgesIgnoringSafeArea(.all)
            } else {
                Color.clear.edgesIgnoringSafeArea(.all)
            }

            VStack(alignment: .trailing) {
                Spacer()
                if isShowAddingButton {
                    GeometryReader { geometry in
                        VStack {
                            Spacer()
                            Button {
                                isShowAddingButton.toggle()
                            } label: {
                                Image("logo-premier")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding()
                            }
                            .background(Color.white)
                            .cornerRadius(50)
                            .padding(20)
                            .offset(y: isShowAddingButton ? 0 : geometry.size.height)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            isShowAddingButton.toggle()
                        }
                    } label: {
                        Image("")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                    .background(Color.green)
                    .cornerRadius(50)
                    .padding(20)
                }
            }
        }
    }
}

struct SelectLeagueView_Previews: PreviewProvider {
    static var previews: some View {
        SelectLeagueView()
    }
}
