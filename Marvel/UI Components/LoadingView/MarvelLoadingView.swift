//
//  MarvelLoadingView.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import UIKit

enum LoadingViewType: String {
    case spiderman = "spiderman"
    case hulk = "hulk"
}

@IBDesignable class MarvelLoadingView: UIView {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    @IBInspectable public var typeString: String? {
        didSet {
            guard let typeString = self.typeString, let _ = LoadingViewType(rawValue: typeString) else { return }
            imageView.image = UIImage(named: typeString)
        }
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupXib()
    }
        
    public func activityIndicator(isHidden: Bool) {
        activityIndicator.isHidden = isHidden
    }
}
