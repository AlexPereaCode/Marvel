//
//  ListTableViewCell.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 5/9/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    static let nibName = "ListTableViewCell"
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: ListCollectionCell.nibName, bundle: nil), forCellWithReuseIdentifier: ListCollectionCell.nibName)
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    
    private var imagesURL = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(imagesURL: [String], title: String) {
        self.imagesURL = imagesURL
        titleLabel.text = title
        titleLabel.textColor = Colors.textColor
        collectionView.reloadData()
    }
}

extension ListTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionCell.nibName, for: indexPath) as! ListCollectionCell
        cell.configure(imageURL: imagesURL[indexPath.row])
        return cell
    }
}

extension ListTableViewCell: UICollectionViewDelegate {
    
}

extension ListTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 220)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
