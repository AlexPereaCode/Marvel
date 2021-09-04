//
//  Assembler.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import Foundation

class Assembler {
    static let shared = Assembler()
}

extension Assembler: HeroesAssembler {}
extension Assembler: DownloadImageAssembler {}
