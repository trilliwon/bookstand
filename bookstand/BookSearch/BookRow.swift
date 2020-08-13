import SwiftUI

struct BookRow: View {
    var book: Book

    @ObservedObject var imageLoader: ImageLoader

    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 150)
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("Loading...")
                    .font(Font.caption)
                    .frame(width: 100, height: 150)
                    .background(Color.black)
            }

            VStack(alignment: .leading, spacing: 10) {
                Text(book.title).font(Font.headline).lineLimit(2)
                Text(book.authors.joined(separator: ", ")).font(Font.subheadline)
                if !book.translators.isEmpty {
                    Text(book.translators.joined(separator: ", "))
                        .font(Font.subheadline)
                }

                Text(book.formattedPrice ?? "_")
                    .font(Font.caption)

                Text(book.publisher)
                    .font(Font.caption)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {

    static var previews: some View {
        let sampleURL = "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1397678%3Ftimestamp%3D20200415131239"

        return List {
            BookRow(
                book: books[0],
                imageLoader: ImageLoaderCache.shared.loaderFor(path: sampleURL))
        }
    }
}
