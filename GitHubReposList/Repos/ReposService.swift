//
//  ReposWorker.swift
//  GitHubReposList
//
//  Created by Ростислав Ермаченков on 20.01.2021.
//

import Foundation

class ReposService {
    var networking: Networking
    var fetcher: DataFetcher
    
    private var pageNumber = 1
    private let firstPageNumber = 1
    private var isLoading = false
    
    private var reposResponse: ReposResponse?
    
    init() {
        self.networking = NetworkService()
        self.fetcher = NetworkDataFetcher(networking: networking)
    }

    
    func getRepos(completion: @escaping (ReposResponse) -> Void) {
        fetcher.getRepos(nextBatchFrom: String(firstPageNumber)) { [ weak self] (repos) in
            self?.reposResponse = repos
            guard let reposResponse = self?.reposResponse else { return }
            completion(reposResponse)
        }
    }
    
    func getNextBatch(completion: @escaping (ReposResponse) -> Void) {
        guard !isLoading else { return }
        
        isLoading = true
        pageNumber += 1
        
        fetcher.getRepos(nextBatchFrom: String(pageNumber)) { [ weak self] (repos) in
            guard let repos = repos else { return }
            
            if self?.reposResponse == nil {
                self?.reposResponse = repos
            } else {
                self?.reposResponse?.append(contentsOf: repos)
            }
            
            guard let reposResponse = self?.reposResponse else { return }
            completion(reposResponse)
            self?.isLoading = false
        }
    }
}
