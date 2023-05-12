//
//  DirectoryURL.swift
//  Desafio
//
//  Created by Thiago Martins on 10/05/23.
//

import Foundation

struct DirectoryURL {
    static let local = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask)[0]
}
