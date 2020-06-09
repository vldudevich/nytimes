//
//  ReviewsViewController.swift
//  NyTimes
//
//  Created by vladislav on 20.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit
import AlamofireImage

class ReviewsViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var dataPickerTextFieldFrom: UITextField!
    @IBOutlet weak var dataPickerTextFieldTo: UITextField!
    @IBOutlet weak var moviesTableView: UITableView!
    
    let myDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.addTarget(self, action: #selector(setDate(_:)), for: .valueChanged)
        return datePicker
    }()
    
    var movies = [Movie]()
    var tempMovies = [Movie]()
    var numResults = 0
    var limit = 3
    var index = 0
    var bufDate = ""

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tableRefreshControl = UIRefreshControl()
        tableRefreshControl.addTarget(self, action: #selector(updateRefresh(_:)), for: .valueChanged)
        
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
        
        self.searchTextField.delegate = self
        self.dataPickerTextFieldFrom.delegate = self
        self.dataPickerTextFieldTo.delegate = self
        
        moviesTableView.refreshControl = tableRefreshControl
        updateMovies()
    }

    
    @objc func setDate(_ sender: UIDatePicker) {

        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        bufDate = dateFormatter.string(from: sender.date)
        view.endEditing(true)
    }

    @objc func updateRefresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        updateMovies()
    }
    
    func configureCell(cell: ReviewsTableViewCell, for indexPath: IndexPath) {
        cell.reviewTitleLabel.text = tempMovies[indexPath.row].displayTitle
        cell.reviewDescriptionLabel.text = tempMovies[indexPath.row].summaryShort
        cell.reviewNameLabel.text = tempMovies[indexPath.row].byline
        cell.rewiewDateLabel.text = tempMovies[indexPath.row].dateUpdated
        cell.cellDelegate = self
        cell.index = indexPath
        if let multimedia = tempMovies[indexPath.row].multimedia,
            let source = multimedia.sourceURL,
            let url = URL(string: source) {
            
            cell.reviewImageView.af_setImage(withURL: url)
        } else {
            cell.reviewImageView.image = UIImage(named: "nophoto")
        }
    }
    
    func clearTable() {
        index = 0
    }
    
    func updateMovies() {
        clearTable()
        API.reviews(stringToSearch: searchTextField.text ?? "", dateToSearch: DateRange(fromDate: dataPickerTextFieldFrom.text!, toDate: dataPickerTextFieldTo.text!),  succes: { (data) in
            Review.parseResponse(responseData: data) { (review) in
                guard let data = review else {return}
                self.movies = data.results
                while self.index < self.limit {
                    self.tempMovies.append(self.movies[self.index])
                    self.index += 1
                }
                self.moviesTableView.reloadData()
            }
        }) { (error) in
            print(error)
        }
    }
}

extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsTableViewCell.identifier) as! ReviewsTableViewCell
        configureCell(cell: cell, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moviesTableView.deselectRow(at: indexPath, animated: true)
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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
            moviesTableView.reloadData()
        }
    }
}

extension ReviewsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField {
            textField.resignFirstResponder()
            updateMovies()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dataPickerTextFieldFrom {
            myDatePicker.datePickerMode = .date
            dataPickerTextFieldFrom.inputView = myDatePicker
        } else if textField == dataPickerTextFieldTo {
            myDatePicker.datePickerMode = .date
            dataPickerTextFieldTo.inputView = myDatePicker

        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == dataPickerTextFieldFrom {
            dataPickerTextFieldFrom.text = bufDate
            
        } else if textField == dataPickerTextFieldTo {
            dataPickerTextFieldTo.text = bufDate
            updateMovies()
            
        }
    }
}

extension ReviewsViewController: TableViewNew {
    func onClick(index: Int) {
        let image = UIImageView()
        if let multimedia = tempMovies[index].multimedia,
            let source = multimedia.sourceURL,
            let url = URL(string: source) {
                image.af_setImage(withURL: url)
            } else {
            image.image = UIImage(named: "nophoto")
            }
        let activityController = UIActivityViewController(activityItems: [image.image!, tempMovies[index].byline], applicationActivities: nil)
        present(activityController, animated: true)
    }
}
