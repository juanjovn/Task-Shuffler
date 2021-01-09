//
//  ShuffleSegmentedControllersDelegate.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 4/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import SJFluidSegmentedControl
import UIKit

class ShuffleSegmentedControllersDelegate: SJFluidSegmentedControlDelegate {
    let shuffleView: ShuffleView
    var shuffleVC: ShuffleVC?
    
    init(shuffleView: ShuffleView, shuffleController: ShuffleVC?) {
        self.shuffleView = shuffleView
        if let shuffleController = shuffleController {
            self.shuffleVC = shuffleController
        }
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didChangeFromSegmentAtIndex fromIndex: Int, toSegmentAtIndex toIndex: Int) {
        guard let shuffleVC = shuffleVC else {
            print ("Cannot obatin instance of ShuffleVC")
            return
        }
        
        if fromIndex == 3 && segmentedControl == shuffleView.whenSegmentedControl {
            shuffleVC.shuffleView.disableHowView.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.2) {
                shuffleVC.shuffleView.disableHowView.backgroundColor = .clear
            }
        }
        
        switch segmentedControl {
        case shuffleView.howSegmentedControl:
            switch toIndex {
            case 0:
                shuffleVC.shuffleConfiguration.how = .Smart
            case 1:
                shuffleVC.shuffleConfiguration.how = .Random
            case 2:
                shuffleVC.shuffleConfiguration.how = .Single
            default:
                shuffleVC.shuffleConfiguration.how = .Smart
            }
        case shuffleView.whenSegmentedControl:
            switch toIndex {
            case 0:
                shuffleVC.shuffleConfiguration.when = .All
            case 1:
                shuffleVC.shuffleConfiguration.when = .This
            case 2:
                shuffleVC.shuffleConfiguration.when = .Next
            case 3:
                shuffleVC.shuffleConfiguration.when = .Now
                shuffleVC.shuffleView.howSegmentedControl.setCurrentSegmentIndex(1, animated: true)
                shuffleVC.shuffleView.disableHowView.isUserInteractionEnabled = true
                UIView.animate(withDuration: 0.2) {
                    shuffleVC.shuffleView.disableHowView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
                }
            default:
                shuffleVC.shuffleConfiguration.when = .All
            }
        default:
            break
        }
    }
}
