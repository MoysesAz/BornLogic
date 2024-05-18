import Foundation
import Combine

public final class URLSessionAPIClient<EndpointType: APIEndPointProtocol>: APIClientProtocol {
    private var session: URLSessionProtocol

    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    public func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, APIError>
    {
        let url = URL(string: endpoint.baseURL.absoluteString + endpoint.path)!
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        return session.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.requestFailed
                }

                guard (200 ... 299).contains(httpResponse.statusCode) else {
                    throw APIError.customError(statusCode: httpResponse.statusCode)
                }

                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError({ error -> APIError in
                guard let error = error as? APIError else {
                    return APIError.decodingFailed
                }
                return error
            })
            .eraseToAnyPublisher()
    }
}
