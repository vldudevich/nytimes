//
//  CriticsViewController.swift
//  NyTimes
//
//  Created by vladislav on 20.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class CriticModuleViewController: UIViewController {

    @IBOutlet private weak var searchCriticLabel: UITextField!
    @IBOutlet private weak var criticsCollectionView: UICollectionView!
    
    private var critics = [Critics]()
    private var tempCritics = [Critics]()
    
    private var limit = 8

    var output: CriticModuleViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCritics()
    }
    
    private func clearTable() {
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
    
    func sendData(for critic: Critics) {
        
        let vc = UIStoryboard(name: "DetailReviewModuleViewController", bundle: nil).instantiateInitialViewController()! as? DetailReviewModuleViewController
        self.present(vc!, animated: true, completion: nil)
        
        vc?.criticNameLabel.text = critic.displayName
        vc?.descriptionButton.setTitle(critic.status,for: .normal)
        vc?.detailTitleNavBar.title = critic.displayName
        vc?.descriptionLabel.text = critic.bio
        critic.getImage { (image) in
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
        cell.configureCell(results: tempCritics[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2 , height: collectionView.frame.size.width / 2 )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sendData(for: critics[indexPath.row])
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if (contentYoffset > 0 && distanceFromBottom < height) && tempCritics.count < critics.count {
            
            if tempCritics.count < critics.count - 1 {
                if tempCritics.count < critics.count {
                    limit = tempCritics.count + 4
                    if limit > critics.count - 1 {
                        limit = critics.count
                    }
                    tempCritics.append(contentsOf: critics[tempCritics.count..<limit])
                    criticsCollectionView.reloadData()
                }
            }
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
        tempCritics.append(contentsOf: critics[0..<limit])
        criticsCollectionView.reloadData()
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
