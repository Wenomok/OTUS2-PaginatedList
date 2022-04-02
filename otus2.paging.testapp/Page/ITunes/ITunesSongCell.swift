//
//  ITunesSongCell.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 27.03.2022.
//

import SwiftUI

struct ITunesSongCell: View {
    var item: MediaItem
    
    @State private var isFavorite: Bool = false
    var width: CGFloat    
    
    var body: some View {
        VStack {
            Divider()
                .foregroundColor(.gray)
//            Color(uiColor: .lightGray.withAlphaComponent(0.5))
                .frame(width: width, height: 1.0)
//                .edgesIgnoringSafeArea(.all)
                .offset(x: 0.0, y: 0.0)
                .padding([.top], 0.0)
            Spacer()
            HStack {
                ZStack {
                    Image(systemName: "heart")
                        .resizable()
                        .foregroundColor(Color.gray)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.0, height: 24.0)
                    Image(systemName: "heart.fill")
                        .resizable()
                        .foregroundColor(Color.red)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.0, height: 24.0)
//                        .padding(EdgeInsets(top: isFavorite ? 0.0 : -24.0, leading: 0.0, bottom: isFavorite ? 0.0 : 24.0, trailing: 0.0))
                        .offset(y: isFavorite ? 0.0 : -24.0)
                        .opacity(isFavorite ? 1.0 : 0.0)
                }.onTapGesture {
                    withAnimation(Animation.easeOut(duration: 0.25)) {
                        isFavorite.toggle()
                    }
                }
                
                VStack(alignment: .leading, spacing: 4.0) {
                    Text(item.trackName)
                        .font(.system(size: 14.0, weight: .medium))
                    Text(item.collectionName)
                        .font(.system(size: 10.0, weight: .regular))
                        .foregroundColor(.gray)
                }
                .padding([.leading], 12.0)
                Spacer()
                if item.trackPrice != -1 {
                    Text("\(item.trackPrice.formatted()) ₽")
                        .overlay {
                            RoundedRectangle(cornerRadius: 4.0).stroke(.blue, lineWidth: 2.0)
                                .padding(-4.0)
                        }
                        .padding(.trailing, 12.0)
                }
            }
            Spacer()
        }
        .frame(height: 80.0)
        .contentShape(Rectangle())
    }
}

struct ITunesSongCell_Previews: PreviewProvider {
    static var previews: some View {
        ITunesSongCell(item: MediaItem.init(artistName: "Black eyed peas", collectionName: "SATISFACTION", trackName: "STAISFACTION", trackPrice: 199), width: 400)
    }
}
