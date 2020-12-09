//
//  DetailViewController.swift
//  NyTimes
//
//  Created by vladislav on 01.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class DetailReviewModuleViewController: UIViewController {

    @IBOutlet weak var criticImageView: UIImageView!
    @IBOutlet weak var criticNameLabel: UILabel!
    @IBOutlet weak var descriptionButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet private weak var criticsMoviesTableView: UITableView!
    @IBOutlet private weak var myNavigationBar: UINavigationBar!
    @IBOutlet weak var detailTitleNavBar: UINavigationItem!
    @IBOutlet private weak var descriptionView: UIView!
    
    private var movies = [Movie]()
    private var tempMovies = [Movie]()
    private var limit = 5
    
    var output: DetailReviewModuleViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCriticsReviews()
    }

    @objc func updateRefresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        updateCriticsReviews()
    }
    
    @IBAction func showDescription(_ sender: UIButton) {
        descriptionView.isHidden = !descriptionView.isHidden
    }

    func clearTable() {
    }
    
    func updateCriticsReviews() {
        clearTable()
        let encodeString = criticNameLabel.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        output.setupInitialState(searchMovies: encodeString!)
        criticsMoviesTableView.reloadData()
    }
    
    func loadAcceptStyle() {
        myNavigationBar.barTintColor = .lightBlue
        descriptionButton.backgroundColor = .lightBlue
        myNavigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension DetailReviewModuleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CriticsReviewsTableViewCell.identifier) as! CriticsReviewsTableViewCell
        cell.configureCell(results: tempMovies[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == tempMovies.count - 1  {
            if tempMovies.count < movies.count {
                limit = tempMovies.count + 1
                tempMovies.append(contentsOf: movies[tempMovies.count..<limit])
                criticsMoviesTableView.reloadData()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        criticsMoviesTableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DetailReviewModuleViewController: CriticsReviewsTableViewCellDelegate {

    func shareButtonTouchUpInside(_ cell: CriticsReviewsTableViewCell) {
        guard let index =  criticsMoviesTableView.indexPath(for: cell)?.row else {return}
        
        var myImage = UIImage()
        tempMovies[index].getImage { (image) in
            myImage = image
        }
        
        let activityController = UIActivityViewController(activityItems: [myImage, tempMovies[index].byline], applicationActivities: nil)
        present(activityController, animated: true)
    }
}

extension DetailReviewModuleViewController: DetailReviewModuleViewInput {
    func setupState() {
        let tableRefreshControl = UIRefreshControl()
        tableRefreshControl.addTarget(self, action: #selector(updateRefresh(_:)), for: .valueChanged)
        
        loadAcceptStyle()
        criticsMoviesTableView.delegate = self
        criticsMoviesTableView.dataSource = self
        criticsMoviesTableView.refreshControl = tableRefreshControl
    }
    
    func onMoviesGet(results: Review) {
        clearTable()
        movies = results.results
        if tempMovies.count < movies.count {
            tempMovies.append(contentsOf: movies[0..<limit])
            criticsMoviesTableView.reloadData()
        }
        
    }
}
