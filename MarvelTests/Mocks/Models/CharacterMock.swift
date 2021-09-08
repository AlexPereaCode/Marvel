//
//  CharacterMock.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 8/9/21.
//

import Foundation
@testable import Marvel

class CharacterMock {
    
    func getCharacterMock() throws -> CharacterDataWrapper {
        guard let path = Bundle(for: type(of: self)).path(forResource: "CharacterTests", ofType: "json") else {
            fatalError("Can't find CharacterTests.json file")
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        return try JSONDecoder().decode(CharacterDataWrapper.self, from: data)
    }
}
