//
//  LoadContentView.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 26.03.2022.
//

import SwiftUI

struct LoadContentView<Content>: View where Content: View {
    @Binding var isReloading: Bool
    
    @ViewBuilder var onFinishLoadingContent: () -> Content
    
    var body: some View {
        if isReloading {
            Spacer()
            ProgressView()
                .scaleEffect(1.5)
            Spacer()
        } else {
            onFinishLoadingContent()
        }
    }
}

struct LoadContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoadContentView(isReloading: .constant(true)) {
            Text("")
        }
    }
}
