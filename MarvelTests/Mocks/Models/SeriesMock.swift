//
//  SeriesMock.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 8/9/21.
//

import Foundation
@testable import Marvel

class SeriesMock {
    
    func getSeriesMock() throws -> ContentDataWrapper {
        guard let path = Bundle(for: type(of: self)).path(forResource: "SeriesTests", ofType: "json") else {
            fatalError("Can't find SeriesTests.json file")
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        return try JSONDecoder().decode(ContentDataWrapper.self, from: data)
    }
}
