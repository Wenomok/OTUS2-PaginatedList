//
//  SOQuestionCell.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 27.03.2022.
//

import SwiftUI

struct SOQuestionCell: View {
    var question: SOQuestion
    
    @State private var isFavorite: Bool = false
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .resizable()
                    .foregroundColor(isFavorite ? Color.blue : Color.gray)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.0, height: 24.0)
                    .rotationEffect(.degrees(isFavorite ? 360.0 : 0.0))
            }
            .onTapGesture {
                withAnimation(Animation.easeIn(duration: 0.15)) {
                    isFavorite.toggle()
                }
            }
            .padding([.trailing], 12.0)
            VStack(alignment: .leading, spacing: 8.0) {
                Text(question.title)
                    .font(.system(size: 16.0, weight: .medium))
                    .lineLimit(3)
//                Spacer()
                HStack {
                    Spacer()
                    Text("Просмотров: \(question.viewCount)")
                        .font(.system(size: 12.0))
                        .foregroundColor(.gray)
                }
                
            }
            .padding([.top, .bottom], 8.0)
        }
        .frame(minHeight: 56.0)
        .contentShape(Rectangle())
    }
}

struct SOQuestionCell_Previews: PreviewProvider {
    static var previews: some View {
        SOQuestionCell(question: SOQuestion.init(title: "12312312312312312312312312312312312312312312312312312312312312312312", questionId: 1, viewCount: 1))
    }
}
