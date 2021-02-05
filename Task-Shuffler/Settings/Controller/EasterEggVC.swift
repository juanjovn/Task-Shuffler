//
//  EasterEggVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 4/2/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit
import SwiftyGif
import Network
import StoreKit

class EasterEggVC: UIViewController {
    
    let modalView = EasterEggModalView()
    var gifImageView = UIImageView()
    let monitor = NWPathMonitor()
    var existsInternet = false
    let gifUrl = "https://cataas.com/cat/gif" //Random cat gif
    lazy var message = UILabel()
    private let reviewManager = ReviewManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCancelButton()
        setupInternetMonitor()
        fetchGif()
        setupGifView()
        
    }
    
    private func setupView() {
        view = modalView
        
    }
    
    private func setupCancelButton() {
        modalView.cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
    }
    
    //Check the connection to present a gif from the API or the one gif in the bundle
    private func setupInternetMonitor() {
        
        monitor.pathUpdateHandler = {[unowned self] path in
            if path.status == .satisfied {
                self.existsInternet = true
                print ("CONEXION ON ❇️ DETECTADA")
            } else {
                self.existsInternet = false
                print ("CONEXION OFF 🔴 DETECTADA")
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
    }
    
    @objc private func cancelButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupGifView() {
        modalView.bottomView.addSubview(gifImageView)
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        gifImageView.centerYAnchor.constraint(equalTo: modalView.bottomView.centerYAnchor).isActive = true
        gifImageView.centerXAnchor.constraint(equalTo: modalView.bottomView.centerXAnchor).isActive = true
        gifImageView.heightAnchor.constraint(lessThanOrEqualTo: modalView.bottomView.heightAnchor, multiplier: 0.8).isActive = true
        gifImageView.widthAnchor.constraint(lessThanOrEqualTo: modalView.bottomView.widthAnchor, multiplier: 0.8).isActive = true
        gifImageView.contentMode = .scaleAspectFit
    }
    
    private func fetchGif() {
        
        let configuration = URLSessionConfiguration.default
        //Needed to ensure a new gif every time the VC is opened. Otherwise sometimes cache a gif and it is always displayed the same gif.
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        guard let url = URL(string: gifUrl) else {
            setupErrorMessageLabel()
            message.text = "Error getting gif provider"
            return
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .pearlWhite
        let loader = activityIndicator
        let manager = SwiftyGifManager.init(memoryLimit: 20)
        
        if existsInternet {
            gifImageView.setGifFromURL(url, manager: manager, loopCount: -1, levelOfIntegrity: .default, session: .init(configuration: configuration), showLoader: true, customLoader: loader)
            //Count easter egg opened successfully for review request purposes
            reviewManager.log(.easter)
            
            
        } else {
            //Show the gif file from the bundle
            let name = "cat_loading"
            gifImageView = UIImageView.fromGif(frame: CGRect.zero, resourceName: name)!
            gifImageView.startAnimating()
            setupErrorMessageLabel()
        }
        
        
    }
    
    private func setupErrorMessageLabel() {
        message.text = "No internet. Get a connection to watch us!"
        message.font = .avenirDemiBold(ofSize: UIFont.scaleFont(20))
        message.textColor = .fireOrange
        message.numberOfLines = 0
        message.textAlignment = .center
        
        modalView.bottomView.addSubview(message)
        //LAYOUT
        message.translatesAutoresizingMaskIntoConstraints = false
        message.bottomAnchor.constraint(equalTo: modalView.bottomView.bottomAnchor, constant: -10).isActive = true
        message.leadingAnchor.constraint(equalTo: modalView.bottomView.leadingAnchor, constant: 10).isActive = true
        message.trailingAnchor.constraint(equalTo: modalView.bottomView.trailingAnchor, constant: -10).isActive = true
        message.centerXAnchor.constraint(equalTo: modalView.bottomView.centerXAnchor).isActive = true
        
    }
    
    private func checkLaunchReviewRequest() {
        print("CURRENT EASTER COUNT: \(reviewManager.count(of: .easter))")
        if reviewManager.count(of: .easter) == 10 {
            SKStoreReviewController.requestReview()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        checkLaunchReviewRequest()
    }
    
    
    deinit {
        //Turns off the monitor to not keep tracking the connection status in background and deallocate the VC
        monitor.cancel()
        //print("DEALLOCATED 🙀")
        
    }
    
}
