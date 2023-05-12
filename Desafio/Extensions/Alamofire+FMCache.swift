//
//  Alamofire+FMCache.swift
//  Desafio
//
//  Created by Thiago Martins on 10/05/23.
//

import SwiftUI
import Alamofire

// MARK: - Codable

extension Session {
    func cachedRequest<T: Codable>(using cache: FMCache<T>, url: String, parameters: [String: Any]? = nil, fileName: String, duration: CacheDuration = DevShortcuts.defaultCacheDuration) async throws -> T? {
        try await withCheckedThrowingContinuation { continuation in
            self.cachedRequest(
                using: cache,
                url: url,
                parameters: parameters,
                fileName: fileName,
                duration: duration,
                completion: { value, error in
                    if let value = value {
                        continuation.resume(returning: value)
                    } else {
                        continuation.resume(throwing: error ?? CacheError.unknown)
                    }
                })
        }
    }
    
    func cachedRequest<T: Codable>(using cache: FMCache<T>, url: String, parameters: [String: Any]? = nil, fileName: String, duration: CacheDuration = DevShortcuts.defaultCacheDuration, completion: @escaping (T?, Error?) -> Void) {
        let cachedObject = cache.read(from: fileName)
        if cachedObject.expired == false {
            // Valid cache
            completion(cachedObject.value, nil)
        } else {
            // Expired/Disabled cache or never requested
            AF.request(url, parameters: parameters)
                .validate()
                .responseDecodable(of: T.self) { response in
                    if let value = response.value {
                        if DevShortcuts.alamofireDebugPrintEnabled {
                            print("• Successful AF Request ...")
                        }
                        // Successful request
                        cache.write(
                            value,
                            to: fileName,
                            expirationDate: Date().advanced(by: duration.rawValue))
                        completion(value, response.error)
                    } else {
                        if DevShortcuts.alamofireDebugPrintEnabled {
                            print("• Failed AF Request with url: \(url) ...")
                            print("• Response: \(response) •")
                        }
                        completion(nil, response.error)
                    }
                }
        }
    }
}
