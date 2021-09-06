//
//  HeroDetailHeaderView.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 6/9/21.
//

import UIKit

class HeroDetailHeaderView: UIView {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
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
    
    func configure(hero: Hero) {        
        downloadImageUseCase.execute(urlString: hero.thumbnail.url).done { image in
            self.imageView.image = image
        }.cauterize()
        
        if hero.description == "" {
            descriptionLabel.text = "Description not available"
            return
        }
        descriptionLabel.text = hero.description
        descriptionLabel.textColor = Colors.textColor
    }
}
