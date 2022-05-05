import Foundation

protocol HTTPCommonMethods {
    static func get(
        url: URL,
        body: String?,
        completionHandler: @escaping (Data?, Error?) -> Void
    )
}

extension URLSession: HTTPCommonMethods {
    // MARK: - Public Static Methods

    static func get(
        url: URL,
        body: String? = nil,
        completionHandler: @escaping (Data?, Error?) -> Void
    ) {
        let request = createRequest(url: url, body: body, method: .get)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, error)
                return
            }

            completionHandler(data, nil)
        }.resume()
    }

    // MARK: - Private Static Methods

    private static func createRequest(
        url: URL,
        body: String?,
        method: HTTPMethod
    ) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        request.addValue("application/json", forHTTPHeaderField: HTTPHeader.contentType.rawValue)

        if let body = body {
            request.httpBody = createRequestBody(from: body)
        }

        return request
    }

    private static func createRequestBody(from body: String) -> Data? {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        do {
            return try encoder.encode(body)
        } catch {
            print(error)
            return nil
        }
    }
}
