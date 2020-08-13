//
//  SearchView.swift
//  bookstand
//
//  Created by won on 2020/08/03.
//  Copyright © 2020 Won. All rights reserved.
//

import SwiftUI

struct BookSearchView: View {

    @State var searchText: String = ""

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            List {
                ForEach(books, id: \.title) { book in
                    BookRow(
                        book: book,
                        imageLoader: ImageLoaderCache.shared.loaderFor(path: book.thumbnail)
                    )
                }
            }
            .navigationBarTitle(Text("Search"))
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        BookSearchView()
    }
}
