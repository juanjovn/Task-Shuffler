//
//  ShuffleVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 28/12/20.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit
import AMTabView

class ShuffleVC: AMTabsViewController {
    let shuffleView = ShuffleView()
    lazy var shuffleSegmentedControllersDataSource = ShuffleSegmentedControllersDataSource(shuffleView: shuffleView)
    var shuffleSlider = MTSlideToOpenView(frame: CGRect(x: 26, y: 200, width: 317, height: 56))
    var shuffleImageRotation = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupShuffleView()
        setupNavigationBar()
        setupShuffleSlider()
        setupShuffleButton()
        shuffleView.howSegmentedControl.dataSource = shuffleSegmentedControllersDataSource
        shuffleView.whenSegmentedControl.dataSource = shuffleSegmentedControllersDataSource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupViewsCornerRadius()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        shuffleView.shuffleButton.fitLayers()
    }
    
    private func setupShuffleView() {
        view.addSubview(shuffleView)
        
        shuffleView.translatesAutoresizingMaskIntoConstraints = false
        shuffleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        shuffleView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        shuffleView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        shuffleView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Shuffle"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear"), style: .plain, target: self, action: #selector(settingsButtonAction))
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupShuffleSlider() {
        shuffleSlider.sliderViewTopDistance = 0
        shuffleSlider.sliderCornerRadius = shuffleSlider.bounds.size.height / 2
        shuffleSlider.thumbnailImageView.backgroundColor  = .fireOrange
        shuffleSlider.draggedView.backgroundColor = .fireOrange
        shuffleSlider.delegate = self
        shuffleSlider.thumbnailViewStartingDistance = 15
        shuffleSlider.labelText = "Slide to shuffle"
        shuffleSlider.thumbnailImageView.image = UIImage(systemName: "shuffle")?.tinted(color: .pearlWhite)
        shuffleSlider.sliderBackgroundColor = UIColor.mysticBlue.withAlphaComponent(0.3)
        shuffleSlider.textColor = .pearlWhite
        
        shuffleView.addSubview(shuffleSlider)
        
        shuffleSlider.translatesAutoresizingMaskIntoConstraints = false
        shuffleSlider.heightAnchor.constraint(equalTo: shuffleView.heightAnchor, multiplier: 0.09).isActive = true
        shuffleSlider.leadingAnchor.constraint(equalTo: shuffleView.leadingAnchor, constant: 30).isActive = true
        shuffleSlider.trailingAnchor.constraint(equalTo: shuffleView.trailingAnchor, constant: -30).isActive = true
        shuffleSlider.bottomAnchor.constraint(equalTo: shuffleView.bottomAnchor, constant: -120).isActive = true
    }
    
    private func setupShuffleButton() {
        shuffleView.shuffleButton.centerYAnchor.constraint(equalTo: shuffleSlider.centerYAnchor).isActive = true
        shuffleView.shuffleButton.trailingAnchor.constraint(equalTo: shuffleSlider.trailingAnchor, constant: -10).isActive = true
        shuffleView.bringSubviewToFront(shuffleView.shuffleButton)
        shuffleView.shuffleButton.layoutIfNeeded()
    }
    
    private func setupViewsCornerRadius() {
        shuffleSlider.sliderCornerRadius = shuffleSlider.bounds.size.height / 2
        shuffleView.shuffleButton.layer.cornerRadius =  shuffleView.shuffleButton.bounds.size.width / 2
        shuffleView.howSegmentedControl.layer.cornerRadius = shuffleView.howSegmentedControl.bounds.size.height / 2
        shuffleView.whenSegmentedControl.layer.cornerRadius = shuffleView.howSegmentedControl.bounds.size.height / 2
    }
    
    @objc func settingsButtonAction() {
        present(UINavigationController(rootViewController: SettingsVC()), animated: true)
    }
}

extension ShuffleVC: TabItem{
    
    var tabImage: UIImage? {
        let symbolConfiguration = UIImage.SymbolConfiguration(weight: .regular)
        return UIImage(systemName: "shuffle.circle", withConfiguration: symbolConfiguration)
    }
    
}


// MARK: MTSlideToOpenDelegate
extension ShuffleVC: MTSlideToOpenDelegate {
    func mtSlideToOpenDelegateDidFinish(_ sender: MTSlideToOpenView) {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        if SettingsValues.otherSettings[0] {
            generator.impactOccurred()
        }
        shuffleView.shuffleButton.setClicked(true)
        _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
            self.shuffleView.shuffleButton.setClicked(false)
        }
        //        let alertController = UIAlertController(title: "", message: "Shuffled!", preferredStyle: .alert)
        //        let doneAction = UIAlertAction(title: "OK", style: .default) { (action) in
        sender.resetStateWithAnimation(true)
        
        //        }
        //        alertController.addAction(doneAction)
        //        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func mtSlideToOpenDelegateDidIncrease(_ sender: MTSlideToOpenView, _ translatedPoint: Int ) {
        //print("ROTATION APPLIED to the RIGHT >>>>>>> \(translatedPoint)")
        shuffleImageRotation = atan2(shuffleView.shuffleBackImageView.transform.b, shuffleView.shuffleBackImageView.transform.a)
        UIView.animate(withDuration: 0.05) {
            self.shuffleView.shuffleBackImageView.transform = CGAffineTransform(rotationAngle: self.shuffleImageRotation + ((20 * CGFloat.pi) / 180))
        }
    }
    
    func mtSlideToOpenDelegateDidDecrease(_ sender: MTSlideToOpenView, _ translatedPoint: Int ) {
        //print("ROTATION APPLIED to the LEFT <<<<<<< \(translatedPoint)")
        shuffleImageRotation = atan2(shuffleView.shuffleBackImageView.transform.b, shuffleView.shuffleBackImageView.transform.a)
        UIView.animate(withDuration: 0.05) {
            self.shuffleView.shuffleBackImageView.transform = CGAffineTransform(rotationAngle: self.shuffleImageRotation - ((20 * CGFloat.pi) / 180))
        }
    }
    
    func mtSlideToOpenDelegateDidTouchUp(_ sender: MTSlideToOpenView, _ translatedPoint: Int ) {
        UIView.animate(withDuration: 0.3) {
            self.shuffleView.shuffleBackImageView.transform = CGAffineTransform.identity
        }
    }
    
}



