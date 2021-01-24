//
//  ReposCell.swift
//  GitHubReposList
//
//  Created by Ростислав Ермаченков on 19.01.2021.
//

import Foundation
import UIKit

protocol ReposCellViewModel {
    var id: Int { get }
    var name: String { get }
    var ownerLogin: String { get }
    var description: String? { get }
}


class ReposCell: UITableViewCell {
    
    static let reuseId = "ReposCell"
    
    let cellView: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let idLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let ownerLoginLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let descriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()


    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        overlayFirstLayer()
        overlayCardView()
    }
    
    private func overlayCardView() {
        cellView.addSubview(idLabel)
        cellView.addSubview(nameLabel)
        cellView.addSubview(ownerLoginLabel)
        cellView.addSubview(descriptionLabel)
        
        nameLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        idLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        idLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20).isActive = true
        idLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        ownerLoginLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        ownerLoginLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        ownerLoginLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        descriptionLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
    }
    
     private func overlayFirstLayer() {
        if #available(iOS 14.0, *) {
            contentView.addSubview(cellView)
        } else {
            addSubview(cellView)
        }
    
        cellView.fillSuperview(padding: Constants.cellInsets)
    }
    
    func set(viewModel: ReposCellViewModel) {
        idLabel.text = "id: " + String(viewModel.id)
        nameLabel.text = viewModel.name
        ownerLoginLabel.text = viewModel.ownerLogin
        descriptionLabel.text = viewModel.description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
