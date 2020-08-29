//
//  UIView.swift
//  GradientNavigationBar
//
//  Created by Gaetano Matonti on 29/08/2020.
//

import Foundation
import UIKit

extension UIView {
        
    func createGradient(colors: [UIColor], locations: [Double]? = nil, startPoint: CGPoint = CGPoint(x: 0, y: 0.5), endPoint: CGPoint = CGPoint(x: 1, y: 0.5)) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations as [NSNumber]?
        gradient.frame = bounds
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        return gradient
    }
    
    func createImage(from layer: CALayer) -> UIImage? {
        UIGraphicsBeginImageContext(layer.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil}
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()?
            .resizableImage(withCapInsets: .zero, resizingMode: .stretch)
        UIGraphicsEndImageContext()
        return image
    }
    
}
