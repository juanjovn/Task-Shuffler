//
//  OnboardingVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 28/2/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit
import PaperOnboarding

class OnboardingVC: UIViewController {

    let numberOfPages = 4
    let onboarding = PaperOnboarding()
    let startButton = RoundedModalActionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setupView()
        setupOnboarding()
        setupStartButton()
        
    }
    
    private func setupView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupOnboarding() {
        onboarding.dataSource = self
        onboarding.delegate = self
        
        //LAYOUT
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        onboarding.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        onboarding.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        onboarding.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        onboarding.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupStartButton() {
        view.addSubview(startButton)
        startButton.setTitle("START".localized(), for: .normal)
        startButton.setTitleColor(UIColor.paleSilver, for: .highlighted)
        startButton.alpha = 0
        
        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        //LAYOUT
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Utils.screenWidth / 4).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        startButton.heightAnchor.constraint(equalTo: startButton.widthAnchor, multiplier: 0.33).isActive = true
    }
    
    @objc private func startButtonAction() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        SettingsValues.firstTime["app"] = false
        SettingsValues.storeSettings()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
        
        
    }
    

}

extension OnboardingVC: PaperOnboardingDataSource, PaperOnboardingDelegate {
    func onboardingItemsCount() -> Int {
        numberOfPages
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        
        return [
             OnboardingItemInfo(informationImage: UIImage(named: "icon_alpha")!,
                                title: "Welcome to Task-Shuffler!".localized(),
                                description: "The app that will help you avoid the procrastination.".localized(),
                                        pageIcon: UIImage(named: "icon_alpha")!,
                                           color: UIColor.mysticBlue,
                                      titleColor: UIColor.pearlWhite,
                                descriptionColor: UIColor.pearlWhite,
                                titleFont: UIFont.avenirDemiBold(ofSize: 27),
                                 descriptionFont: UIFont.avenirDemiBold(ofSize: 16)),

            OnboardingItemInfo(informationImage: UIImage(named: "1")!,
                                            title: "Create tasks".localized(),
                                      description: "Write down all those tasks that you were postponing for months (or even years 🙃)".localized(),
                                         pageIcon: UIImage(named: "1")!,
                                            color: UIColor.fireOrange,
                                       titleColor: UIColor.pearlWhite,
                                 descriptionColor: UIColor.pearlWhite,
                                        titleFont: UIFont.avenirDemiBold(ofSize: 27),
                                  descriptionFont: UIFont.avenirDemiBold(ofSize: 16)),

            OnboardingItemInfo(informationImage: UIImage(named: "2")!,
                                         title: "Add spare time slots".localized(),
                                   description: "Guess when you are going to have time to do some tasks.".localized(),
                                      pageIcon: UIImage(named: "2")!,
                                         color: UIColor.paleSilver,
                                    titleColor: UIColor.mysticBlue,
                              descriptionColor: UIColor.mysticBlue,
                                     titleFont: UIFont.avenirDemiBold(ofSize: 27),
                               descriptionFont: UIFont.avenirDemiBold(ofSize: 16)),
            
            OnboardingItemInfo(informationImage: UIImage(named: "3")!,
                                         title: "Shuffle!".localized(),
                                   description: "Tasks will be automatic assigned to your time slots. You can choose different modes to achieve it. Try them all and figure it out which fit you the best.".localized(),
                                      pageIcon: UIImage(named: "3")!,
                                         color: UIColor.mysticBlue,
                                    titleColor: UIColor.fireOrange,
                              descriptionColor: UIColor.pearlWhite,
                                     titleFont: UIFont.avenirDemiBold(ofSize: 33),
                               descriptionFont: UIFont.avenirDemiBold(ofSize: 16))
             ][index]
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        item.descriptionLabel?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        item.descriptionLabel?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == numberOfPages - 1 {
            startButton.alpha = 1
        } else {
            startButton.alpha = 0
        }
    }
    
}
