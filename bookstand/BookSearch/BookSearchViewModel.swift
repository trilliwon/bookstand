//
//  BookSearchViewModel.swift
//  bookstand
//
//  Created by won on 2020/08/13.
//  Copyright © 2020 Won. All rights reserved.
//

import Foundation
import Combine
import os.log

class BookSearchViewModel: ObservableObject {

    @Published var documents = Documents()
    @Published var books = [Book]()
    @Published var query: String = "과학"
    @Published var searchTarget: Int = 0
    @Published var currentPage: Int = 1

    private let searchProvider = BookSearchProvider()
    private var cancelables = Set<AnyCancellable>()

    func isLast(_ book: Book) -> Bool {
        books.last == book
    }

    init() {
        $query
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .handleEvents(receiveOutput: { [unowned self] _ in self.books.removeAll() })
            .combineLatest($searchTarget)
            .flatMap { [unowned self] (query, searchTarget) -> AnyPublisher<Documents, Never> in
                if query.isEmpty {
                    return Result.Publisher(Documents()).eraseToAnyPublisher()
                }
                return self.performQuery(query, searchTarget).eraseToAnyPublisher()
            }
            .assign(to: \.documents, on: self)
            .store(in: &cancelables)

        $documents
            .map(\.documents)
            .sink(receiveValue: { [unowned self] in
                self.books.append(contentsOf: $0)
            })
            .store(in: &cancelables)

        $currentPage
            .print(">>> \(currentPage)")
            .flatMap { [unowned self] page -> AnyPublisher<Documents, Never> in
                performQuery(query, searchTarget, page: page)
            }
            .sink(receiveValue: { [unowned self] in
                self.documents = $0
            })
            .store(in: &cancelables)
    }

    func performQuery(_ query: String, _ searchTarget: Int = 0, page: Int = 1, size: Int = 20) -> AnyPublisher<Documents, Never> {
        let target = BookSearchProvider.Target.allCases[searchTarget]
        return searchProvider
            .request(endpoint: .search(target), params: ["query": query, "page": "\(page)", "size": "\(size)"])
            .catch { error -> Empty<Documents, Never> in
                os_log("⚠️ %@", type: .error, "\(#function) \(error)")
                return Empty()
            }
            .eraseToAnyPublisher()
    }

    func fetchNextPageIfNeeded(_ book: Book) {
        if isLast(book) {
            currentPage += 1
        }
    }
}

extension String {
    var isNotEmpty: Bool {
        !isEmpty
    }
}
