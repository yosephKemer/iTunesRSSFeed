//
//  DetailViewModelDelegate.swift
//  iTunes_RSS Feed
//
//  Created by Yoseph on 5/24/20.
//  Copyright © 2020 Yoseph. All rights reserved.
//

import Foundation
import UIKit

protocol DetailViewModelProtocol: class {
    func update()
}


class DetailViewModel {
    var result: ResultFeed?
    weak var delegate: DetailViewModelProtocol?
    
    func viewDidLoad(){
        delegate?.update()
    }
}
