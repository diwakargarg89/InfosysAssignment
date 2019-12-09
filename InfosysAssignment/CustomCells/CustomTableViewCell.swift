//
//  CustomTableViewCell.swift
//  InfosysAssignment
//
//  Created by Diwakar Garg on 09/12/2019.
//  Copyright © 2019 Diwakar Garg. All rights reserved.
//

import UIKit
import SDWebImage

class CustomTableViewCell: UITableViewCell {

    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 25
        img.clipsToBounds = true
        return img
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Add the view as Subview in the cell content view.
        self.contentView.addSubview(profileImageView)
            containerView.addSubview(titleLabel)
            containerView.addSubview(descriptionTitleLabel)
        self.contentView.addSubview(containerView)

        let marginGuide = contentView.layoutMarginsGuide
          // configure imageview
        profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:50).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:50).isActive = true
       
        // configure ContainerView
        containerView.centerYAnchor.constraint(equalTo:marginGuide.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:marginGuide.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalTo:marginGuide.heightAnchor, constant:-10).isActive = true
          
        // configure titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true


        // configure authorLabel
        descriptionTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        descriptionTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        descriptionTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        descriptionTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
}
