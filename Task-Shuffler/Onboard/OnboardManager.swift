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

        let newTaskTip = EasyTipView(text: "First create a task".localized())
        newTaskTip.show(animated: true, forView: vc.newTaskButton, withinSuperview: vc.view)
        
        preferences.drawing.arrowPosition = .top
        preferences.positioning.bubbleInsets = UIEdgeInsets(top: 10, left: 110, bottom: 5, right: 5)
        preferences.drawing.arrowHeight = 25
        EasyTipView.globalPreferences = preferences
        let segmentedTip = EasyTipView(text: "Switch between pending and completed tasks".localized())
        segmentedTip.show(animated: true, forView: vc.segmentedControl, withinSuperview: vc.view)
    }
    
    func presentNewTaskTips (on vc: NewTaskViewController) -> EasyTipView {
        preferences.drawing.arrowPosition = .bottom
        preferences.positioning.bubbleInsets = UIEdgeInsets(top: 10, left: 130, bottom: 5, right: 10)
        preferences.drawing.arrowHeight = 25
        EasyTipView.globalPreferences = preferences
        let newTaskTip = EasyTipView(text: "Estimate duration in minutes".localized())
        newTaskTip.show(animated: true, forView: vc.slider, withinSuperview: vc.view)
        
        return newTaskTip
    }
    
    func presentGapTips (on vc: GapsViewController) {
        preferences.drawing.arrowPosition = .bottom
        preferences.positioning.bubbleInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 5)
        preferences.positioning.contentInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        preferences.drawing.arrowHeight = 10
        preferences.positioning.maxWidth = vc.view.frame.size.width * 0.8
        EasyTipView.globalPreferences = preferences
        let gapTip = EasyTipView(text: "Create a slot of spare time".localized())
        gapTip.show(animated: true, forView: vc.newGapButton, withinSuperview: vc.view)
        preferences.drawing.arrowPosition = .top
        preferences.positioning.bubbleInsets = UIEdgeInsets(top: 5, left: 90, bottom: 5, right: 5)
        preferences.drawing.arrowHeight = 15
        EasyTipView.globalPreferences = preferences
        let segmentedTip = EasyTipView(text: "Switch between free and completed time slots".localized())
        segmentedTip.show(animated: true, forView: vc.segmentedControl, withinSuperview: vc.view)
    }
    
    func presentTimePickerTips (on vc: TimePickerVC) -> [EasyTipView]{
        preferences.drawing.arrowPosition = .top
        preferences.positioning.bubbleInsets = UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
        preferences.drawing.arrowHeight = 10
        preferences.positioning.maxWidth = vc.view.frame.size.width * 0.4
        EasyTipView.globalPreferences = preferences
        let amPmTip = EasyTipView(text: "Switch between AM or PM hours".localized())
        amPmTip.show(animated: true, forView: vc.amPmButtonCotainerView, withinSuperview: vc.hourContainerView)
        
        preferences.positioning.bubbleInsets = UIEdgeInsets(top: 10, left: 0, bottom: 5, right: 10)
        let minutesTip = EasyTipView(text: "Drag to select minutes".localized())
        minutesTip.show(animated: true, forView: vc.dragLinesView, withinSuperview: vc.minuteContainerView)
        
        return [amPmTip, minutesTip]
    }
    
    func presentTimePickerEndingTime (on vc: NewGapVC) {
        
        let endTimeTip = EasyTipView(text: "Ending time".localized())
        preferences.drawing.arrowPosition = .right
        EasyTipView.globalPreferences = preferences
        endTimeTip.show(animated: true, forView: vc.toDisplayTimeView.fromLabel, withinSuperview: vc.view)
    }
    
    func presentShuffleTips (on vc: ShuffleVC) -> [EasyTipView?]{
        let howTitle = "Choose if you wish to shuffle the tasks in a Smart way, Random or only shuffle a Single task".localized()
        let font = UIFont.avenirRegular(ofSize: UIFont.scaleFont(17))
        let boldFont = UIFont.avenirDemiBold(ofSize: UIFont.scaleFont(17))
        let howAttributes = [NSAttributedString.Key.font: font, .foregroundColor: UIColor.pearlWhite]
        let howAttributedTitle = NSMutableAttributedString(string: howTitle, attributes: howAttributes)
        let languagePrefix = Locale.preferredLanguages[0]
        if languagePrefix.contains("es") {
            howAttributedTitle.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: 47, length: 11))
            howAttributedTitle.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: 60, length: 9))
            howAttributedTitle.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: 76, length: 5))
            
        } else {
            howAttributedTitle.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: 45, length: 5))
            howAttributedTitle.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: 56, length: 6))
            howAttributedTitle.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: 81, length: 6))
        }
        preferences.positioning.maxWidth = vc.view.frame.size.width * 0.8
        preferences.drawing.arrowPosition = .top
        preferences.drawing.arrowHeight = 10
        preferences.positioning.bubbleInsets = UIEdgeInsets(top: 13, left: 0, bottom: 0, right: 0)
        preferences.positioning.contentInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        EasyTipView.globalPreferences = preferences
        let howTip = EasyTipView(text: howAttributedTitle)
        howTip.show(animated: true, forView: vc.shuffleView.howSegmentedControl, withinSuperview: vc.view)
        
        let whenTitle = "Choose if you wish to shuffle in Both weeks, only in This or Next week or if you feel lucky and want to get an instant random task to do Now".localized()
        let whenAttributes = [NSAttributedString.Key.font: font, .foregroundColor: UIColor.pearlWhite]
        let whenAttributedTitle = NSMutableAttributedString(string: whenTitle, attributes: whenAttributes)
        if languagePrefix.contains("es") {
            whenAttributedTitle.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: 28, length: 5))
            whenAttributedTitle.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: 56, length: 4))
            whenAttributedTitle.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: 75, length: 9))
            whenAttributedTitle.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: 105, length: 11))
            
        } else {
            whenAttributedTitle.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: 33, length: 4))
            whenAttributedTitle.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: 53, length: 4))
            whenAttributedTitle.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: 61, length: 4))
            whenAttributedTitle.addAttribute(NSAttributedString.Key.font, value: boldFont, range: NSRange(location: whenTitle.count - 3, length: 3))
        }
        
        EasyTipView.globalPreferences = preferences
        let whenTip = EasyTipView(text: whenAttributedTitle)
        
        return [howTip, whenTip]
    }
    
}
