//
//  BookSearchView.swift
//  bookstand
//
//  Created by won on 2020/08/03.
//  Copyright © 2020 Won. All rights reserved.
//

import SwiftUI

struct BookSearchView: View {

    @ObservedObject var viewModel = BookSearchViewModel()

    var body: some View {
        ZStack {

            VStack {
                SearchBar(text: $viewModel.query)
                    .padding()

                Picker(selection: $viewModel.searchTarget, label: Text("Choose Search Type")) {
                    Text("제목").tag(0)
                    Text("ISBN").tag(1)
                    Text("출판사").tag(2)
                    Text("인명").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 10)

                List {
                    ForEach(viewModel.books) { book in
                        BookRow(
                            book: book,
                            imageLoader: ImageLoaderCache.shared.loaderFor(path: book.thumbnail)
                        )
                        .onAppear(perform: {
                            viewModel.fetchNextPageIfNeeded(book)
                        })
                    }
                }
                .animation(.spring())
                .resignKeyboardOnDragGesture()
                .navigationBarTitle(Text("Search"))
            }

            if viewModel.books.isEmpty {
                Text("책 검색 📚")
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        BookSearchView()
    }
}
