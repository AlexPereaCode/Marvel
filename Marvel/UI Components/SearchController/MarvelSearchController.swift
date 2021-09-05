//
//  MarvelSearchController.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 5/9/21.
//

import UIKit

class MarvelSearchController: UISearchController {
    
    private var accentColor: UIColor
    private var placeholderTextColor: UIColor
    
    init(searchBarFrame: CGRect, accentColor: UIColor, placeholderTextColor: UIColor) {
        self.accentColor = accentColor
        self.placeholderTextColor = placeholderTextColor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureSearchBar()
    }
    
    private func configureSearchBar() {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [.foregroundColor: accentColor]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search Hero", attributes: [.foregroundColor: placeholderTextColor])
        
        let textField = searchBar.value(forKey: "searchField") as? UITextField

        let glassIconView = textField?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = accentColor

        let clearButton = textField?.value(forKey: "clearButton") as? UIButton
        clearButton?.setImage(clearButton?.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton?.tintColor = accentColor
        searchBar.returnKeyType = .done
        searchBar.tintColor = accentColor
        searchBar.searchBarStyle = .prominent
        obscuresBackgroundDuringPresentation = true
        searchBar.isTranslucent = true
    }
}
