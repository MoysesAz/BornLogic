import Foundation

public protocol APIEndPointProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethodEnum { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}
