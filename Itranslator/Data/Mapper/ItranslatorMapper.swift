//
//  ItranslatorMapper.swift
//  Itranslator
//
//  Created by Raidan on 12/04/2024.
//

import Foundation

final class ItranslatorMapper {
    func map(networkResponse: String) throws -> [ItranslatorModel] {
        guard let data = networkResponse.data(using: .utf8) else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to convert string to Data"])
        }
        do {
            return try JSONDecoder().decode([ItranslatorModel].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
            throw error
        }
    }
}
