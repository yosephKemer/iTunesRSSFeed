//
//  ViewController.swift
//  iTunes_RSS Feed
//
//  Created by Yoseph on 5/24/20.
//  Copyright © 2020 Yoseph. All rights reserved.
//

import UIKit

class ITunesViewController: UIViewController {
    
    private let tableView = UITableView()
    var activityView: UIActivityIndicatorView?
    var safeArea: UILayoutGuide!
    var imageLoader = ImageLoader()
    
    
    var dashBoardViewModel = MainViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupTableView()
        dashBoardViewModel.delegate = self
        dashBoardViewModel.fetchRSS()
        self.title = "ITunes RSS Feed"
        
    }
    
    // MARK: Custom Methods
    
    private func updateUI(){
        tableView.reloadData()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = UIColor.white
        tableView.register(ITunesTableViewCell.self, forCellReuseIdentifier: "DashboardTableViewCell")
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        guard let activityView = activityView else {return}
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
    
    
}

// MARK: UITableViewDelegate

extension ITunesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let results = dashBoardViewModel.model?.feed.results
        return results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell", for: indexPath) as? ITunesTableViewCell else {fatalError("Unabel to create cell")}
        if let results = dashBoardViewModel.model?.feed.results {
            let result = results[indexPath.row]
            imageLoader.obtainImageWithPath(imageName: result.name ?? "", imageURL: result.artworkUrl100 ) { (image) in
                if let cell = tableView.cellForRow(at: indexPath) as? ITunesTableViewCell{
                    cell.albumImage.image = image
                }
            }
        }
        cell.result = dashBoardViewModel.model?.feed.results[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = DetailViewModel()
        viewModel.result = dashBoardViewModel.model?.feed.results[indexPath.row]
        let dashboardDetailViewController = DetailViewController(dashboardDetailModel: viewModel)
        present(dashboardDetailViewController, animated: true, completion: nil)
    }
    
    
}

// MARK: ITunesViewModelDelegate

extension ITunesViewController : ITunesViewModelDelegate {
    
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            self.showActivityIndicator()
        }
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.hideActivityIndicator()
        }
    }
    
    func fetchRssCallBack(status: Bool, message: String) {
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
}
