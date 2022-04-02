//
//  StackOverflowView.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 27.03.2022.
//

import SwiftUI

struct StackOverflowView: View {
    @EnvironmentObject var stackOverflowViewModel: StackOverflowViewModel
    @EnvironmentObject var routeModel: NavigationContainerViewModel
    
    var body: some View {
        List {
            ForEach(stackOverflowViewModel.items) { item in
                SOQuestionCell(question: item)
                    .listRowInsets(EdgeInsets())
                    .onTapGesture {
                        routeModel.push(screenView: DetailsView().toAnyView())
                    }
            }
            if stackOverflowViewModel.isNextPageAvailable {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .frame(height: 40.0)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.stackOverflowViewModel.loadQuestions(page: self.stackOverflowViewModel.page + 1)
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

struct StackOverflowView_Previews: PreviewProvider {
    static var previews: some View {
        StackOverflowView()
    }
}
