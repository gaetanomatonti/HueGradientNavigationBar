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
    
    private var sliderRadius: CGFloat {
        frame.height / 2
    }
    
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
        
        sliderTrack.frame = bounds
        sliderTrack.layer.cornerRadius = sliderRadius
    }
    
}
