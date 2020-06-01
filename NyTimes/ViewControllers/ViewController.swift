//
//  ViewController.swift
//  NyTimes
//
//  Created by vladislav on 18.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum TabIndex : Int {
        case reviewsViewControllerTab = 0
        case criticsViewControllerTab = 1
    }
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var myToolBar: UIToolbar!
    @IBOutlet weak var myNavigationItem: UINavigationItem!
    
    let lightBlue = UIColor(red: 78/255, green: 103/255, blue: 255/255, alpha: 1)
    
    var currentViewController: UIViewController?
    
    lazy var reviewsViewController: UIViewController? = {
        let reviewsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ReviewsViewControllerId")
        return reviewsViewController
    }()
        lazy var criticsViewController: UIViewController? = {
        let criticsViewController = self.storyboard?.instantiateViewController(withIdentifier: "CriticsViewControllerId")
        return criticsViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.selectedSegmentIndex = TabIndex.reviewsViewControllerTab.rawValue
        displayCurrentTab(segmentControl.selectedSegmentIndex)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        self.currentViewController?.willMove(toParent: nil)
        self.currentViewController?.view.removeFromSuperview()
        self.currentViewController?.removeFromParent()
        
        displayCurrentTab(sender.selectedSegmentIndex)

    }
    func displayCurrentTab(_ tabIndex: Int){
        if let currentViewController = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChild(currentViewController)
            self.contentView.addSubview(currentViewController.view)
            currentViewController.view.fillToSuperview()
            currentViewController.didMove(toParent: self)


            self.currentViewController = currentViewController
            
        }
    }
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var currentViewController: UIViewController?
        switch index {
        case TabIndex.reviewsViewControllerTab.rawValue :
            currentViewController = reviewsViewController
            reviewStyle()
        case TabIndex.criticsViewControllerTab.rawValue :
            currentViewController = criticsViewController
            criticsStyle()
        default:
        return nil
        }
    
        return currentViewController
        
    }
    
    func reviewStyle() {
        myNavigationItem.title = "Reviews"
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.shadowImage = UIImage()
        myToolBar.barTintColor = UIColor.orange
        segmentControl.backgroundColor = UIColor.orange
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], for: .selected)
        
    }
    
    func criticsStyle() {
        myNavigationItem.title = "Critics"

        self.navigationController?.navigationBar.barTintColor = lightBlue
        myToolBar.barTintColor = lightBlue
        segmentControl.backgroundColor = lightBlue
        self.navigationController?.navigationBar.shadowImage = UIImage()
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: lightBlue], for: .selected)
        
    }
}


