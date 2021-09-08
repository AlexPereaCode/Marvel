//
//  HeroView.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import UIKit

class HeroView: UIView {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
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
        nameLabel.text = hero.name
        nameLabel.textColor = Colors.textColor
        backgroundColor = Colors.backgroundColor
        imageView.alpha = 0
        downloadImageUseCase.execute(urlString: hero.thumbnail.url).done { image in
            UIView.animate(withDuration: 0.3) {
                self.imageView.alpha = 1
            }
            self.imageView.image = image
        }.cauterize()
    }
}
