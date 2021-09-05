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
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = Colors.backgroundColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }

    public func configure(imageURL: String) {
        imageView.alpha = 0
        downloadImageUseCase.execute(urlString: imageURL).done { image in
            UIView.animate(withDuration: 0.3) {
                self.imageView.alpha = 1
            }
            self.imageView.image = image
        }.cauterize()
    }
}
