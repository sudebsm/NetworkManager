import Foundation
@testable import NetworkingKit

final class NetworkServiceMock: NetworkService {
    var mockResult: Result<Data, Error>?

    func request<T>(_ endpoint: APIEndpoint, type: T.Type) async throws -> T where T : Decodable {
        switch mockResult {
        case .success(let data):
            return try JSONDecoder().decode(T.self, from: data)
        case .failure(let error):
            throw error
        case .none:
            throw URLError(.badServerResponse)
        }
    }
}
