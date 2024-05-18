import Combine

public protocol APIClientProtocol {
    associatedtype EndPointType: APIEndPointProtocol
    func request<T: Decodable>(_ endpoint: EndPointType) -> AnyPublisher<T, APIError>
}
