//
//  DictionaryEncoderSong.swift
//  playlist
//
//  Created by Jonatas Falkaniere on 12/05/23.
//

import Foundation

class DictionaryEncoderSong {
    private let encoder = JSONEncoder()
    
    func encode<T: Encodable>(_ value: T) throws -> [String: Any] {
        let data = try encoder.encode(value)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
