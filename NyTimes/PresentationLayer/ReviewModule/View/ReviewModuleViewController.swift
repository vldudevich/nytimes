//
//  ReviewModuleViewController.swift
//  NyTimes
//
//  Created by vladislav on 01.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit
import AlamofireImage

class ReviewModuleViewController: UIViewController {

    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var dataPickerTextFieldFrom: UITextField!
    @IBOutlet private weak var dataPickerTextFieldTo: UITextField!
    @IBOutlet private weak var moviesTableView: UITableView!
    
    let myDatePicker = UIDatePicker()
    
    private var movies = [Movie]()
    private var tempMovies = [Movie]()
    private var numResults = 0
    private var limit = 3
    private var index = 0
    private var bufDate = ""
    private var isLoading = false
    
    var output: ReviewModuleViewOutput!
    
    private var flagTextField = State.activeTextFieldNone
    
    private enum State {
        case activeTextFieldFrom
        case activeTextFieldTo
        case activeTextFieldNone
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        updateMovies()
    }
    
    func setDatePicker(textField: UITextField) {
        textField.inputView = myDatePicker
        myDatePicker.datePickerMode = .date
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTouchUpInside))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.isUserInteractionEnabled = true
        toolBar.setItems([flexButton, doneButton], animated: true)
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTouchUpInside() {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        bufDate = dateFormatter.string(from: myDatePicker.date)
        if flagTextField == .activeTextFieldFrom {
            dataPickerTextFieldFrom.text = bufDate
        } else if flagTextField == .activeTextFieldTo {
            dataPickerTextFieldTo.text = bufDate

        }
        self.view.endEditing(true)
        updateMovies()
    }

    @objc func updateRefresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        updateMovies()
    }
    
    func clearTable() {
        index = 0
        tempMovies.removeAll()
    }
    
    func updateMovies() {
        clearTable()
        output.setupInitialState(cityToSearch: searchTextField.text ?? "", dateToSearch: DateRange(fromDate: dataPickerTextFieldFrom.text!, toDate: dataPickerTextFieldTo.text!))
    }
}

extension ReviewModuleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsTableViewCell.identifier) as! ReviewsTableViewCell
        cell.delegate = self
        cell.configureCell(results: tempMovies, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moviesTableView.deselectRow(at: indexPath, animated: true)

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
                    moviesTableView.reloadData()
                }
            }
        }
        if (contentYoffset < 0) {
            updateMovies()
        }
    }
}

extension ReviewModuleViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField {
            textField.resignFirstResponder()
            updateMovies()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dataPickerTextFieldFrom {
            flagTextField = State.activeTextFieldFrom
            setDatePicker(textField: textField)
            
        } else if textField == dataPickerTextFieldTo {
            flagTextField = State.activeTextFieldTo
            setDatePicker(textField: textField)
        }
    }
}

extension ReviewModuleViewController: ReviewsTableViewCellDelegate {
    
    func shareButtonTouchUpInside(_ cell: ReviewsTableViewCell) {
        guard let index =  moviesTableView.indexPath(for: cell)?.row else {return}
        var myImage = UIImage()
        tempMovies[index].getImage { (image) in
            myImage = image
        }
        let activityController = UIActivityViewController(activityItems: [myImage, tempMovies[index].byline], applicationActivities: nil)
        present(activityController, animated: true)
    }
}

extension ReviewModuleViewController: ReviewModuleViewInput {
    func onMoviesGet(results: Review) {
        clearTable()
        movies = results.results
        while index < limit && tempMovies.count < movies.count {
            tempMovies.append(movies[self.index])
            index += 1
        }
        moviesTableView.reloadData()
    }
    
    func setupState() {
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
        
        self.searchTextField.delegate = self
        self.dataPickerTextFieldFrom.delegate = self
        self.dataPickerTextFieldTo.delegate = self
        
        let tableRefreshControl = UIRefreshControl()
        tableRefreshControl.addTarget(self, action: #selector(updateRefresh(_:)), for: .valueChanged)
        moviesTableView.refreshControl = tableRefreshControl
    }
}
