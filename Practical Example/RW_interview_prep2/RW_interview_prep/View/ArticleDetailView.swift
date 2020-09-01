//
//  ArticleDetailView.swift
//  RW-takeHomeProject
//
//  Created by Duc Dang on 8/26/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ArticleDetailView: View {
    
    //    var articles : ArticleData
    var articles : AttributeArticle
    
    @State var isBooked  =  false
    @State var isDownloaded  =  false
    
    var body: some View {
        ScrollView (.vertical) {
            VStack {
                AnimatedImage(url: URL(string: articles.card_artwork_url!))
                    .resizable()
                    //            .aspectRatio(contentMode: .fit)
                    //                .edgesIgnoringSafeArea(.top)
                    .frame(height: 300)

                VStack {
                    HStack {
                        Text(String(articles.technology_triple_string!))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                        Spacer()
                        
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
                    }
                    
                    HStack {
                        Text(String(articles.name!))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    
                    
                    HStack {
                        Text("\((articles.released_at!.convertToDate()!.convertToMonthDayYearFormat()))")
                        
                        Text(" - ")
                        
                        Text(String(articles.difficulty!).capitalized)
                        
                        Text(" - ")
                        Text("\((articles.duration ) / 60) hrs" )
                        
                        Spacer()
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    
                    HStack {
                        
                        Button(action: {
                            self.isDownloaded.toggle()
                        }) {
                            isDownloaded ? Image(systemName: "square.and.arrow.down.fill") : Image(systemName: "square.and.arrow.down")
                        }.padding([.top, .bottom], 20)
                            .padding(.trailing, 30)
                        
                        Button(action: {
                            self.isBooked.toggle()
                        }) {
                            isBooked ? Image(systemName: "bookmark.fill") : Image(systemName: "bookmark")
                        }
                        
                        Spacer()
                    }.foregroundColor(.green)
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    
                }.padding([.leading, .trailing])
            }
            .offset(y: -60)
            .padding()
        }
    }
}

//struct ArticleDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleDetailView(articles: <#ArticleData#>)
//    }
//}
