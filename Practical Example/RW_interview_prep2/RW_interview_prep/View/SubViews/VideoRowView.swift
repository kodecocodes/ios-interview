//
//  VideoRowView.swift
//  RW-takeHomeProject
//
//  Created by Duc Dang on 8/26/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct VideoRowView: View {
    
    var videos : ArticleAndVideoData
    
    
    var body: some View {
        VStack
        {
            HStack {
                
                Text(String(videos.attributes.name!))
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                AnimatedImage(url: URL(string: videos.attributes.card_artwork_url))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .frame(height:70)
                    .padding(.leading, 60)
            }
            Text(String(videos.attributes.description_plain_text))
                .lineLimit(3)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            HStack {
                if videos.attributes.free {
                    Text("Free")
                        .padding(4)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(5)
                        .font(.subheadline)
                    
                } else {
                    Text("Pro")
                        .padding(4)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(5)
                        .font(.subheadline)
                }
                
                
                
                Text(videos.attributes.released_at.convertToDate()!.convertToMonthDayYearFormat())
                .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("\(videos.attributes.duration! / 60) hrs" )
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            
        }.animation(.easeIn(duration: 1.0))
    }
}

//struct VideoRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoRowView()
//    }
//}
