import Foundation

public enum APIError: Error, Equatable {
    case requestFailed
    case decodingFailed
    case customError(statusCode: Int)
}
