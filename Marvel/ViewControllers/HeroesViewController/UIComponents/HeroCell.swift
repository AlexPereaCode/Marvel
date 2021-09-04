//
//  HeroCell.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import UIKit

class HeroCell: UITableViewCell {

    @IBOutlet private weak var heroView: HeroView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        heroView.layer.cornerRadius = 10
        heroView.layer.masksToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        heroView.prepareForReuse()
    }
    
    public class func getNibName() -> String {
        return "HeroCell"
    }
    
    public func configure(hero: Hero) {
        heroView.configure(hero: hero)
    }
}
