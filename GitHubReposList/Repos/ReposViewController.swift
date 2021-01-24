//
//  ReposViewController.swift
//  GitHubReposList
//
//  Created by Ростислав Ермаченков on 19.01.2021.
//

import Foundation
import UIKit
import SafariServices

protocol ReposDisplayLogic: class {
    func displayData(viewModel: Repos.Model.ViewModel.ViewModelData)
}

class ReposViewController: UIViewController, ReposDisplayLogic {
    
    var presenter: ReposPresentationLogic?

    private var reposViewModel = ReposViewModel.init(cells: [])
    
    @IBOutlet weak var table: UITableView!
    
    private lazy var footerView = FooterView()
    
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
        table.tableFooterView = footerView
    }
    
    func displayData(viewModel: Repos.Model.ViewModel.ViewModelData) {
        
        switch viewModel {
        case .displayRepos(let reposViewModel):
            self.reposViewModel = reposViewModel
            footerView.setTitle("hello there")
            table.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    @objc private func refresh() {
        presenter?.presentData(request: Repos.Model.Response.ResponseType.presentRepos)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.2 {
            presenter?.presentData(request: Repos.Model.Response.ResponseType.presentFooterLoader)
            footerView.showLoader()
        }
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

        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = reposViewModel.cells[indexPath.row]
        guard let url = URL(string: cellViewModel.htmlUrl) else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let cellViewModel = reposViewModel.cells[indexPath.row]
        
        let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
            let textToShare = [ cellViewModel.htmlUrl ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
        share.backgroundColor = .blue

        return [share]
    }
    
    
}

