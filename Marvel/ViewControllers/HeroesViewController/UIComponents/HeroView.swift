//
//  HeroView.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import UIKit

class HeroView: UIView {
    
    @IBOutlet private weak var imageView: UIImageView!
    private let downloadImageUseCase: DownloadImageUseCase = Assembler.shared.resolve()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupXib()
    }
    
    public func prepareForReuse() {
        imageView.image = nil
    }
    
    func configure(hero: Hero) {
        downloadImageUseCase.execute(urlString: hero.thumbnail.url).done { image in
            self.imageView.image = image
        }.cauterize()
    }
}
