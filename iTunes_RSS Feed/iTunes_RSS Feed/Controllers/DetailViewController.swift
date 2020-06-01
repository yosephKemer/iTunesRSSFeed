//
//  DetailViewModel.swift
//  iTunes_RSS Feed
//
//  Created by Yoseph on 5/24/20.
//  Copyright © 2020 Yoseph. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var dashboardDetailModel = DetailViewModel()
    
    let albumImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 75
        return image
    }()
    
    let albumNamelabel: UILabel = {
        let cl = UILabel()
        cl.textColor = .white
        cl.numberOfLines = 0
        cl.textAlignment = .center
        cl.font = UIFont.systemFont(ofSize: 20)
        cl.translatesAutoresizingMaskIntoConstraints = false
        return cl
    }()
    
    let artistNameLabel: UILabel = {
        let cl = UILabel()
        cl.textColor = .gray
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
        cl.textColor = .red
        cl.numberOfLines = 0
       // cl.textAlignment = .center
        cl.font = UIFont.systemFont(ofSize: 15)
        cl.translatesAutoresizingMaskIntoConstraints = false
        return cl
    }()
    
    let genereLabel: UILabel = {
        let cl = UILabel()
        cl.textColor = .darkGray
        cl.font = UIFont.systemFont(ofSize: 15)
        cl.translatesAutoresizingMaskIntoConstraints = false
       // cl.textAlignment = .center
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
       // cl.textAlignment = .center
        cl.numberOfLines = 0
        cl.lineBreakMode = .byWordWrapping
        cl.sizeToFit()
        return cl
    }()
    
    let okButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back to Home", for: .normal)
        button.backgroundColor = .brown
        button.setTitleColor(.white , for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.red.cgColor
        button.addTarget(self, action: #selector(okAction), for: .touchUpInside)
        return button
    }()
    
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
        view.backgroundColor = .black
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
        // view.addSubview(albumView)
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
        setupArtistName()
        setupGeneralLabel()
        setupCopyRightLabel()
        setupBtn()
    }
    
    func setupImageView(){
        let safeArea = view.safeAreaLayoutGuide
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumImageView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        albumImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 2).isActive = true
        albumImageView.widthAnchor.constraint(equalToConstant: view.frame.width ).isActive = true
        
    }
    
    
    func setupAlbumArtist() {
        albumNamelabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        albumNamelabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant:  20).isActive = true
        
    }
    func setupArtistName() {
        artistNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        artistNameLabel.topAnchor.constraint(equalTo: albumNamelabel.bottomAnchor, constant: 20).isActive = true
    }
    
    func setupGeneralLabel() {
        genereLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        genereLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 20).isActive = true
    }
    
    func setupCopyRightLabel() {
        copyRightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        copyRightLabel.topAnchor.constraint(equalTo: genereLabel.bottomAnchor, constant: 35).isActive = true
    }
    
    func setupBtn() {
        let safeArea = view.safeAreaLayoutGuide
        okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        okButton.heightAnchor.constraint(equalTo: okButton.heightAnchor, constant: 40).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        okButton.trailingAnchor.constraint(equalTo: okButton.trailingAnchor, constant: -20).isActive = true
        okButton.leadingAnchor.constraint(equalTo: okButton.leadingAnchor, constant: 20).isActive = true
        okButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
        
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

