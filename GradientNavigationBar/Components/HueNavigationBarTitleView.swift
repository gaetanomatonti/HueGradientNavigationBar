//
//  HueNavigationBarTitleView.swift
//  GradientNavigationBar
//
//  Created by Gaetano Matonti on 29/08/2020.
//

import Foundation
import UIKit

final class HueNavigationBarTitleView: UIView {
    
    var text: String? {
        willSet {
            titleLabel.text = newValue
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        addSubview(contentStack)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentStack.frame = bounds
    }
    
}
