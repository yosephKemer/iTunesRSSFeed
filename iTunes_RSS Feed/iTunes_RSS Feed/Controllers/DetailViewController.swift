//
//  DetailViewModel.swift
//  iTunes_RSS Feed
//
//  Created by Yoseph on 5/24/20.
//  Copyright © 2020 Yoseph. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let albumView : UIView = {
        let cv = UIView()
        cv.backgroundColor = .white
        cv.layer.cornerRadius = 15
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.alpha = 0.5
        return cv
    }()
    
    let albumImageView: UIImageView = {
        let civ = UIImageView()
        civ.tintColor = UIColor.white
        civ.contentMode = .scaleToFill
        civ.layer.cornerRadius = 75
        civ.translatesAutoresizingMaskIntoConstraints = false
        return civ
    }()
    
    let albumNamelabel: UILabel = {
        let cl = UILabel()
        cl.textColor = .darkGray
        cl.numberOfLines = 0
        cl.textAlignment = .center
        cl.font = UIFont.systemFont(ofSize: 20)
        cl.translatesAutoresizingMaskIntoConstraints = false
        return cl
    }()
    
    let artistNameLabel: UILabel = {
        let cl = UILabel()
        cl.textColor = .darkGray
        cl.font = UIFont.systemFont(ofSize: 15)
        cl.translatesAutoresizingMaskIntoConstraints = false
        cl.textAlignment = .center
        cl.numberOfLines = 0
        cl.lineBreakMode = .byWordWrapping
        cl.sizeToFit()
        return cl
    }()
    
    let releaseDateLabel: UILabel = {
        let cl = UILabel()
        cl.textColor = .darkGray
        cl.numberOfLines = 0
        cl.textAlignment = .center
        cl.font = UIFont.systemFont(ofSize: 15)
        cl.translatesAutoresizingMaskIntoConstraints = false
        return cl
    }()
    
    let genereLabel: UILabel = {
        let cl = UILabel()
        cl.textColor = .darkGray
        cl.font = UIFont.systemFont(ofSize: 15)
        cl.translatesAutoresizingMaskIntoConstraints = false
        cl.textAlignment = .center
        cl.numberOfLines = 0
        cl.lineBreakMode = .byWordWrapping
        cl.sizeToFit()
        return cl
    }()
    
    let copyRightLabel: UILabel = {
        let cl = UILabel()
        cl.textColor = .darkGray
        cl.font = UIFont.systemFont(ofSize: 15)
        cl.translatesAutoresizingMaskIntoConstraints = false
        cl.textAlignment = .center
        cl.numberOfLines = 0
        cl.lineBreakMode = .byWordWrapping
        cl.sizeToFit()
        return cl
    }()
    
    let okButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back to Home", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.07164370269, green: 0.3993143439, blue: 0.9998579621, alpha: 1)
        button.setTitleColor(.white , for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(okAction), for: .touchUpInside)
        return button
    }()
    
    
    var dashboardDetailModel = DetailViewModel()
    
    // MARK: Initializer
    
    init(dashboardDetailModel: DetailViewModel) {
        self.dashboardDetailModel = dashboardDetailModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        dashboardDetailModel.delegate = self
        setupView()
        setupConstraints()
        dashboardDetailModel.viewDidLoad()
        
    }
    
    // MARK: Custom Methods
    
    private func updateUI(){
        guard let result = dashboardDetailModel.result else {
            return
        }
        ImageLoader().obtainImageWithPath(imageName: result.name ?? "" ,
                                          imageURL: result.artworkUrl100 ) { (image) in
                                            self.albumImageView.image = image
        }
        albumNamelabel.text = result.name
        artistNameLabel.text = result.artistName
        copyRightLabel.text = result.copyright ?? ""
        guard let genres = result.genres else {return}
        var genreStr = ""
        for genre in genres {
            if genreStr.isEmpty {
                genreStr.append(" \(genre.name ?? "")")
                
            } else {
                genreStr.append(", \(genre.name ?? "")")
                
            }
        }
        genereLabel.text = genreStr
        
    }
    
    
    func setupView() {
        view.addSubview(albumView)
        view.addSubview(albumImageView)
        view.addSubview(albumNamelabel)
        view.addSubview(artistNameLabel)
        view.addSubview(releaseDateLabel)
        view.addSubview(genereLabel)
        view.addSubview(copyRightLabel)
        view.addSubview(okButton)
    }
    
    func setupConstraints() {
        setupImageView()
        setupAlbumArtist()
        setupReleaseDate()
        setupGeneralLabel()
        setupCopyRightLabel()
        setupBtn()
    }
    
    func setupImageView(){
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":albumView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":albumView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[v0(250)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":albumImageView]))
        albumImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        albumImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupAlbumArtist() {
        albumNamelabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        albumNamelabel.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -50).isActive = true
        albumNamelabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        artistNameLabel.leftAnchor.constraint(equalTo: albumView.leftAnchor,constant: 20).isActive = true
        
        artistNameLabel.rightAnchor.constraint(equalTo: albumView.rightAnchor,constant: -20).isActive = true
        artistNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        artistNameLabel.topAnchor.constraint(equalTo: albumNamelabel.topAnchor, constant: 50).isActive = true
    }
    func setupReleaseDate() {
        releaseDateLabel.leftAnchor.constraint(equalTo: albumView.leftAnchor,constant: 20).isActive = true
        releaseDateLabel.rightAnchor.constraint(equalTo: albumView.rightAnchor,constant: -20).isActive = true
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        releaseDateLabel.topAnchor.constraint(equalTo: artistNameLabel.topAnchor, constant: 50).isActive = true
    }
    
    func setupGeneralLabel() {
        genereLabel.leftAnchor.constraint(equalTo: albumView.leftAnchor,constant: 20).isActive = true
        genereLabel.rightAnchor.constraint(equalTo: albumView.rightAnchor,constant: -20).isActive = true
        genereLabel.topAnchor.constraint(equalTo: releaseDateLabel.topAnchor, constant: 50).isActive = true
    }
    
    func setupCopyRightLabel() {
        copyRightLabel.leftAnchor.constraint(equalTo: albumView.leftAnchor,constant: 20).isActive = true
        copyRightLabel.rightAnchor.constraint(equalTo: albumView.rightAnchor,constant: -20).isActive = true
        copyRightLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        copyRightLabel.topAnchor.constraint(equalTo: genereLabel.topAnchor, constant: 50).isActive = true
    }
    
    func setupBtn() {
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":okButton]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(60)]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":okButton]))
    }
    
    @objc func okAction() {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: DetailViewModelProtocol {
    func update() {
        updateUI()
    }
}
