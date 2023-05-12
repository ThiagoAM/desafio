//
//  FMCache.swift
//  Desafio
//
//  Created by Thiago Martins on 10/05/23.
//

import SwiftUI

/// FileManger based caching system for Codable objects.
class FMCache<T: Codable> {
    private let debugPrintEnabled = DevShortcuts.fmCacheDebugPrintEnabled
    
    // MARK: - Codable
    
    func write(_ value: T, to fileName: String, expiringIn duration: CacheDuration) {
        write(value,
              to: fileName,
              expirationDate: Date().advanced(by: duration.rawValue))
    }
    
    func write(_ value: T, to fileName: String, expirationDate: Date) {
        if debugPrintEnabled {
            print("• Cache: Writing to \(fileName) on disk and RAM, expiring on \(expirationDate.formatted()) ...")
        }
        let cacheData = FMCache.Data<T>(
            value: value,
            expirationDate: expirationDate,
            fileName: fileName)
        // Writing to disk
        cacheData.writeLocalJSONFile(named: fileName)
    }
    
    func read(from fileName: String) -> (value: T?, expired: Bool?) {
        let cachedData = FMCache.Data<T>.readLocalJSONFile(named: fileName)
        if debugPrintEnabled {
            let expired = cachedData?.expired
            print("• Cache: Reading from \(fileName), expiration on \(cachedData?.expirationDate.formatted() ?? "nil") (\(expired != nil ? (expired! ? "expired" : "still valid") : "nil")) ...")
        }
        return (cachedData?.value, cachedData?.expired)
    }
    
    func remove(fileNamed fileName: String) throws {
        let fileUrl = DirectoryURL.local
        if debugPrintEnabled { print("• Cache: Removing \(fileName) ...") }
        
        try FileManager.default.removeItem(at: fileUrl)
    }
}

// MARK: - Cache Data

extension FMCache {
    struct Data<T: Codable>: Codable {
        var value: T
        var expirationDate: Date
        var fileName: String
        
        var expired: Bool { Date() > expirationDate }
    }
}

// MARK: - Duration

enum CacheDuration: TimeInterval {
    case _10_seconds = 10
    case _30_seconds = 30
    case _1_minute = 60
    case _2_minutes = 120
    case _3_minutes = 180
    case _5_minutes = 300
    case _10_minutes = 600
    case _15_minutes = 900
    case _30_minutes = 1800
    case _1_hour = 3600
    case _3_hours = 10800
    case _12_hours = 43200
    case _1_day = 86400
}
