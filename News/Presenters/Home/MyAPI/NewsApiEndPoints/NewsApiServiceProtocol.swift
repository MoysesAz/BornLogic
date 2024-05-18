import Combine
import Networking

protocol NewsApiServiceProtocol {
    func getNews(topic: String,
                 searchin: Searchin,
                 language: Language,
                 pageSize: Int,
                 page: Int) -> AnyPublisher<NewsResponse, APIError>

    func getTopHeadlines(topic: String?,
                         country: Country,
                         category: NewsCategory,
                         pageSize: Int,
                         page: Int) -> AnyPublisher<NewsResponse, APIError>
}

class NewsApiServiceProvider: NewsApiServiceProtocol {
    private let apiClient = URLSessionAPIClient<NewsapiEndPoint>()
    
    func getNews(topic: String,
                 searchin: Searchin = .description,
                 language: Language = .PT,
                 pageSize: Int = 1,
                 page: Int = 1) -> AnyPublisher<NewsResponse, APIError> {

        return apiClient.request(.getNews(topic: topic,
                                          searchin: searchin,
                                          language: language,
                                          pageSize: pageSize,
                                          page: page))
    }

    func getTopHeadlines(topic: String? = nil,
                         country: Country = .BR,
                         category: NewsCategory = .general,
                         pageSize: Int = 100,
                         page: Int = 1) -> AnyPublisher<NewsResponse, APIError> {
        return apiClient.request(.getTopHeadlines(topic: topic,
                                                  country: country,
                                                  category: category,
                                                  pageSize: pageSize,
                                                  page: page))
    }
}

enum Searchin: String {
    case title
    case description
    case content
}

enum Language: String {
    case AR, DE, EN, ES, FR, HE, IT, NL, NO, PT, RU, SV, UD, ZH
}

enum Country: String {
    case AE, AR, AT, AU, BE, BG, BR, CA, CH, CN, CO, CU, CZ, DE, EG, ES, FR, GB, GR, HK, HU, ID, IE, IL, IN, IT, JP, KR, LK, LT, LU, LV, MA, MX, MY, NG, NL, NO, NZ, PH, PK, PL, PT, RO, RS, RU, SA, SE, SG, SK, TH, TR, TW, UA, US, VE, ZA
}

enum NewsCategory: String, CaseIterable {
    case general = "general"
    case business = "business"
    case entertainment = "entertainment"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"

    var uppercaseName: String {
        return self.rawValue.uppercased()
    }
}
