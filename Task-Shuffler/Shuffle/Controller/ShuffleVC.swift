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
    var shuffleSlider = MTSlideToOpenView(frame: CGRect(x: 26, y: 200, width: 317, height: 56))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupShuffleView()
        setupNavigationBar()
        setupShuffleSlider()
        setupShuffleButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        shuffleSlider.sliderCornerRadius = shuffleSlider.bounds.size.height / 2
        shuffleView.shuffleButton.layer.cornerRadius =  shuffleView.shuffleButton.bounds.size.width/2
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        shuffleView.shuffleButton.fitLayers()
    }
    
    private func setupShuffleView() {
        view.addSubview(shuffleView)
        
        shuffleView.translatesAutoresizingMaskIntoConstraints = false
        shuffleView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        shuffleView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        shuffleView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        shuffleView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
        shuffleSlider.thumbnailViewStartingDistance = 10
        shuffleSlider.labelText = "Slide to shuffle"
        shuffleSlider.thumbnailImageView.image = UIImage(systemName: "shuffle")?.tinted(color: .pearlWhite)
        shuffleSlider.sliderBackgroundColor = UIColor.mysticBlue.withAlphaComponent(0.5)
        shuffleSlider.textColor = .pearlWhite
        
        shuffleView.addSubview(shuffleSlider)
        
        shuffleSlider.translatesAutoresizingMaskIntoConstraints = false
        shuffleSlider.heightAnchor.constraint(equalTo: shuffleView.heightAnchor, multiplier: 0.07).isActive = true
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
        let alertController = UIAlertController(title: "", message: "Shuffled!", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "OK", style: .default) { (action) in
            sender.resetStateWithAnimation(false)
            self.shuffleView.shuffleButton.setClicked(false)
        }
        alertController.addAction(doneAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}
