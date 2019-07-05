//
//  InfiniteContainerView.swift
//  InfiniteContainerView
//
//  Created by Vlados iOS on 7/5/19.
//  Copyright © 2019 Vladislav Shilov. All rights reserved.
//

import UIKit

protocol IInfiniteContainerView: UIView {
    var cornerRadius: CGFloat { get set }
    
    var childViewHeight: CGFloat { get set }
    
    var showSeparator: Bool { get set }
    var separatorLeftInset: CGFloat { get set }
    var separatorRightInset: CGFloat { get set }
    var separatorColor: UIColor { get set }
    var separatorHeight: CGFloat { get set }
    
    func addChildView(_ view: UIView)
    func removeChildView(_ view: UIView?)
    func removeLastChild()
}

@IBDesignable
open class InfiniteContainerView: UIControl, IInfiniteContainerView {
    // MARK: - Properties
    // MARK: UIView
    override open var intrinsicContentSize: CGSize {
        let height = getHeightFactor()
        return CGSize(width: bounds.width, height: CGFloat(height))
    }
    
    // MARK: Layer
    @IBInspectable public var cornerRadius: CGFloat = 28 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: Views height
    @IBInspectable public var childViewHeight: CGFloat = 56
    
    // MARK: Separator
    @IBInspectable public var showSeparator: Bool = true
    @IBInspectable public var separatorLeftInset: CGFloat = 0
    @IBInspectable public var separatorRightInset: CGFloat = 0
    @IBInspectable public var separatorColor: UIColor = .lightGray
    @IBInspectable public var separatorHeight: CGFloat = 1
    
    private var childs = [UIView]()
    private var separators = [UIView]()
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaults()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDefaults()
    }
    
    private func setupDefaults() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(recognizer:)))
        addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Lifecycle
    override open func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        childs.forEach { (view) in
            let yPosition = view.frame.origin.y
            view.frame = CGRect(x: 0, y: yPosition, width: bounds.width, height: childViewHeight)
        }
    }
    
    // MARK: - IInfiniteContainerView
    public func addChildView(_ view: UIView) {
        let yPosition = getHeightFactor()
        view.frame = CGRect(x: 0, y: yPosition, width: bounds.width, height: childViewHeight)
        addSubview(view)
        childs.append(view)
        
        if showSeparator, childs.count > 1 {
            addSeparator(to: yPosition - separatorHeight)
        }
        
        invalidateIntrinsicContentSize()
        layoutSubviews()
    }
    
    public func removeChildView(_ view: UIView?) {
        if let view = view, let index = childs.firstIndex(of: view) {
            childs.remove(at: index)
            view.removeFromSuperview()
            removeSeparator()
            invalidateIntrinsicContentSize()
            
            moveViewsToTop()
        }
    }
    
    public func removeLastChild() {
        childs.removeLast().removeFromSuperview()
        removeSeparator()
        invalidateIntrinsicContentSize()
    }
    
    // MARK: - Support methods
    private func getHeightFactor() -> CGFloat {
        return getHeight() * CGFloat(childs.count)
    }
    
    private func getHeight() -> CGFloat {
        return showSeparator ? (childViewHeight + separatorHeight) : childViewHeight
    }
    
    private func moveViewsToTop() {
        childs.forEach { view in
            if view.frame.origin.y == 0 { return }
            let yPosition = view.frame.origin.y - getHeight()
            view.frame = CGRect(x: 0, y: yPosition, width: view.frame.width, height: view.frame.height)
        }
    }
    
    private func addSeparator(to position: CGFloat) {
        let width = self.frame.width - separatorLeftInset - separatorRightInset
        let frame = CGRect(x: separatorLeftInset, y: position, width: width, height: separatorHeight)
        let separator = UIView(frame: frame)
        separator.backgroundColor = separatorColor
        
        separators.append(separator)
        addSubview(separator)
    }
    
    private func removeSeparator() {
        if separators.last != nil {
            separators.last?.removeFromSuperview()
            separators.removeLast()
        }
    }
    
    // MARK: - Touch
    @objc private func handleTapGesture(recognizer: UITapGestureRecognizer) {
        sendActions(for: .valueChanged)
    }
}
