//
//  ITunesSongDetailView.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 02.04.2022.
//

import SwiftUI

struct DetailsView: View {
    @EnvironmentObject var routeModel: NavigationContainerViewModel
    
    var body: some View {
        VStack(spacing: 20.0) {
            Button {
                routeModel.pop()
            } label: {
                Text("Назад")
            }
            Button {
                routeModel.push(screenView: SomeView().toAnyView())
            } label: {
                Text("Далее")
            }
        }
    }
}
