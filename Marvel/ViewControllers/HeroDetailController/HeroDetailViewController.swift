//
//  HeroDetailViewController.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 5/9/21.
//

import UIKit

protocol HeroDetailView: BaseView {
    
}

class HeroDetailViewController: UIViewController, HeroDetailView {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var loadingView: MarvelLoadingView!
    
    // MARK: - Properties
    var presenter: HeroDetailPresenter<HeroDetailViewController>? {
        didSet {
            presenter?.view = self
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Initialization
    
    
    // MARK: - Public Methods
    func hideLoading() {
        
    }
    
}
