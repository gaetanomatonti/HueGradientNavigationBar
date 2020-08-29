//
//  ViewController.swift
//  GradientNavigationBar
//
//  Created by Gaetano Matonti on 29/08/2020.
//

import UIKit

class ViewController: UIViewController {

    let colors: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemBlue, .systemPurple]
    
    let titleView: HueNavigationBarTitleView = {
        HueNavigationBarTitleView()
    }()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.addGradient(colors: colors)
        titleView.frame = navigationBar.frame
    }
    
    func setupNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        navigationItem.titleView = titleView
        
        let slider = HueSlider()
        slider.colors = colors
        navigationBar.addSubview(slider)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            slider.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
            slider.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

}

