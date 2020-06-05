//
//  DetailViewController.swift
//  NyTimes
//
//  Created by vladislav on 01.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {

    @IBOutlet weak var criticImageView: UIImageView!
    @IBOutlet weak var criticNameLabel: UILabel!
    @IBOutlet weak var descriptionButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var criticsMoviesTableView: UITableView!
    @IBOutlet weak var myNavigationBar: UINavigationBar!
    @IBOutlet weak var detailTitleNavBar: UINavigationItem!
    @IBOutlet weak var descriptionView: UIView!
    
    let lightBlue = UIColor(red: 78/255, green: 103/255, blue: 255/255, alpha: 1)
    
    var movies = [Movie]()
    var tempMovies = [Movie]()
    var limit = 3
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableRefreshControl = UIRefreshControl()
        tableRefreshControl.addTarget(self, action: #selector(updateRefresh(_:)), for: .valueChanged)
        
        loadAcceptStyle()
        criticsMoviesTableView.delegate = self
        criticsMoviesTableView.dataSource = self
        criticsMoviesTableView.refreshControl = tableRefreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateCriticsReviews()
    }
    
    @IBAction func tapToShare(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: [], applicationActivities: [])
        activityController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityController, animated: true)
    }
    
    @objc func updateRefresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        updateCriticsReviews()
    }
    
    @IBAction func showDescription(_ sender: UIButton) {
        descriptionView.isHidden = !descriptionView.isHidden
    }

    func configureCell(cell: CriticsReviewsTableViewCell, for indexPath: IndexPath) {
        cell.criticsMoviesTitleLabel.text = tempMovies[indexPath.row].displayTitle
        cell.criticsDescriptionLabel.text = tempMovies[indexPath.row].summaryShort
        cell.criticsNameMoviesLabel.text = tempMovies[indexPath.row].byline
        cell.criticsMoviesDateLabel.text = tempMovies[indexPath.row].dateUpdated
        if let multimedia = tempMovies[indexPath.row].multimedia,
                let source = multimedia.sourceURL,
                let url = URL(string: source) {
                cell.criticsMoviesImageView.af_setImage(
                    withURL: url
                )
            } else {
                cell.criticsMoviesImageView.image = UIImage(named: "nophoto")
            }
    }
    func clearTable() {
        index = 0
    }
    
    func updateCriticsReviews() {
        clearTable()
        API.searchCriticsMovies(searchMovies: criticNameLabel.text!, succes: { (data) in
            Review.parseResponse(responseData: data) { (critic) in
                guard let data = critic else {return}
                self.movies = data.results
                while self.index < self.limit {
                       self.tempMovies.append(self.movies[self.index])
                       self.index += 1
                   }
                self.criticsMoviesTableView.reloadData()
            }
        }) { (error) in
            print(error)
        }
    }
    
    func loadAcceptStyle() {
        myNavigationBar.barTintColor = lightBlue
        descriptionButton.backgroundColor = lightBlue
        myNavigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CriticsReviewsTableViewCell.identifier) as! CriticsReviewsTableViewCell
        configureCell(cell: cell, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        index = tempMovies.count
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if contentYoffset > 0 && distanceFromBottom < height && tempMovies.count < movies.count {
            print(" you reached end of the table")
            tempMovies.append(movies[index])
            index += 1
            criticsMoviesTableView.reloadData()
        }
    }
}
