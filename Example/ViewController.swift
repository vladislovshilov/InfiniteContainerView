//
//  ViewController.swift
//  Example
//
//  Created by Vlados iOS on 7/5/19.
//  Copyright © 2019 Vladislav Shilov. All rights reserved.
//

import UIKit
import InfiniteContainerView

final class ViewController: UIViewController {
    // MARK: - IBOutlet's
    @IBOutlet private weak var infiniteContainerView: InfiniteContainerView!
    
    private var childViews = [UIView]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Configurations
    private func configureView() {
        infiniteContainerView.layer.cornerRadius = 25
        infiniteContainerView.layer.shadowColor = UIColor.lightGray.cgColor
        infiniteContainerView.layer.shadowOpacity = 0.3
        infiniteContainerView.layer.shadowRadius = 5
    }
    
    // MARK: - Support methods
    private func createChildView() {
        let view = CustomView()
        view.reload(titleText: "View", descriptionText: "\(childViews.count + 1)")
        
        childViews.append(view)
        infiniteContainerView.addChildView(view)
    }
    
    private func removeChildView() {
        childViews.removeLast()
        infiniteContainerView.removeLastChild()
    }

    // MARK: - IBAction's
    @IBAction private func addButtonDidPress(_ sender: Any) {
        createChildView()
    }
    
    @IBAction private func infiniteContainerViewDidPress(_ sender: UIView) {
        removeChildView()
    }
}

