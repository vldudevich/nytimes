//
//  ViewController.swift
//  NyTimes
//
//  Created by vladislav on 18.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class MainModuleViewController: UIViewController {

    enum TabIndex : Int {
        case reviewsViewControllerTab = 0
        case criticsViewControllerTab = 1
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var myToolBar: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var myNavigationItem: UINavigationItem!
    
    var output: MainModuleViewOutput!
    
    private var currentViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        output.setupInitialState()
    }

    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        self.currentViewController?.willMove(toParent: nil)
        self.currentViewController?.view.removeFromSuperview()
        self.currentViewController?.removeFromParent()
        
        guard let selectedIndex = MainModuleViewController.TabIndex(rawValue: sender.selectedSegmentIndex) else {return}
        output.choseControllerForSelectedSegmentIndex(with: selectedIndex)
        
    }
    
    private func applyReviewStyle() {
        
        myNavigationItem.title = "Reviews"
        self.navigationController?.navigationBar.barTintColor = .lightOrange
        myToolBar.backgroundColor = .lightOrange
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.shadowImage = UIImage()
        segmentControl.backgroundColor = .lightOrange
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightOrange], for: .selected)
    }
    
    private func applyCriticsStyle() {
        
        myNavigationItem.title = "Critics"
        self.navigationController?.navigationBar.barTintColor = .lightBlue
        self.navigationController?.navigationBar.shadowImage = UIImage()
        myToolBar.backgroundColor = .lightBlue
        segmentControl.backgroundColor = .lightBlue
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightBlue], for: .selected)
    }
    
}

extension MainModuleViewController: MainModuleViewInput {
    
    func setupState() {
         segmentControl.selectedSegmentIndex = TabIndex.reviewsViewControllerTab.rawValue
    }
    
    func updateController(for segmentedIndex: MainModuleViewController.TabIndex, viewController: UIViewController) {
        
        switch segmentedIndex {
        case .reviewsViewControllerTab:
            applyReviewStyle()
        case .criticsViewControllerTab:
            applyCriticsStyle()
        }
        
        self.addChild(viewController)
        self.contentView.addSubview(viewController.view)
        viewController.view.fillToSuperview()
        viewController.didMove(toParent: self)
        self.currentViewController = viewController
    }

}
