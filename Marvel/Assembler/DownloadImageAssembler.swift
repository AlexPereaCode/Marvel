//
//  DownloadImageAssembler.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import Foundation

protocol DownloadImageAssembler {
    func resolve() -> DownloadImageUseCase
}

extension DownloadImageAssembler {
    
    func resolve() -> DownloadImageUseCase {
        return DownloadImage()
    }
}
