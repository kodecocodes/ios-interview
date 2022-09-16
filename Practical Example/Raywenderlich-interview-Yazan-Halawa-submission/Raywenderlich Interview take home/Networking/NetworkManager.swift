//
//  NetworkManager.swift
//  Raywenderlich Interview take home
//
//  Created by Yazan Halawa on 9/13/22.
//

import Foundation
import OSLog

protocol MakesNetworkRequests {
    func request<T: Decodable>(endpoint: Endpoint) async -> (Result<T, NetworkError>)
}
enum NetworkError: Error {
    // For most apps any network error that happens will be handled the same with a generic error view, but reachability issues are handled specifically with a banner or something letting the user know to check their connection. So I am calling out only those two types of errors
    case networkIsNotReachable
    case error
}

final class NetworkManager: MakesNetworkRequests {
    static let shared = NetworkManager()
    
    private init() {}
    
    private func buildURL(endpoint: Endpoint) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.baseURL
        components.path = endpoint.path
        if !endpoint.queryParameters.isEmpty {
            components.queryItems = endpoint.queryParameters
        }
        return components
    }
    
    func request<T: Decodable>(endpoint: Endpoint) async -> Result<T, NetworkError> {
        guard NetworkMonitor.shared.isReachable else {
            return .failure(.networkIsNotReachable)
        }
        let components = buildURL(endpoint: endpoint)
        guard let url = components.url else {
            Logger.networking.error("Building URL with scheme \(components.scheme ?? "") host \(components.host ?? "") path \(components.path) Failed")
            return .failure(.error)
        }
        
        Logger.networking.info("url \(url)")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        Logger.networking.info("urlRequest \(urlRequest)")
        
        do {
            // process data
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let responseObject = try JSONDecoder().decode(T.self, from: data)
            return .success(responseObject)
        } catch {
            Logger.networking.error("Network Request to \(components.path) failed with \(error)")
            return .failure(.error)
        }
    }
}

