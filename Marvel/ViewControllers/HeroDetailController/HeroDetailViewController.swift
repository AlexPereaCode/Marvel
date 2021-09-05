//
//  HeroDetailViewController.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 5/9/21.
//

import UIKit

protocol HeroDetailView: BaseView {
    func showComics(comics: [Comic])
}

class HeroDetailViewController: UIViewController, HeroDetailView {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var loadingView: MarvelLoadingView!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: ListCollectionCell.nibName, bundle: nil), forCellWithReuseIdentifier: ListCollectionCell.nibName)
        }
    }
    
    // MARK: - Properties
    var presenter: HeroDetailPresenter<HeroDetailViewController>? {
        didSet {
            presenter?.view = self
        }
    }
    
    private var comics = [Comic]()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Initialization
    
    
    // MARK: - Public Methods
    func hideLoading() {
        if loadingView != nil {
            loadingView.activityIndicator(isHidden: true)
            UIView.animate(withDuration: 0.8) {
                self.loadingView.alpha = 0
            } completion: { _ in
                self.loadingView.removeFromSuperview()
                self.loadingView = nil
            }
        }
    }
    
    func showComics(comics: [Comic]) {
        self.comics = comics
        collectionView.reloadData()
    }
    
}

extension HeroDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionCell.nibName, for: indexPath) as! ListCollectionCell
        cell.configure(imageURL: comics[indexPath.row].thumbnail.url)
        return cell
    }
    
    
}

extension HeroDetailViewController: UICollectionViewDelegate {
    
}

extension HeroDetailViewController: UICollectionViewDelegateFlowLayout {
    
}
