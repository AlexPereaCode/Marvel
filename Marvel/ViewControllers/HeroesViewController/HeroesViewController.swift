//
//  HeroesViewController.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import UIKit

protocol HeroesView: BaseView {}

class HeroesViewController: UIViewController, HeroesView {
    
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
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
}
