//
//  ReposPresenter.swift
//  GitHubReposList
//
//  Created by Ростислав Ермаченков on 21.01.2021.
//

import Foundation

protocol ReposPresentationLogic {
    func presentData(request: Repos.Model.Response.ResponseType)
}

class ReposPresenter: ReposPresentationLogic {
    
    var service: ReposService?
    unowned let view: ReposDisplayLogic
    
    init(view: ReposDisplayLogic) {
        self.view = view
    }
    
    func presentData(request: Repos.Model.Response.ResponseType) {
        if service == nil {
            service = ReposService()
      }
      
      switch request {
      case .presentRepos:
        service?.getRepos(completion: { [weak self] repos in
            let cells = repos.map { (reposItem) in
                return ReposViewModel.Cell.init(id: reposItem.id, name: reposItem.name, ownerLogin: reposItem.owner.login, description: reposItem.reposResponseDescription, htmlUrl: reposItem.htmlUrl)
            }
            
            let reposViewModel = ReposViewModel.init(cells: cells)
            
            self?.view.displayData(viewModel: Repos.Model.ViewModel.ViewModelData.displayRepos(reposViewModel: reposViewModel))
          })
      case .presentFooterLoader:
        service?.getNextBatch(completion: { [weak self] repos in
            let cells = repos.map { (reposItem) in
                return ReposViewModel.Cell.init(id: reposItem.id, name: reposItem.name, ownerLogin: reposItem.owner.login, description: reposItem.reposResponseDescription, htmlUrl: reposItem.htmlUrl)
            }
            
            let reposViewModel = ReposViewModel.init(cells: cells)
            
            self?.view.displayData(viewModel: Repos.Model.ViewModel.ViewModelData.displayRepos(reposViewModel: reposViewModel))
        })
      }
    }
    
}
