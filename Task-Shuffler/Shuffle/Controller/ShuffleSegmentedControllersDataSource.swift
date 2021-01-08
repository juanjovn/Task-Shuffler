//
//  ShuffleSegmentedControllersDataSource.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 2/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import Foundation
import SJFluidSegmentedControl
class ShuffleSegmentedControllersDataSource: SJFluidSegmentedControlDataSource {
    let shuffleView: ShuffleView
    init(shuffleView: ShuffleView) {
        self.shuffleView = shuffleView
    }
    
    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
        switch segmentedControl {
        case shuffleView.howSegmentedControl:
            return ShuffleModes.howModes.count
        case shuffleView.whenSegmentedControl:
            return ShuffleModes.whenModes.count
        default:
            return 3
        }
        
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, titleForSegmentAtIndex index: Int) -> String? {
        switch segmentedControl {
        case shuffleView.howSegmentedControl:
                return ShuffleModes.howModes[index]
        case shuffleView.whenSegmentedControl:
                return ShuffleModes.whenModes[index]
        default:
            return "How to shuffle"
        }
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, gradientColorsForSelectedSegmentAtIndex index: Int) -> [UIColor] {
        switch index {
        case 0:
            return [UIColor.fireOrange]
        case 1:
            return [UIColor.mysticBlue]
        case 2:
            return [UIColor.forestGreen]
        case 3:
            return [UIColor.darkOrange]
        default:
            return [UIColor.fireOrange]
        }
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          gradientColorsForBounce bounce: SJFluidSegmentedControlBounce) -> [UIColor] {
        switch bounce {
        case .left:
            return [UIColor(red: 51 / 255.0, green: 149 / 255.0, blue: 182 / 255.0, alpha: 1.0)]
        case .right:
            return [UIColor(red: 9 / 255.0, green: 82 / 255.0, blue: 107 / 255.0, alpha: 1.0)]
        }
    }
    
}
