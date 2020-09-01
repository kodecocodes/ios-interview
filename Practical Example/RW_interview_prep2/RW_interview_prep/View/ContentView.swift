//
//  ContentView.swift
//  RW-takeHomeProject
//
//  Created by Duc Dang on 8/25/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkFetchRequest = NetworkFetchRequest()
    
    @State private var articleTab = false
    @State private var videoTab = false
    
    var body: some View {
        TabView {
            LibraryView().tabItem {
                Tab(imageName: "folder", text: "Library")
            }
            
            BookmarkView().tabItem {
                Tab(imageName: "book", text: "Bookmark")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private struct Tab: View {
    let imageName: String
    let text: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
            Text(text)
        }
    }
}
