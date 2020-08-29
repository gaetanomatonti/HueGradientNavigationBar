//
//  UINavigationBar.swift
//  GradientNavigationBar
//
//  Created by Gaetano Matonti on 29/08/2020.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    func addGradient(colors: [UIColor], locations: [Double]? = nil, startPoint: CGPoint = CGPoint(x: 0, y: 0.5), endPoint: CGPoint = CGPoint(x: 1, y: 0.5)) {
        let gradientLayer = createGradient(
            colors: colors,
            locations: locations,
            startPoint: startPoint,
            endPoint: endPoint
        )
        guard let image = createImage(from: gradientLayer) else { return }
        
        barTintColor = UIColor(patternImage: image)
    }

}
