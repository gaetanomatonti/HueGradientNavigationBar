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
    
    var value: CGFloat = 0 {
        willSet {
            delegate?.hueSlider(valueDidChangeTo: Double(newValue))
            setNeedsLayout()
        }
    }
    
    private var totalScaledValue: CGFloat {
        bounds.width * value
    }
        
    private var trackInsets: UIEdgeInsets {
        UIEdgeInsets(top: 0, left: sliderRadius, bottom: 0, right: sliderRadius)
    }
    
    private var trackWidth: CGFloat {
        bounds.inset(by: trackInsets).width
    }
    
    private var filledTrackMaskPath: UIBezierPath {
        UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .bottomLeft],
            cornerRadii: CGSize(width: sliderRadius, height: sliderRadius)
        )
    }
    
    private var sliderRadius: CGFloat {
        frame.height / 2
    }
    
    private var filledTrackColors: [UIColor] {
        [UIColor.white.withAlphaComponent(0.1), UIColor.white.withAlphaComponent(0.9)]
    }
    
    private lazy var sliderTrack: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let view = UIVisualEffectView(effect: effect)
        view.layer.cornerRadius = sliderRadius
        view.clipsToBounds = true
        view.alpha = 0.5
        return view
    }()
    
    private lazy var filledTrack: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = sliderRadius
        return view
    }()
    
    private lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
    
    private lazy var handle: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addGestureRecognizer(panGesture)
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: -1, height: 2)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(sliderTrack)
        addSubview(filledTrack)
        addSubview(handle)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sliderTrack.frame = bounds
        sliderTrack.layer.cornerRadius = sliderRadius
        
        handle.frame.size = CGSize(width: sliderRadius * 2, height: sliderRadius * 2)
        handle.layer.cornerRadius = sliderRadius

        filledTrack.frame.size.height = sliderRadius * 2
        filledTrack.frame.size.width = handle.center.x
        
        updateFilledGradient()
    }
    
    private func updateValue(from point: CGPoint) {
        guard bounds.inset(by: trackInsets).contains(point) else { return }
        handle.center.x = point.x
        value = point.x / bounds.inset(by: trackInsets).maxX
    }
    
    private func updateFilledGradient() {
        if let sublayers = filledTrack.layer.sublayers {
            if sublayers.contains(where: { $0 is CAGradientLayer }) {
                filledTrack.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
            }
            filledTrack.layer.insertSublayer(createFilledTrackGradient(), at: 0)
        } else {
            filledTrack.layer.insertSublayer(createFilledTrackGradient(), at: 0)
        }
    }
    
    private func createFilledTrackGradient() -> CAGradientLayer {
        let gradient = filledTrack.createGradient(colors: filledTrackColors)
        let maskLayer = CAShapeLayer()
        maskLayer.path = filledTrackMaskPath.cgPath
        gradient.mask = maskLayer
        return gradient
    }
    
    private var initialHandleCenter: CGPoint = .zero
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let handle = gesture.view else { return }
        
        let translation = gesture.translation(in: handle.superview)

        switch gesture.state {
            case .began:
                initialHandleCenter = handle.center
            case .changed:
                let newCenter = CGPoint(x: initialHandleCenter.x + translation.x, y: initialHandleCenter.y)
                updateValue(from: newCenter)
            default:
                break
        }
    }
    
}
