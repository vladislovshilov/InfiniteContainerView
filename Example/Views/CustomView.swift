//
//  CustomView.swift
//  Example
//
//  Created by Vlados iOS on 7/5/19.
//  Copyright © 2019 Vladislav Shilov. All rights reserved.
//

import UIKit

final class CustomView: UIView {
    // MARK: - IBOutlet's
    @IBOutlet var view: UIView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CustomView", owner: self)
        addSubview(view)
        view.frame = bounds
    }
    
    // MARK: - Configuration
    func reload(titleText: String, descriptionText: String) {
        titleLabel.text = titleText
        descriptionLabel.text = descriptionText
    }
}
