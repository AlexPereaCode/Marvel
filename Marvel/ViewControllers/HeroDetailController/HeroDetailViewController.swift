//
//  HeroDetailViewController.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 5/9/21.
//

import UIKit

protocol HeroDetailView: BaseView {
    func showHeader(hero: Hero)
    func showComics(comicsURL: [String])
}

class HeroDetailViewController: UIViewController, HeroDetailView {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var loadingView: MarvelLoadingView!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.tableFooterView = UIView(frame: .zero)
            tableView.keyboardDismissMode = .onDrag
            let nibCell = UINib(nibName: ListTableViewCell.nibName, bundle: nil)
            tableView.register(nibCell, forCellReuseIdentifier: ListTableViewCell.nibName)
        }
    }
    
    // MARK: - Properties
    var presenter: HeroDetailPresenter<HeroDetailViewController>? {
        didSet {
            presenter?.view = self
        }
    }
    
    private var comicsURL = [String]()
    private var hero: Hero!
    
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
    
    func showHeader(hero: Hero) {
        self.hero = hero
        title = hero.name
    }
    
    func showComics(comicsURL: [String]) {
        self.comicsURL = comicsURL
        tableView.reloadData()
    }
}


// MARK: - UITableViewDataSource
extension HeroDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.nibName, for: indexPath) as! ListTableViewCell
        cell.configure(imagesURL: comicsURL, title: "Comics")
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HeroDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeroDetailHeaderView()
        headerView.configure(hero: hero)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
}
