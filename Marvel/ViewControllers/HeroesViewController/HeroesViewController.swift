//
//  HeroesViewController.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 4/9/21.
//

import UIKit

protocol HeroesView: BaseView {
    func showHeroes(heroes: [Hero])
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
            registerHeroCell()
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
    
    private func registerHeroCell() {
        let nibCell = UINib(nibName: HeroCell.getNibName(), bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: HeroCell.getNibName())
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
    
}

// MARK: - UISearchResultsUpdating
extension HeroesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter?.updateSearchResults(searchText: searchText)
    }
}

