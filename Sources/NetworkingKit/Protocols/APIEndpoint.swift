import Foundation

public protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

public extension APIEndpoint {
    var baseURL: URL {
        URL(string: "https://jsonplaceholder.typicode.com")!
    }
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
}
