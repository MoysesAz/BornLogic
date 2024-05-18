import Foundation
import Combine

protocol HomeViewModelProtocol: CategoryViewModelDelegate, CatalogViewModelDelegate  {
    var categories: [String] { get }

    var headlineArticle: Article? { get }
    var headlinesPublisher: AnyPublisher<[Article], Never> { get }
    func fetchHeadlines()

    var generalArticles: [Article] { get }
    var generalPublisher: AnyPublisher<[Article], Never> { get }
    func fetchGeneral()

    var businessArticles: [Article] { get }
    var businessPublisher: AnyPublisher<[Article], Never> { get }
    func fetchBusiness()

    var entertainmentArticles: [Article] { get }
    var entertainmentPublisher: AnyPublisher<[Article], Never> { get }
    func fetchEntertainment()

    var healthArticles: [Article] { get }
    var healthPublisher: AnyPublisher<[Article], Never> { get }
    func fetchHealth()

    var scienceArticles: [Article] { get }
    var sciencePublisher: AnyPublisher<[Article], Never> { get }
    func fetchScience()

    var sportArticles: [Article] { get }
    var sportPublisher: AnyPublisher<[Article], Never> { get }
    func fetchSport()

    var technologyArticles: [Article] { get }
    var technologyPublisher: AnyPublisher<[Article], Never> { get }
    func fetchTechnology()

    var errorMessagePublisher: AnyPublisher<String?, Never> { get }
    var cancellables: Set<AnyCancellable> { get set }

//    init(newsApiService: NewsApiServiceProtocol)
}

protocol CategoryViewModelDelegate: AnyObject {
    var categories: [String] { get }
}

protocol CatalogViewModelDelegate: AnyObject {
    var generalArticles: [Article] { get }
    var businessArticles: [Article] { get }
    var entertainmentArticles: [Article] { get }
    var healthArticles: [Article] { get }
    var scienceArticles: [Article] { get }
    var sportArticles: [Article] { get }
    var technologyArticles: [Article] { get }
    func articles(for category: NewsCategory) -> [Article]
}

class HomeViewModel: HomeViewModelProtocol, CategoryViewModelDelegate, CatalogViewModelDelegate {
    func articles(for category: NewsCategory) -> [Article] {
            switch category {
            case .general:
                return generalArticles
            case .business:
                return businessArticles
            case .entertainment:
                return entertainmentArticles
            case .health:
                return healthArticles
            case .science:
                return scienceArticles
            case .sports:
                return sportArticles
            case .technology:
                return technologyArticles
            }
        }


    var cancellables = Set<AnyCancellable>()

    let newsApiService: NewsApiServiceProtocol

    required init(newsApiService: NewsApiServiceProtocol = NewsApiServiceProvider()) {
        self.newsApiService = newsApiService
    }

    var categories: [String] {
        return NewsCategory.allCases.map{ $0.uppercaseName }
    }

    @Published var headlines: [Article] = []
    @Published var general: [Article] = []
    @Published var business: [Article] = []
    @Published var entertainment: [Article] = []
    @Published var health: [Article] = []
    @Published var science: [Article] = []
    @Published var sport: [Article] = []
    @Published var technology: [Article] = []

    @Published var errorMessage: String?

    var headlinesPublisher: AnyPublisher<[Article], Never> { $headlines.eraseToAnyPublisher() }
    var generalPublisher: AnyPublisher<[Article], Never> { $general.eraseToAnyPublisher() }
    var businessPublisher: AnyPublisher<[Article], Never> { $business.eraseToAnyPublisher() }
    var entertainmentPublisher: AnyPublisher<[Article], Never> { $entertainment.eraseToAnyPublisher() }
    var healthPublisher: AnyPublisher<[Article], Never> { $health.eraseToAnyPublisher() }
    var sciencePublisher: AnyPublisher<[Article], Never> {$science.eraseToAnyPublisher()}
    var sportPublisher: AnyPublisher<[Article], Never> {$sport.eraseToAnyPublisher()}
    var technologyPublisher: AnyPublisher<[Article], Never> {$technology.eraseToAnyPublisher()}
    var errorMessagePublisher: AnyPublisher<String?, Never> { $errorMessage.eraseToAnyPublisher() }

    var headlineArticle: Article? {
        if headlines.isEmpty {
            return nil
        }

        return headlines[0]
    }
    func fetchHeadlines() {
        newsApiService.getTopHeadlines(topic: nil, country: .US, category: .general, pageSize: 1, page: 1)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] response in
                self?.headlines += response.articles
            })
            .store(in: &cancellables)
    }

    var generalArticles: [Article] {
        if general.count < 10 {
            return []
        }
        return general
    }
    func fetchGeneral() {
        newsApiService.getTopHeadlines(topic: nil, country: .US, category: .general, pageSize: 10, page: 2)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] response in
                self?.general += response.articles
            })
            .store(in: &cancellables)
    }

    var businessArticles: [Article] {
        if business.count < 10 {
            return []
        }
        return business
    }
    func fetchBusiness() {
        newsApiService.getTopHeadlines(topic: nil, country: .US, category: .business, pageSize: 10, page: 1)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] response in
                self?.business += response.articles
            })
            .store(in: &cancellables)
    }

    var entertainmentArticles: [Article] {
        if entertainment.count < 10 {
            return []
        }
        return entertainment
    }
    func fetchEntertainment() {
        newsApiService.getTopHeadlines(topic: nil, country: .US, category: .entertainment, pageSize: 10, page: 1)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] response in
                self?.entertainment += response.articles
            })
            .store(in: &cancellables)
    }

    var healthArticles: [Article] {
        if health.count < 10 {
            return []
        }
        return health
    }
    func fetchHealth() {
        newsApiService.getTopHeadlines(topic: nil, country: .US, category: .health, pageSize: 10, page: 2)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] response in
                self?.health += response.articles
            })
            .store(in: &cancellables)
    }

    var scienceArticles: [Article] {
        if science.count < 10 {
            return []
        }
        return science
    }
    func fetchScience() {
        newsApiService.getTopHeadlines(topic: nil, country: .US, category: .science, pageSize: 10, page: 1)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] response in
                self?.science += response.articles
            })
            .store(in: &cancellables)
    }

    var sportArticles: [Article] {
        if sport.count < 10 {
            return []
        }
        return sport
    }

    func fetchSport() {
        newsApiService.getTopHeadlines(topic: nil, country: .US, category: .sports, pageSize: 10, page: 1)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] response in
                self?.sport += response.articles
            })
            .store(in: &cancellables)
    }

    var technologyArticles: [Article] {
        if technology.count < 10 {
            return []
        }
        return technology
    }

    func fetchTechnology() {
        newsApiService.getTopHeadlines(topic: nil, country: .US, category: .technology, pageSize: 10, page: 1)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] response in
                self?.technology += response.articles
            })
            .store(in: &cancellables)
    }
}
