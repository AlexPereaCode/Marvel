//
//  HeroDetailViewController.swift
//  Marvel
//
//  Created by Alejandro Perea Navarrete on 5/9/21.
//

import UIKit

enum HeroDetailSectionType: Int, CaseIterable {
    case comics
    case series
    case events
}

protocol HeroDetailView: BaseView {
    func showContent(content: DetailHeroModel)
}

class HeroDetailViewController: UIViewController, HeroDetailView {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var loadingView: MarvelLoadingView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = UITableView.automaticDimension
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
    
    private var contentData: DetailHeroModel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        setNavigationBar()
    }
            
    // MARK: - Initialization
    private func setNavigationBar() {
        title = contentData.hero.name
        navigationController?.navigationBar.tintColor = Colors.accentColor
    }
    
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
        
    func showContent(content: DetailHeroModel) {
        contentData = content
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension HeroDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        HeroDetailSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.nibName, for: indexPath) as! ListTableViewCell
        
        switch indexPath.section {
        case HeroDetailSectionType.comics.rawValue:
            cell.configure(imagesURL: contentData.comics, title: "Comics", type: .comics)
            
        case HeroDetailSectionType.series.rawValue:
            cell.configure(imagesURL: contentData.series, title: "Series", type: .series)
            
        case HeroDetailSectionType.events.rawValue:
            cell.configure(imagesURL: contentData.events, title: "Events", type: .events)
        
        default:()
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HeroDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == HeroDetailSectionType.comics.rawValue {
            let headerView = HeroDetailHeaderView()
            headerView.configure(hero: contentData.hero)
            
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
