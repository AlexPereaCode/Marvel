//
//  EventsMock.swift
//  MarvelTests
//
//  Created by Alejandro Perea Navarrete on 8/9/21.
//

import Foundation
@testable import Marvel

class EventsMock {
    
    func getEventsMock() throws -> ContentDataWrapper {
        guard let path = Bundle(for: type(of: self)).path(forResource: "EventsTests", ofType: "json") else {
            fatalError("Can't find EventsTests.json file")
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        return try JSONDecoder().decode(ContentDataWrapper.self, from: data)
    }
}
