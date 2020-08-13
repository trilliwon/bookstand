//
//  ContentView.swift
//  bookstand
//
//  Created by Won on 2019/09/26.
//  Copyright © 2019 Won. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection) {
            BookSearchView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
                .tag(0)

            Text("Books")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "book")
                        Text("Books")
                    }
                }
                .tag(1)

            Text("Search")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "paperclip")
                        Text("Save")
                    }
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
