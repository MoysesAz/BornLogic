import Foundation

struct Source: Codable {
    let id: String?
    let name: String
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}


struct ErrorResponse: Codable {
    let status: String
    let code: String
    let message: String
}
