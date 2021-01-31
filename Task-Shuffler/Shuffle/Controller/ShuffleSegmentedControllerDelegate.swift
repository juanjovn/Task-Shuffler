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
    lazy var shuffleMessageLabel = shuffleView.shuffleMessageLabel
    var shuffleConf = ShuffleConfiguration(how: .Smart, when: .All)
    
    init(shuffleView: ShuffleView, shuffleController: ShuffleVC?) {
        self.shuffleView = shuffleView
        if let shuffleController = shuffleController {
            self.shuffleVC = shuffleController
        }
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didChangeFromSegmentAtIndex fromIndex: Int, toSegmentAtIndex toIndex: Int) {
//        guard let shuffleVC = shuffleVC else {
//            print ("Cannot obatin instance of ShuffleVC")
//            return
//        }
//
//        var shuffleConf = shuffleVC.shuffleConfiguration
        
        //Enable How Segmented Control when exits from Now Mode
        if fromIndex == 3 && segmentedControl == shuffleView.whenSegmentedControl {
            shuffleView.disableHowView.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.2) {
                self.shuffleView.disableHowView.backgroundColor = .clear
            }
        }
        
        switch segmentedControl {
        case shuffleView.howSegmentedControl:
            switch toIndex {
            case 0:
                shuffleConf.how = .Smart
            case 1:
                shuffleConf.how = .Random
            case 2:
                shuffleConf.how = .Single
            default:
                shuffleConf.how = .Smart
            }
        case shuffleView.whenSegmentedControl:
            switch toIndex {
            case 0:
                shuffleConf.when = .All
            case 1:
                shuffleConf.when = .This
            case 2:
                shuffleConf.when = .Next
            case 3:
                shuffleConf.when = .Now
            default:
                shuffleConf.when = .All
            }
        default:
            break
        }
        
        if shuffleConf.when == .Now {
            shuffleView.howSegmentedControl.setCurrentSegmentIndex(1, animated: true)
            shuffleView.disableHowView.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.2) {
                self.shuffleView.disableHowView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
                self.shuffleMessageLabel.text = "You will get an instant task to do"
            }
        } else {
            updateShuffleMessageLabel(shuffleConf: shuffleConf)
        }
        
        shuffleVC?.shuffleConfiguration = shuffleConf
    }
}

//Updated shuffle message label
extension ShuffleSegmentedControllersDelegate {
    func filterGapsByWeek(conf: ShuffleConfiguration, gaps: [GapRealm]) -> [GapRealm] {
        var filteredGaps = [GapRealm]()
        
        if conf.when == .This {
            let currentWeekNumber = Calendar.current.component(.weekOfYear, from: Date())
            for g in gaps {
                    let gapWeekNumber = Calendar.current.component(.weekOfYear, from: g.startDate)
                    if currentWeekNumber == gapWeekNumber {
                        filteredGaps.append(g)
                    }
            }
        } else if conf.when == .Next {
            for g in gaps {
                if Calendar.current.isDateInNextWeek(g.startDate) {
                        filteredGaps.append(g)
                }
            }
        } else {
            filteredGaps = gaps
        }
        
        return filteredGaps
    }
    
    public func updateShuffleMessageLabel(shuffleConf: ShuffleConfiguration) {

        let pendingGaps = filterGapsByWeek(conf: shuffleConf, gaps: GapManager.instance.pendingGaps)
        let assignedGaps = filterGapsByWeek(conf: shuffleConf, gaps: GapManager.instance.assignedGaps)
        let pendingTaks = TaskManager.populateTasks(state: .pending)
        let existPendingTasks = pendingTaks.count > 0
        
        if !existPendingTasks {
            shuffleMessageLabel.text = "There are no tasks to shuffle"
        } else if SettingsValues.taskSettings[2] {
            if pendingGaps.count == 0 {
                shuffleMessageLabel.text = "There are no gaps to shuffle"
            } else {
                let numberOfGaps = pendingGaps.count
                if shuffleConf.how == .Single {
                    shuffleMessageLabel.text = "One task will be shuffled in \(numberOfGaps) gaps"
                } else {
                    let numberOfTasks = pendingTaks.count
                    if numberOfTasks > 1 {
                        shuffleMessageLabel.text = "\(numberOfTasks) tasks will be shuffled in \(numberOfGaps) gaps"
                    } else {
                        shuffleMessageLabel.text = "\(numberOfTasks) task will be shuffled in \(numberOfGaps) gaps"
                    }
                    
                }
            }
        } else if assignedGaps.count > 0 || pendingGaps.count > 0 {
            let numberOfTasks = pendingTaks.count
            let numberOfGaps = assignedGaps.count + pendingGaps.count
            if shuffleConf.how == .Single {
                shuffleMessageLabel.text = "One task will be shuffled in \(numberOfGaps) gaps"
            } else {
                if numberOfTasks > 1 {
                    shuffleMessageLabel.text = "\(numberOfTasks) tasks will be shuffled in \(numberOfGaps) gaps"
                } else {
                    shuffleMessageLabel.text = "\(numberOfTasks) task will be shuffled in \(numberOfGaps) gaps"
                }
            }
        } else {
            shuffleMessageLabel.text = "There are no gaps to shuffle"
        }
    }
}
