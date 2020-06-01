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
    var imageLoader = ImageLoader()
    var dashBoardViewModel = MainViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupTableView()
        dashBoardViewModel.delegate = self
        dashBoardViewModel.fetchRSS(FeedType.comingSoon.rawValue)
        setupSegmentedControl()
       
    }
    
    // MARK: Custom Methods
    
    private func updateUI(){
        tableView.reloadData()
        setupNavigationBar()
        
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.backgroundColor = .black
        tableView.register(ITunesTableViewCell.self, forCellReuseIdentifier: "ITunesTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func setupNavigationBar() {
        
        self.title = "iTunes Coming Soon"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemRed
        appearance.titleTextAttributes = [.foregroundColor: UIColor.lightText]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ITunesTableViewCell", for: indexPath) as? ITunesTableViewCell else {preconditionFailure("")}
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
        return 60
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

extension ITunesViewController {
    func setupSegmentedControl() {
        let segmentTextContent = [
            NSLocalizedString("Coming Soon", comment: ""),
            NSLocalizedString("New Releases", comment: ""),
            NSLocalizedString("Top Albums", comment: "")
        ]
        
        // Segmented control as the custom title view.
        let segmentedControl = UISegmentedControl(items: segmentTextContent)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.autoresizingMask = .flexibleWidth
        segmentedControl.frame = CGRect(x: 0, y: 0, width: view.frame.width - 15, height: 30)
        segmentedControl.addTarget(self, action: #selector(selectSegmentedControl(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentTintColor = #colorLiteral(red: 0.5939439535, green: 0.5939439535, blue: 0.5939439535, alpha: 1)
        self.navigationItem.titleView = segmentedControl
        
      
    }
    
    @objc func selectSegmentedControl(_ sender: UISegmentedControl) {
        //print("\(sender.selectedSegmentIndex)")
       
        switch sender.selectedSegmentIndex {
        case 0:
            print("0")
             dashBoardViewModel.fetchRSS(FeedType.comingSoon.rawValue)
        case 1:
            print("1")
             dashBoardViewModel.fetchRSS(FeedType.newReleases.rawValue)
        case 2:
            print("2")
             dashBoardViewModel.fetchRSS(FeedType.topAlbums.rawValue)
        default:
            break
        }
        
    }
}
