//
//  ReposCell.swift
//  GitHubReposList
//
//  Created by Ростислав Ермаченков on 19.01.2021.
//

import Foundation
import UIKit

class ReposCell: UITableViewCell {
    
    static let reuseId = "ReposCell"
    
    let cellView: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let idLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let ownerLoginLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
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
        
        cellView.layer.cornerRadius = 10
        cellView.clipsToBounds = true
        
        overlayFirstLayer()
        overlayCardView()
        
        idLabel.text = "idLabel"
        nameLabel.text = "nameLabel"
        ownerLoginLabel.text = "ownerLoginLabel"
        descriptionLabel.text = "description description description description description 6645523423 description description description 222222"
        
    }
    
    private func overlayCardView() {
        cellView.addSubview(idLabel)
        cellView.addSubview(nameLabel)
        cellView.addSubview(ownerLoginLabel)
        cellView.addSubview(descriptionLabel)
        
        nameLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        idLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        idLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20).isActive = true
        idLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        ownerLoginLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        ownerLoginLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        ownerLoginLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        descriptionLabel.anchor(top: nil, leading: cellView.leadingAnchor,
                                bottom: cellView.bottomAnchor,
                                trailing: cellView.trailingAnchor,
                                size: CGSize(width: 70, height: 40))
        
    }
    
     private func overlayFirstLayer() {
        if #available(iOS 14.0, *) {
            contentView.addSubview(cellView)
        } else {
            addSubview(cellView)
        }
    
        cellView.fillSuperview(padding: Constants.cellInsets)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
