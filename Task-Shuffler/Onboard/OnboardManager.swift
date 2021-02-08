//
//  OnboardManager.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 8/2/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import Foundation
import UIKit
import EasyTipView

class Onboard {
    
    var preferences = EasyTipView.Preferences()
    
    static let instance = Onboard() //Singleton
    
    init() {
        preferences.drawing.font = .avenirMedium(ofSize: UIFont.scaleFont(17))
        preferences.drawing.foregroundColor = UIColor.pearlWhite
        preferences.drawing.backgroundColor = .turquesa
        preferences.drawing.arrowPosition = .bottom
        preferences.drawing.cornerRadius = 15
        preferences.drawing.arrowHeight = 8
        preferences.positioning.contentInsets = UIEdgeInsets(top: 8, left: 13, bottom: 8, right: 13)
        preferences.positioning.bubbleInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        /*
         * Optionally you can make these preferences global for all future EasyTipViews
         */
        EasyTipView.globalPreferences = preferences
    }
    
    func presentTaskListTips (on vc: TasksListViewController) {

        let newTaskTip = EasyTipView(text: "First create a task")
        newTaskTip.show(animated: true, forView: vc.newTaskButton, withinSuperview: vc.view)
        
        preferences.drawing.arrowPosition = .top
        preferences.positioning.bubbleInsets = UIEdgeInsets(top: 10, left: 110, bottom: 5, right: 5)
        preferences.drawing.arrowHeight = 25
        EasyTipView.globalPreferences = preferences
        let segmentedTip = EasyTipView(text: "Switch between pending and completed tasks")
        segmentedTip.show(animated: true, forView: vc.segmentedControl, withinSuperview: vc.view)
    }
    
    func presentNewTaskTips (on vc: NewTaskViewController) {
        preferences.drawing.arrowPosition = .bottom
        preferences.positioning.bubbleInsets = UIEdgeInsets(top: 10, left: 130, bottom: 5, right: 10)
        preferences.drawing.arrowHeight = 25
        EasyTipView.globalPreferences = preferences
        let newTaskTip = EasyTipView(text: "Estimate duration in minutes")
        newTaskTip.show(animated: true, forView: vc.slider, withinSuperview: vc.view)
    }
    
    func presentGapTips (on vc: GapsViewController) {
        preferences.drawing.arrowPosition = .bottom
        preferences.positioning.bubbleInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 5)
        preferences.positioning.contentInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        preferences.drawing.arrowHeight = 10
        preferences.positioning.maxWidth = vc.view.frame.size.width * 0.8
        EasyTipView.globalPreferences = preferences
        let gapTip = EasyTipView(text: "Create a gap of spare time")
        gapTip.show(animated: true, forView: vc.newGapButton, withinSuperview: vc.view)
        preferences.drawing.arrowPosition = .top
        preferences.positioning.bubbleInsets = UIEdgeInsets(top: 5, left: 90, bottom: 5, right: 5)
        preferences.drawing.arrowHeight = 15
        EasyTipView.globalPreferences = preferences
        let segmentedTip = EasyTipView(text: "Switch between free and completed gaps")
        segmentedTip.show(animated: true, forView: vc.segmentedControl, withinSuperview: vc.view)
    }
    
    func presentTimePickerTips (on vc: TimePickerVC) {
        preferences.drawing.arrowPosition = .top
        preferences.positioning.bubbleInsets = UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
        preferences.drawing.arrowHeight = 10
        preferences.positioning.maxWidth = vc.view.frame.size.width * 0.4
        EasyTipView.globalPreferences = preferences
        let amPmTip = EasyTipView(text: "Switch between AM or PM hours")
        amPmTip.show(animated: true, forView: vc.amPmButtonCotainerView, withinSuperview: vc.hourContainerView)
        
        preferences.positioning.bubbleInsets = UIEdgeInsets(top: 10, left: 0, bottom: 5, right: 10)
        let minutesTip = EasyTipView(text: "Drag to select minutes")
        minutesTip.show(animated: true, forView: vc.dragLinesView, withinSuperview: vc.minuteContainerView)
    }
    
    func presentTimePickerEndingTime (on vc: NewGapVC) {
        
        let endTimeTip = EasyTipView(text: "Ending time")
        preferences.drawing.arrowPosition = .right
        EasyTipView.globalPreferences = preferences
        endTimeTip.show(animated: true, forView: vc.toDisplayTimeView.fromLabel, withinSuperview: vc.view)
    }
    
}
