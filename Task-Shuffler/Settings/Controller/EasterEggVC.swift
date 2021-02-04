//
//  EasterEggVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 4/2/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit
import SwiftyGif

class EasterEggVC: UIViewController {

    let modalView = EasterEggModalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCancelButton()
        animateGif()
        
        
        
        
    }
    
    private func setupView() {
        view = modalView
        
    }
    
    private func setupCancelButton() {
        modalView.cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
    }
    
    @objc private func cancelButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    private func animateGif() {
//        var names = ["cat_loading", "cat"]
//        names.shuffle()
//        let name = names.first!
        
        //modalView.gifImageView = UIImageView.fromGif(frame: CGRect.zero, resourceName: name)!
        
        let url = URL(string: "https://cataas.com/cat/gif")!
        let loader = UIActivityIndicatorView(style: .white)
        modalView.gifImageView.setGifFromURL(url, customLoader: loader)
            
        
        modalView.bottomView.addSubview(modalView.gifImageView)
        modalView.gifImageView.translatesAutoresizingMaskIntoConstraints = false
        modalView.gifImageView.centerYAnchor.constraint(equalTo: modalView.bottomView.centerYAnchor).isActive = true
        modalView.gifImageView.centerXAnchor.constraint(equalTo: modalView.bottomView.centerXAnchor).isActive = true
        modalView.gifImageView.heightAnchor.constraint(lessThanOrEqualTo: modalView.bottomView.heightAnchor, multiplier: 0.8).isActive = true
        modalView.gifImageView.widthAnchor.constraint(lessThanOrEqualTo: modalView.bottomView.widthAnchor, multiplier: 0.8).isActive = true
        modalView.gifImageView.contentMode = .scaleAspectFit
        
        modalView.gifImageView.startAnimatingGif()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        print("EJECUTANDO CLEAR DE CACHE ❗️")
        modalView.gifImageView.stopAnimatingGif()
        SwiftyGifManager.defaultManager.deleteImageView(modalView.gifImageView)
        modalView.gifImageView.image = nil
        modalView.gifImageView.removeFromSuperview()
        print(SwiftyGifManager.defaultManager.hasCache(modalView.gifImageView))
    }
    
    deinit {
        print("DEALLOCATED 🙀")
        
    }
    
    
}
