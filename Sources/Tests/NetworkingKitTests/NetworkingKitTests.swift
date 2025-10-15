import XCTest
@testable import NetworkingKit

struct MockUser: Codable, Equatable {
    let id: Int
    let name: String
}

final class NetworkingKitTests: XCTestCase {

    func testSuccessfulRequest() async throws {
        let mockService = NetworkServiceMock()
        let expected = [MockUser(id: 1, name: "John")]
        let data = try JSONEncoder().encode(expected)
        mockService.mockResult = .success(data)

        let result: [MockUser] = try await mockService.request(MockEndpoint(), type: [MockUser].self)
        XCTAssertEqual(result, expected)
    }

    func testFailedRequest() async {
        let mockService = NetworkServiceMock()
        mockService.mockResult = .failure(URLError(.notConnectedToInternet))

        do {
            _ = try await mockService.request(MockEndpoint(), type: [MockUser].self)
            XCTFail("Expected error not thrown")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

struct MockEndpoint: APIEndpoint {
    var path: String { "/mock" }
    var method: String { "GET" }
    var body: Data? { nil }
}
