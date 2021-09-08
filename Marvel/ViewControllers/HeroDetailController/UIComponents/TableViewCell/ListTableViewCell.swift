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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emptyDataImageView: UIImageView!
    
    private var imagesURL = [String]()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contentView.sendSubviewToBack(emptyDataImageView)
        emptyDataImageView.image = nil
    }

    public func configure(imagesURL: [String], title: String, type: HeroDetailSectionType) {
        titleLabel.text = title
        titleLabel.textColor = Colors.textColor
        
        showEmptyDataImage(show: imagesURL.isEmpty, type: type)
        loadCollectionData(imagesURL: imagesURL)
    }
    
    private func showEmptyDataImage(show: Bool, type: HeroDetailSectionType) {
        if show {
            contentView.bringSubviewToFront(emptyDataImageView)
            emptyDataImageView.backgroundColor = Colors.backgroundColor
            
            switch type {
            case .comics:
                emptyDataImageView.image = UIImage(named: "comicsEmpty")
            case.events:
                emptyDataImageView.image = UIImage(named: "eventsEmpty")
            case .series:
                emptyDataImageView.image = UIImage(named: "seriesEmpty")
            }
        }
    }
    
    private func loadCollectionData(imagesURL: [String]) {
        if !imagesURL.isEmpty {
            self.imagesURL = imagesURL
            collectionView.reloadData()
        }
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

extension ListTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 240)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
