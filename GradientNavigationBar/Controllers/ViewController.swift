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
    
    private var navigationFooterInsets: UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    private var navigationFooterHeight: CGFloat {
        sliderHeight + navigationFooterInsets.top + navigationFooterInsets.bottom
    }
    
    private var sliderHeight: CGFloat { 24 }
    
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
        
        let footer = HueNavigationBarFooter()
        footer.colors = colors
        footer.insets = navigationFooterInsets
        footer.translatesAutoresizingMaskIntoConstraints = false

        navigationBar.addSubview(footer)
        
        NSLayoutConstraint.activate([
            footer.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            footer.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            footer.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
            footer.heightAnchor.constraint(equalToConstant: navigationFooterHeight)
        ])
    }

}

