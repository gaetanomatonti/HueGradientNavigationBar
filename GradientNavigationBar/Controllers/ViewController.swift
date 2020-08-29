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
    
    lazy var navigationBarFooter: HueNavigationBarFooter = {
        let footer = HueNavigationBarFooter()
        footer.colors = colors
        footer.insets = navigationFooterInsets
        footer.sliderDelegate = self
        footer.translatesAutoresizingMaskIntoConstraints = false
        return footer
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
        
        view.backgroundColor = .secondarySystemBackground
        
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
        
        view.addSubview(navigationBarFooter)
        
        NSLayoutConstraint.activate([
            navigationBarFooter.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBarFooter.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBarFooter.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBarFooter.heightAnchor.constraint(equalToConstant: navigationFooterHeight)
        ])
        
        updateTitle(with: Double(navigationBarFooter.slider.value))
    }
    
    func updateTitle(with value: Double) {
        let value = Int((value * 100).rounded())
        titleView.text = "\(value)%"
    }

}

extension ViewController: HueSliderDelegate {
    
    func hueSlider(valueDidChangeTo value: Double) {
        updateTitle(with: value)
    }
    
}
