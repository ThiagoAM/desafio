//
//  DevShortcuts.swift
//  Desafio
//
//  Created by Thiago Martins on 11/05/23.
//

import Foundation

class DevShortcuts {
    
    // MARK: - Debug Print
    
    static let gitUsersApiDebugPrintEnabled = false
    static let fmCacheDebugPrintEnabled = false
    static let fileManagerDebugPrintEnabled = false
    static let alamofireDebugPrintEnabled = false
    
    // MARK: - Cache Duration
    
    static let defaultCacheDuration: CacheDuration = ._10_seconds
    
    // MARK: - Directories
    
    static let defaultDirectoryUrl = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask)[0]
}
