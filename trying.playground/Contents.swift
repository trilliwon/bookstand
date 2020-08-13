import UIKit

struct Book: Codable {
    let title: String
    let authors: [String]
    let contents: String
    let datetime: Date
    let isbn: String
    let price: Int
    var formattedPrice: String? {
        Book.priceFormatter.locale = Locale(identifier: "ko_KR")
        return Book.priceFormatter.string(from: NSNumber(value: price))
    }
    let sale_price: Int
    let thumbnail: String
    let status: String
    let translators: [String]
    let url: String

    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()

        formatter.formatterBehavior = .behavior10_4
        formatter.numberStyle = .currency

        return formatter
    }()
}


extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale.current
    return formatter
  }()
}

// https://useyourloaf.com/blog/swift-codable-with-custom-dates/

var sampleBookJSON = """
{"authors": ["로버트 기요사키"],
"contents": "기존 《부자 아빠 가난한 아빠》 제1권에는 없던 41개의 ‘20년 전 그리고 오늘’과 10가지 ‘스터디 세션’ 등 총 500매 분량의 새로운 내용을 추가한 『부자 아빠 가난한 아빠(20주년 특별 기념판)』. 돈에 대한 선입관을 깨뜨리는 파격적인 내용과 세월이 흘러도 흔들리지 않는 기준이 되어 줄 투자의 원칙들을 담은 책이다.  저자가 유년 시절 겪은 두 아버지를 통해 가난한 사람과 부자의 사고방식을 비교한다. 직설적인 화법과 몰입도 있는 스토리텔링",
"datetime": "2018-02-22T00:00:00.000+09:00",
"isbn": "1158883595 9791158883591",
"price": 15800,
"publisher": "민음인",
"sale_price": 14220,
"status": "정상판매",
"thumbnail": "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1590611%3Ftimestamp%3D20190131033601",
"title": "부자 아빠 가난한 아빠. 1(20주년 특별 기념판)(개정증보판)",
"translators": ["안진환"],
"url": "https://search.daum.net/search?w=bookpage&bookId=1590611&q=%EB%B6%80%EC%9E%90+%EC%95%84%EB%B9%A0+%EA%B0%80%EB%82%9C%ED%95%9C+%EC%95%84%EB%B9%A0.+1%2820%EC%A3%BC%EB%85%84+%ED%8A%B9%EB%B3%84+%EA%B8%B0%EB%85%90%ED%8C%90%29%28%EA%B0%9C%EC%A0%95%EC%A6%9D%EB%B3%B4%ED%8C%90%29"}
""".data(using: .utf8)!

var sampleBook: Book? {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
    do {
        return try decoder.decode(Book.self, from: sampleBookJSON)
    } catch {
        print(error)
        return nil
    }
}


print(sampleBook?.datetime)
print(sampleBook?.formattedPrice)
