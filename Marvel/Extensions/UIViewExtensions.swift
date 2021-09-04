//
//  UIViewExtensions.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import UIKit

extension UIView {
    
    func setupXib() {
        setupXib(nibName: String(describing: type(of: self)))
    }
    
    private func setupXib(nibName: String) {
        
        var finalNibName = nibName
        
        if finalNibName.contains("<") {
            finalNibName = finalNibName.components(separatedBy: "<").first ?? ""
        }
        
        let nib = UINib(nibName: finalNibName, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                view.topAnchor.constraint(equalTo: topAnchor),
                view.leftAnchor.constraint(equalTo: leftAnchor),
                view.rightAnchor.constraint(equalTo: rightAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }
}
