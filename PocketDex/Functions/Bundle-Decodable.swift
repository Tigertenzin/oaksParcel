//
//  Bundle-Decodable.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/9/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation
import CodableCSV

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
    
    func decodeCSV<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = CSVDecoder{
            $0.headerStrategy = .firstLine
            $0.bufferingStrategy = .sequential
            $0.nilStrategy = .empty
        }
        guard let result = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return result
    }
    
    func ifFileExists(_ file: String) -> Bool {
        if let url = self.url(forResource: file, withExtension: nil) {
            return true
            
        } else {
            return false
        }
    }
}
