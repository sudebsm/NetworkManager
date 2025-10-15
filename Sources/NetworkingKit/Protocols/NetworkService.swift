import Foundation

public protocol NetworkService {
    func request<T: Decodable>(_ endpoint: APIEndpoint, type: T.Type) async throws -> T
}
