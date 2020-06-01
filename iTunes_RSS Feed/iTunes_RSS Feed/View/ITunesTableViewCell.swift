//
//  View.swift
//  iTunes_RSS Feed
//
//  Created by Yoseph on 5/24/20.
//  Copyright © 2020 Yoseph. All rights reserved.
//

import Foundation
import UIKit

class ITunesTableViewCell: UITableViewCell {
    
    
    let albumImage: UIImageView = {
        let userImage = UIImageView()
        userImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userImage.contentMode = .scaleAspectFill
        userImage.clipsToBounds = true
        userImage.layer.borderWidth = 1
        userImage.layer.borderColor = UIColor.red.cgColor
        return userImage
    }()
    
    lazy var albumNamelbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 13)
        lbl.numberOfLines = 0
        lbl.textColor = .white
        return lbl
    }()
    
    lazy var artistNamelbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 12)
        lbl.numberOfLines = 0
        lbl.textColor = .gray
        return lbl
    }()
    
    
    // MARK: Cell Delegate Methods

    
    override func layoutSubviews() {
        backgroundColor = .clear
        albumImage.layer.cornerRadius = CGFloat(roundf(Float(albumImage.frame.size.width/2.0)))
        albumImage.layer.masksToBounds = true
    }
    
    
    var result: ResultFeed? {
        didSet {
            guard let result = result else {return}
            if let artistName = result.artistName {
                artistNamelbl.text = artistName
            }
            if let name = result.name {
                albumNamelbl.text = name
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        let labelStackView = VerticalStackView(arrangedSubviews: [albumNamelbl, artistNamelbl], spacing: 5)
        
        let stackView = UIStackView(arrangedSubviews: [albumImage,
                                                       labelStackView])
        
        stackView.spacing = 12
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 2, left: 30, bottom: 2, right: 10))
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}

class VerticalStackView: UIStackView {
    
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        
        arrangedSubviews.forEach({addArrangedSubview($0)})
        
        self.spacing = spacing
        self.axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
