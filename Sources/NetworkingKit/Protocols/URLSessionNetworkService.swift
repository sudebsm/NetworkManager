import Foundation

public final class URLSessionNetworkService: NetworkService {

    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func request<T: Decodable>(_ endpoint: APIEndpoint, type: T.Type) async throws -> T {
        var request = URLRequest(url: endpoint.baseURL.appendingPathComponent(endpoint.path))
        request.httpMethod = endpoint.method
        request.httpBody = endpoint.body
        endpoint.headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
