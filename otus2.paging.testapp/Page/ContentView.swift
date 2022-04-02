//
//  ContentView.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 14.03.2022.
//

import SwiftUI

let count = 100

struct Item: Identifiable {
    var value: Int
    var id: String { "\(value)" }
}

struct ContentView: View {
    @EnvironmentObject var itunesViewModel: ITunesViewModel
    
    @State var selectedListType: Int = 0
    var listTypes: [String] = ["First", "Second"]
    
    var sItems: [Item] = []
    
    init() {
        for i in (0..<count).reversed() {
            sItems.append(Item(value: i))
        }
    }
    
    var body: some View {
        VStack {
            Picker("picker", selection: $selectedListType) {
                ForEach(0..<listTypes.count) { index in
                    Text(listTypes[index])
                        .tag(index)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: selectedListType) { newValue in
                if newValue == 0 {
                    itunesViewModel.loadITunesSongs(page: 1)
                }
            }
            LoadContentView(isReloading: $itunesViewModel.isReloading) {
                if selectedListType == 0 {
                    GeometryReader { geometry in
                        List {
                            ForEach(itunesViewModel.itunesItems) { item in
                                Text(item.id).onTapGesture {
                                    print(geometry.frame(in: .local))
                                }
                            }
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
                    }
                } else {
                    List {
                        ForEach(sItems) { item in
                            Text(item.id)
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
        .padding(EdgeInsets.init(top: 12.0, leading: 8.0, bottom: 0.0, trailing: 8.0))
        .onAppear {
            itunesViewModel.loadITunesSongs(page: 1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
