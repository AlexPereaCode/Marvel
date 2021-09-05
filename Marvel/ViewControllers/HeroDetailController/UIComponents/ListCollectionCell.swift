//
//  ListCollectionCell.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 5/9/21.
//

import UIKit

class ListCollectionCell: UICollectionViewCell {
    
    static let nibName = "ListCollectionCell"
    
    @IBOutlet private weak var imageView: UIImageView!
    private let downloadImageUseCase: DownloadImageUseCase = Assembler.shared.resolve()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
    }

    public func configure(imageURL: String) {
        downloadImageUseCase.execute(urlString: imageURL).done { image in
            UIView.animate(withDuration: 0.3) {
                self.imageView.alpha = 1
            }
            self.imageView.image = image
        }.cauterize()
    }
}
