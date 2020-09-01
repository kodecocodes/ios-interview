//
//  LibraryView.swift
//  RW-takeHomeProject
//
//  Created by Duc Dang on 8/26/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import SwiftUI

struct LibraryView: View {
    @ObservedObject var networkFetchRequest = NetworkFetchRequest()
    
    @State private var articleTab = false
    @State private var videoTab = true
    @State private var showAll = true
    
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: AttributeArticle.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \AttributeArticle.released_at, ascending: true)]) var articles: FetchedResults<AttributeArticle>
    
    var choosen: String {
        let selectedType = Self.selectionTypes[videoType]
        return selectedType
    }
    
    static let selectionTypes = ["Article", "Video", "All"]
    
    
    @State private var videoType = 0
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    
                    Picker(selection: $videoType, label: Text("")) {
                        ForEach ( 0 ..< Self.selectionTypes.count) {
                            Text(Self.selectionTypes[$0])
                                .underline()
                                .foregroundColor(.green)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding()
                        
                        .background(Color.white)
                        .cornerRadius(10)
                        
                        .animation(.easeIn(duration: 1.0))
                }

                if choosen == "Article" {
                    VStack {
                        Text("Loaded with CoreData")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        List() {
                            ForEach(articles, id: \.wrapperName) { article in
                                
                                NavigationLink(destination: ArticleDetailView(articles: article)){
                                    
                                    ArticleRowView(articles: article)
                                }
                            }
                        }
                    }.animation(.interactiveSpring())
                } else if choosen == "Video" {
                    
                    VStack {
                        Text("Loaded with JSON")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        List(networkFetchRequest.videoData) { video in
                            NavigationLink(destination: VideoDetailView(videos: video)){
                                
                                VideoRowView(videos: video)
                            }
                            
                        }
                    }.animation(.interactiveSpring())
                } else {
                    VStack {
                        Text("Loaded with JSON")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        List(networkFetchRequest.AllData) { all in
                            NavigationLink(destination: VideoDetailView(videos: all)){
                                
                                VideoRowView(videos: all)
                            }
                            
                        }
                    }.animation(.interactiveSpring())
                }
                
            }.navigationBarTitle("Raywenderlich")
        }.onAppear {
            if self.articles.isEmpty {
                print("Articles is empty \(self.articles)")
                Article.loadDataToCD(moc: self.moc)
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
