//
//  ReposViewController.swift
//  GitHubReposList
//
//  Created by Ростислав Ермаченков on 19.01.2021.
//

import Foundation
import UIKit

protocol ReposDisplayLogic: class {
    func displayData(viewModel: Repos.Model.ViewModel.ViewModelData)
}

class ReposViewController: UIViewController, ReposDisplayLogic {
    
    var presenter: ReposPresentationLogic?

    private var reposViewModel = ReposViewModel.init(cells: [])
    
    @IBOutlet weak var table: UITableView!
    
    private var refreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTable()
        
        presenter?.presentData(request: Repos.Model.Response.ResponseType.presentRepos)
    }
    
    private func setup() {
        presenter = ReposPresenter(view: self)
    }
    
    private func setupTable() {
        table.register(ReposCell.self, forCellReuseIdentifier: ReposCell.reuseId)
        
        table.addSubview(refreshControl)
    }
    
    func displayData(viewModel: Repos.Model.ViewModel.ViewModelData) {
        
        switch viewModel {
        case .displayRepos(let reposViewModel):
            self.reposViewModel = reposViewModel
            table.reloadData()
            refreshControl.endRefreshing()
        case .displayFooterLoader:
            print("sdsd")
        }
    }
    
    @objc private func refresh() {
        presenter?.presentData(request: Repos.Model.Response.ResponseType.presentRepos)
    }

}

extension ReposViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReposCell.reuseId, for: indexPath) as! ReposCell
        let cellViewModel = reposViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 150
    }
    
    
}

