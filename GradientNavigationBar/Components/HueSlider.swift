//
//  HueSlider.swift
//  GradientNavigationBar
//
//  Created by Gaetano Matonti on 29/08/2020.
//

import Foundation
import UIKit

protocol HueSliderDelegate: class {
    func hueSlider(valueDidChangeTo value: Double)
}

final class HueSlider: UIView {
    
    weak var delegate: HueSliderDelegate?
    
    var sliderRadius: CGFloat = 6 {
        willSet {
            maskLayer.path = maskPath.cgPath
            sliderTrack.layer.cornerRadius = newValue
        }
    }
    
    var colors: [UIColor] = [] {
        willSet {
            guard !newValue.isEmpty else { return }
            updateGradient()
        }
    }
    
    private var maskPath: UIBezierPath {
        UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: sliderRadius, height: sliderRadius)
        )
    }
    
    lazy var maskLayer: CAShapeLayer = {
        let mask = CAShapeLayer()
        mask.path = maskPath.cgPath
        return mask
    }()
        
    lazy var sliderTrack: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let view = UIVisualEffectView(effect: effect)
        view.layer.cornerRadius = sliderRadius
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        sliderTrack.frame = bounds
        addSubview(sliderTrack)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sliderRadius = frame.height / 2
        sliderTrack.frame = bounds
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
