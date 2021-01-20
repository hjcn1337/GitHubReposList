//
//  ReposViewController.swift
//  GitHubReposList
//
//  Created by Ростислав Ермаченков on 19.01.2021.
//

import Foundation
import UIKit

class ReposViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()

    }
    
    private func setupTable() {
        table.register(ReposCell.self, forCellReuseIdentifier: ReposCell.reuseId)
    }

}

extension ReposViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReposCell.reuseId, for: indexPath) as! ReposCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 120
    }
    
    
}

