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
    
    let  backView: UIView = {
        let view = UIView(frame: CGRect(x: 4, y: 6, width: UIScreen.main.bounds.size.width - 8, height: 110))
        view.backgroundColor = #colorLiteral(red: 0.2285108566, green: 0.546705544, blue: 0.845690906, alpha: 1)
        return view
    }()
    
    let albumImage: UIImageView = {
        let userImage = UIImageView(frame: CGRect(x: 4, y: 4, width: 104, height: 104))
        userImage.contentMode = .scaleAspectFill
        return userImage
    }()
    
    lazy var albumNamelbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 116, y: 8, width: backView.frame.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.numberOfLines = 2
        lbl.textColor = UIColor.white
        return lbl
    }()
    
    lazy var artistNamelbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 116, y: 42, width: backView.frame.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        lbl.textColor = UIColor.white
        return lbl
    }()
    
    
    // MARK: Cell Delegate Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        backView.addSubview(albumImage)
        backView.addSubview(albumNamelbl)
        backView.addSubview(artistNamelbl)
        self.backgroundColor = UIColor.white
    }
    
    override func layoutSubviews() {
        backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        albumImage.layer.cornerRadius = 52
        albumImage.clipsToBounds = true
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
    
}
