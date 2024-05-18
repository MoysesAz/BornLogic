import Foundation
import Combine
import Networking

public final class MockAPIClient<EndpointType: APIEndPointProtocol>: APIClientProtocol {
    var requestResult: Result<Data, APIError> = .failure(.requestFailed)
    public func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, APIError> {
        return Result.Publisher(requestResult)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> APIError in
                guard let apiError = error as? APIError else {
                    return APIError.decodingFailed
                }
                return apiError
            }
            .eraseToAnyPublisher()
    }
}

