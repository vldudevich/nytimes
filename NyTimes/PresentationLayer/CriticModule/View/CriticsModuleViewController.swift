//
//  CriticsViewController.swift
//  NyTimes
//
//  Created by vladislav on 20.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit
import AlamofireImage

class CriticModuleViewController: UIViewController {

    @IBOutlet private weak var searchCriticLabel: UITextField!
    @IBOutlet private weak var criticsCollectionView: UICollectionView!
    
    private var critics = [Critics]()
    private var tempCritics = [Critics]()
    
    private var limit = 8
    private var index = 0
    
    var output: CriticModuleViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCritics()
    }
    
    private func clearTable() {
        index = 0
    }
    
    func updateCritics() {
        clearTable()
        let resultString = searchCriticLabel.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        output.setupInitialState(criticToSearch: resultString!)
        criticsCollectionView.reloadData()
    }
    
    
    @objc func updateRefresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        updateCritics()
    }
    
    func sendData(for send: [Critics], for indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "DetailReviewModuleViewController", bundle: nil).instantiateInitialViewController()! as? DetailReviewModuleViewController
        self.present(vc!, animated: true, completion: nil)
        
        vc?.criticNameLabel.text = critics[indexPath.row].displayName
        vc?.descriptionButton.setTitle(critics[indexPath.row].status,for: .normal)
        vc?.detailTitleNavBar.title = critics[indexPath.row].displayName
        vc?.descriptionLabel.text = critics[indexPath.row].bio
        critics[indexPath.row].getImage { (image) in
            vc?.criticImageView.image = image
        }
    }
}

extension CriticModuleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempCritics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CriticsCollectionViewCell.identifier, for: indexPath) as! CriticsCollectionViewCell
        cell.configureCell(results: tempCritics, for: indexPath)
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
        let indexLast = tempCritics.count - 1
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if (contentYoffset > 0 && distanceFromBottom < height) && tempCritics.count < critics.count {
            for _ in 0...limit {
                if indexLast + 1 < critics.count - 1 {
                    tempCritics.append(critics[index])
                    index += 1
                    criticsCollectionView.reloadData()
                }
            }
        }
        if (contentYoffset < 0) {
            updateCritics()
        }
    }
}

extension CriticModuleViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchCriticLabel {
            textField.resignFirstResponder()
            updateCritics()
        }
        return true
    }
}

extension CriticModuleViewController: CriticModuleViewInput {
    func onCriticsGet(results: Critic) {
        critics = results.results
        while index < limit {
            tempCritics.append(critics[index])
            index += 1
        }
        self.criticsCollectionView.reloadData()
    }
    
    func setupState() {
        criticsCollectionView.delegate = self
        criticsCollectionView.dataSource = self
        searchCriticLabel.delegate = self
        
        let tableRefreshControl = UIRefreshControl()
        tableRefreshControl.addTarget(self, action: #selector(updateRefresh(_:)), for: .valueChanged)
        criticsCollectionView.refreshControl = tableRefreshControl
        
        criticsCollectionView.refreshControl = tableRefreshControl
    }
}
