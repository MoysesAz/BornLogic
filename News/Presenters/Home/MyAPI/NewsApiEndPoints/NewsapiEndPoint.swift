import Foundation
import Networking


enum NewsapiEndPoint: APIEndPointProtocol {
    var baseURL: URL {
        return URL(string: "https://newsapi.org/v2/")!
    }

    var path: String {
        switch self {
        case .getNews(topic: let topic, searchin: let searchin, language: let language, pageSize: let pageSize, page: let page):
            var baseString = "everything"
            baseString += "?q=\(topic)"
            baseString += "&searchin=\(searchin)"
            baseString += "&language=\(language)"
            baseString += "&pageSize=\(pageSize)"
            baseString += "&page=\(page)"
            return baseString
        case .getTopHeadlines(topic: let topic, country: let country, category: let category, pageSize: let pageSize, page: let page):
            var baseString = "top-headlines"
            baseString += "?q=\(topic ?? "")"
            baseString += "&country=\(country)"
            baseString += "&category=\(category)"
            baseString += "&pageSize=\(pageSize)"
            baseString += "&page=\(page)"
            return baseString
        }
    }

    var method: HTTPMethodEnum {
        return .get
    }

    var headers: [String : String]? {
        var headers: [String: String] = [:]
        headers["X-Api-Key"] = "0d2691ef43674410b37957436d46b724"
        return headers
    }

    var body: Data? {
        return nil
    }

    case getNews(topic: String, searchin: Searchin, language: Language, pageSize: Int, page: Int)
    case getTopHeadlines(topic: String?, country: Country, category: NewsCategory, pageSize: Int, page: Int)
}
