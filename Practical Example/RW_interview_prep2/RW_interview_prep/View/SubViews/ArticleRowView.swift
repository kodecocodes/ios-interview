//
//  RowView.swift
//  RW-takeHomeProject
//
//  Created by Duc Dang on 8/25/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ArticleRowView: View {
    
//    var articles : ArticleData
        var articles : AttributeArticle
    var body: some View {
            VStack {
                HStack {
                    
                    Text(String(articles.name!))
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    AnimatedImage(url: URL(string: articles.card_artwork_url!))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .frame(height:70)
                        .padding(.leading, 60)
                }
                Text(String(articles.description_plain_text!))
                    .lineLimit(3)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
                HStack {
                    if articles.free {
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
                    
                    
                    
                    Text("\((articles.released_at!.convertToDate()!.convertToMonthDayYearFormat()))")
                    .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("\((articles.duration ) / 60) hrs" )
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                
            }.animation(.easeIn(duration: 1.0))
        }
    }
