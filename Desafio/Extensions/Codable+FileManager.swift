//
//  Codable+FileManager.swift
//  Desafio
//
//  Created by Thiago Martins on 10/05/23.
//

import Foundation

extension Encodable {
    func writeLocalJSONFile(named fileName: String) {
        writeJSONFile(
            named: fileName,
            directoryUrl: DevShortcuts.defaultDirectoryUrl)
    }
    
    func writeJSONFile(named fileName: String, directoryUrl: URL?) {
        guard let fileUrl = directoryUrl?.appendingPathComponent(fileName) else {
            if DevShortcuts.fileManagerDebugPrintEnabled {
                print("• Failed to write \(fileName) to \(directoryUrl?.absoluteString ?? "nil")")
            }
            return
        }
        let encodedJsonData = try? JSONEncoder().encode(self)
        if !FileManager.default.fileExists(atPath: fileUrl.path) {
            let created = FileManager.default.createFile(atPath: fileUrl.path, contents: encodedJsonData)
            if DevShortcuts.fileManagerDebugPrintEnabled {
                print("• \(created ? "Successfully written \(fileName)" : "Failed to write \(fileName)") to \(fileUrl) (First Time) ...")
            }
            if created { return }
        }
        do {
            try encodedJsonData?.write(to: fileUrl)
            if DevShortcuts.fileManagerDebugPrintEnabled {
                print("• Successfully written \(fileName) to \(fileUrl) ...")
            }
        } catch let error {
            if DevShortcuts.fileManagerDebugPrintEnabled {
                print("• Failed to write \(fileName) with error: \(error.localizedDescription)")
            }
        }
    }
}

extension Decodable {
    static func readLocalJSONFile(named fileName: String) -> Self? {
        readJSONFile(
            named: fileName,
            directoryUrl: DevShortcuts.defaultDirectoryUrl)
    }
    
    static func readJSONFile(named fileName: String, directoryUrl: URL?) -> Self? {
        guard let fileUrl = directoryUrl?.appendingPathComponent(fileName) else {
            if DevShortcuts.fileManagerDebugPrintEnabled {
                print("• Failed to read \(fileName) from \(directoryUrl?.absoluteString ?? "nil")")
            }
            return nil
        }
        do {
            let fileData = try Data(contentsOf: fileUrl)
            do {
                let data = try JSONDecoder().decode(Self.self, from: fileData)
                if DevShortcuts.fileManagerDebugPrintEnabled { print("• Successfully read \(fileName) from \(fileUrl) ...") }
                return data
            } catch let error {
                if DevShortcuts.fileManagerDebugPrintEnabled {
                    print("• Failed to read \(fileName) from \(fileUrl.absoluteString) with error: \(error.localizedDescription)")
                }
            }
        } catch let error {
            if DevShortcuts.fileManagerDebugPrintEnabled {
                print("• Failed to read \(fileName) from \(fileUrl.absoluteString) with error: \(error.localizedDescription)")
            }
        }
        return nil
    }
}

