//
//  VideoDetailViews.swift
//  RW_interview_prep
//
//  Created by Duc Dang on 8/31/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import SwiftUI
import AVKit
import SDWebImageSwiftUI

struct VideoDetailView: View {
    var videos : ArticleAndVideoData
    //    var articles : ArticleAttribute
    @State var isBooked  =  false
    @State var isDownloaded  =  false
    
    var body: some View {
        
        ScrollView (.vertical) {
            VStack {
                if videos.attributes.content_type == "collection" {
                    VStack {
                        player().frame(height: UIScreen.main.bounds.height / 3)
                        Text("Sample Video")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                } else {
                    AnimatedImage(url: URL(string: videos.attributes.card_artwork_url))
                    .resizable()
                    //            .aspectRatio(contentMode: .fit)
                    //                .edgesIgnoringSafeArea(.top)
                    .frame(height: 300)
                }
                VStack {
                    HStack {
                        Text(String(videos.attributes.technology_triple_string))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                        Spacer()
                        
                        
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
                    }
                    
                    HStack {
                        Text(String(videos.attributes.name!))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    HStack {
                        Text("\((videos.attributes.released_at.convertToDate()!.convertToMonthDayYearFormat()))")
                        
                        Text(" - ")
                        
                        Text(String(videos.attributes.difficulty!).capitalized)
                        
                        Text(" - ")
                        Text("\((videos.attributes.duration! ) / 60) hrs" )
                        
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
                    
                }.padding()
            }
            .offset(y: -60)
            .padding()
        }
    }
}

struct player: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<player>) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        let url = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        let player1 = AVPlayer(url: URL(string: url)!)
        controller.player = player1
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<player>) {
        
    }
}
