//
//  CriticsViewController.swift
//  NyTimes
//
//  Created by vladislav on 20.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit
import AlamofireImage

class CriticsViewController: UIViewController {

    @IBOutlet weak var searchCriticLabel: UITextField!
    @IBOutlet weak var criticsCollectionView: UICollectionView!
    
    var critics = [Critics]()
    var tempCritics = [Critics]()
    
    var limit = 2
    var index = 0
    
    let tableRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(updateRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        criticsCollectionView.delegate = self
        criticsCollectionView.dataSource = self
        searchCriticLabel.delegate = self
        criticsCollectionView.refreshControl = tableRefreshControl
        updateCritics()
    }
    
    func clearTable() {
        index = 0
    }
    
    func updateCritics() {
        clearTable()
        let resultString = searchCriticLabel.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        API.critics(searchCriticName: resultString!, succes: { (data) in
            Critic.parseResponse(responseData: data) { (critic) in
                guard let data = critic else {return}
                self.critics = data.results
                while self.index < self.limit {
                    self.tempCritics.append(self.critics[self.index])
                    self.index += 1
                }
                self.criticsCollectionView.reloadData()
            }
        }) { (error) in
            print(error)
        }
    }
    
    
    @objc func updateRefresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        updateCritics()
    }
    
    func configureCell(cell: CriticsCollectionViewCell, for indexPath: IndexPath) {
        cell.criticsNameLabel.text = tempCritics[indexPath.row].displayName
        if let multimedia = tempCritics[indexPath.row].multimedia,
            let source = multimedia.resource?.sourceURL,
            let url = URL(string: source) {
            cell.criticsImageView.af_setImage(
                withURL: url
            )
        } else {
            cell.criticsImageView.image = UIImage(named: "nophoto")
        }
    }
    
    func sendData(for send: [Critics], for indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        self.present(vc!, animated: true, completion: nil)
        
        vc?.criticNameLabel.text = critics[indexPath.row].displayName
        vc?.descriptionButton.setTitle(critics[indexPath.row].status,for: .normal)
        vc?.detailTitleNavBar.title = critics[indexPath.row].displayName
        vc?.descriptionLabel.text = critics[indexPath.row].bio
        vc?.criticImageView
        if let multimedia = tempCritics[indexPath.row].multimedia,
            let source = multimedia.resource?.sourceURL,
            let url = URL(string: source) {
            vc?.criticImageView.af_setImage(
                withURL: url
            )
        } else {
            vc?.criticImageView.image = UIImage(named: "nophoto")
        }
    }
}

extension CriticsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempCritics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CriticsCollectionViewCell.identifier, for: indexPath) as! CriticsCollectionViewCell
            configureCell(cell: cell, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2 , height: collectionView.frame.size.width / 2 )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sendData(for: critics, for: indexPath)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        index = tempCritics.count
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if contentYoffset > 0 && distanceFromBottom < height && tempCritics.count < critics.count {
            print(" you reached end of the table")
            tempCritics.append(critics[index])
            index += 1
            criticsCollectionView.reloadData()
        }
    }
}

extension CriticsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchCriticLabel {
            textField.resignFirstResponder()
            updateCritics()
        }
        return true
    }
}
