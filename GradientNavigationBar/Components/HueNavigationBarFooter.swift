//
//  HueNavigationBarFooter.swift
//  GradientNavigationBar
//
//  Created by Gaetano Matonti on 29/08/2020.
//

import Foundation
import UIKit

final class HueNavigationBarFooter: UIView {
    
    weak var sliderDelegate: HueSliderDelegate?
    
    var colors: [UIColor] = [] {
        willSet {
            guard !newValue.isEmpty else { return }
            updateGradient()
        }
    }
    
    var insets: UIEdgeInsets = .zero {
        willSet {
            setNeedsLayout()
        }
    }
    
    private var radius: CGFloat {
        (frame.height - insets.top - insets.bottom) / 2
    }

    private var maskPath: UIBezierPath {
        UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
    }
    
    lazy var maskLayer: CAShapeLayer = {
        let mask = CAShapeLayer()
        mask.path = maskPath.cgPath
        return mask
    }()
    
    lazy var slider: HueSlider = {
        let slider = HueSlider()
        slider.delegate = sliderDelegate
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        slider.frame = bounds.inset(by: insets)
        addSubview(slider)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        maskLayer.path = maskPath.cgPath
        slider.frame = bounds.inset(by: insets)
        updateGradient()
    }
    
    func updateGradient() {
        if let sublayers = layer.sublayers {
            if sublayers.contains(where: { $0 is CAGradientLayer }) {
                layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
            }
            layer.insertSublayer(createMaskedGradient(), at: 0)
        } else {
            layer.insertSublayer(createMaskedGradient(), at: 0)
        }
    }
    
    func createMaskedGradient() -> CAGradientLayer {
        let gradient = createGradient(colors: colors)
        gradient.mask = maskLayer
        return gradient
    }
    
}
