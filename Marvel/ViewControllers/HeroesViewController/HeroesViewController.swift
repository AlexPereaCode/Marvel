//
//  HeroesViewController.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import UIKit

protocol HeroesView: BaseView {}

class HeroesViewController: UIViewController, HeroesView {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingView: MarvelLoadingView!
    
    var presenter: HeroesPresenter<HeroesViewController>? {
        didSet {
            presenter?.view = self
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    func hideLoading() {
        loadingView.activityIndicator(isHidden: true)
        UIView.animate(withDuration: 0.8) {
            self.loadingView.alpha = 0
        } completion: { _ in
            self.loadingView.removeFromSuperview()
            self.loadingView = nil
        }
    }
    
}
