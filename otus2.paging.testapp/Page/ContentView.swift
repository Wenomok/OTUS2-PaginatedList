//
//  ContentView.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 14.03.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var itunesViewModel: ITunesViewModel
    @EnvironmentObject var stackOverflowViewModel: StackOverflowViewModel
    
    @State var selectedListType: Int = 0
    var listTypes: [String] = ["First", "Second"]
    
    var body: some View {
        NavigationContainerView(transition: .custom(.slide)) {
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
                        itunesViewModel.loadITunesSongs(page: 1, isRefresh: true)
                    } else {
                        stackOverflowViewModel.loadQuestions(page: 1)
                    }
                }
                LoadContentView(isReloading: .constant(itunesViewModel.isReloading || stackOverflowViewModel.isReloading)) {
                    if selectedListType == 0 {
                        ITunesView()
                            .environmentObject(itunesViewModel)
                    } else {
                        StackOverflowView()
                            .environmentObject(stackOverflowViewModel)
                    }
                }
            }
            .padding(EdgeInsets.init(top: 12.0, leading: 8.0, bottom: 0.0, trailing: 8.0))
            .onAppear {
                if itunesViewModel.isFirstLoading {
                    itunesViewModel.loadITunesSongs(page: 1, isRefresh: true)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
