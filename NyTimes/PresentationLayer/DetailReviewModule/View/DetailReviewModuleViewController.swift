//
//  DetailViewController.swift
//  NyTimes
//
//  Created by vladislav on 01.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit
import AlamofireImage

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
    private var limit = 3
    private var index = 0
    
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
        index = 0
        tempMovies.removeAll()
    }
    
    func updateCriticsReviews() {
        clearTable()
        output.setupInitialState(searchMovies: criticNameLabel.text!)
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
        cell.configureCell(results: tempMovies, for: indexPath)
        
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        index = tempMovies.count
        let indexLast = tempMovies.count - 1
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if (contentYoffset > 0 && distanceFromBottom < height) && tempMovies.count < movies.count {
            for _ in 0...limit {
                if indexLast + 1 < movies.count - 1 {
                    tempMovies.append(movies[index])
                    index += 1
                    criticsMoviesTableView.reloadData()
                }
            }
        }
        if (contentYoffset < 0) {
            updateCriticsReviews()
        }
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
        while index < limit {
            tempMovies.append(movies[self.index])
            index += 1
        }
        criticsMoviesTableView.reloadData()
    }
    
}
