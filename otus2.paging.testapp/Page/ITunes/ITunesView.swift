//
//  ITunesView.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 27.03.2022.
//

import SwiftUI

struct ITunesView: View {
    @EnvironmentObject var itunesViewModel: ITunesViewModel
    @EnvironmentObject var routeModel: NavigationContainerViewModel
    
    var body: some View {
        GeometryReader { geometry in
            List {
                ForEach(itunesViewModel.itunesItems) { item in
                    ITunesSongCell(item: item, width: geometry.size.width)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.white)
                        .listRowSeparator(.hidden)
//                        .frame(width: geometry.size.width, height: 80.0, alignment: .top)
                        .onTapGesture {
                            routeModel.push(screenView: DetailsView().toAnyView())
                        }
                }
                .edgesIgnoringSafeArea([.trailing, .leading])
                if itunesViewModel.isNextPageAvailable {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    .frame(height: 40.0)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.itunesViewModel.loadITunesSongs(page: itunesViewModel.page + 1)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .refreshable {
                self.itunesViewModel.loadITunesSongs(page: 1)
            }
        }
    }
}

struct ITunesView_Previews: PreviewProvider {
    static var previews: some View {
        ITunesView()
    }
}
