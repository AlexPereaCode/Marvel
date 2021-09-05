//
//  HeroesViewController.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import UIKit

protocol HeroesView: BaseView {
    func showHeroes(heroes: [Hero])
    func showFooterActivityIndicator()
    func hideFooterActivityIndicator()
}

class HeroesViewController: UIViewController, HeroesView {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var loadingView: MarvelLoadingView!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.tableFooterView = UIView(frame: .zero)
            let nibCell = UINib(nibName: HeroCell.getNibName(), bundle: nil)
            tableView.register(nibCell, forCellReuseIdentifier: HeroCell.getNibName())
        }
    }
    
    // MARK: - Properties
    var presenter: HeroesPresenter<HeroesViewController>? {
        didSet {
            presenter?.view = self
        }
    }
    
    private var heroes = [Hero]()
    private var searchController: MarvelSearchController!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationController()
        initSearchController()
        presenter?.viewDidLoad()
    }
        
    private func initNavigationController() {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "marvel")
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        navigationItem.titleView = imageView
    }
    
    private func initSearchController() {
        searchController = MarvelSearchController(searchBarFrame: .zero, accentColor: .red, placeholderTextColor: .white)
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self

        navigationItem.searchController = searchController
    }
    
    // MARK: - Public Methods
    func hideLoading() {
        loadingView.activityIndicator(isHidden: true)
        UIView.animate(withDuration: 0.8) {
            self.loadingView.alpha = 0
        } completion: { _ in
            self.loadingView.removeFromSuperview()
            self.loadingView = nil
        }
    }
    
    func showHeroes(heroes: [Hero]) {
        self.heroes = heroes
        tableView.reloadData()
    }
    
    func showFooterActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .red
        activityIndicator.startAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
        tableView.tableFooterView = activityIndicator
    }
    
    func hideFooterActivityIndicator() {
        tableView.tableFooterView?.isHidden = true
        tableView.tableFooterView = nil
    }
}

// MARK: - UITableViewDataSource
extension HeroesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroCell.getNibName(), for: indexPath) as! HeroCell
        cell.configure(hero: heroes[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HeroesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if presenter?.needToLoadMore(currentIndex: indexPath.row) == true {
            presenter?.loadMoreUsers()
        }
    }
}

// MARK: - UISearchResultsUpdating
extension HeroesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter?.updateSearchResults(searchText: searchText)
    }
}

