//
//  HorizontalCollectionVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 21/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

private let weekCellReuseIdentifier = "weekCell"

class HorizontalCollectionVC: UICollectionViewController {
    
    
    //MARK: Constants
    
    let currentWeekNumber = Calendar.current.component(.weekOfYear, from: Date())
    let gapManager = GapManager.instance
    
    //MARK: Variables
    
    private var indexOfCellBeforeDragging = 0
    private var collectionViewFlowLayout: UICollectionViewFlowLayout {
        return collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: weekCellReuseIdentifier)
        //self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: nextWeekReuseIdentifier)
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionView.allowsSelection = false //With this True the WeekLabel tinted to yellow in every touch. Setting it to false prevent it.
        setupNotificationCenter()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weekCellReuseIdentifier, for: indexPath) as! CollectionViewCell
            cell.labelText = "This Week".localized()
            cell.nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
            cell.backButton.isHidden = true
            cell.nextButton.isHidden = false
            cell.backView.isHidden = true
            cell.nextView.isHidden = false
            
            drawScheduleCells(cell: cell, row: indexPath.row)
            
            //cell.calendarVC.insertDummyTask()
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weekCellReuseIdentifier, for: indexPath) as! CollectionViewCell
            cell.labelText = "Next Week".localized()
            cell.backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
            cell.backButton.isHidden = false
            cell.nextButton.isHidden = true
            cell.backView.isHidden = false
            cell.nextView.isHidden = true

            drawScheduleCells(cell: cell, row: indexPath.row)
            
            return cell
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: weekCellReuseIdentifier, for: indexPath)
        }
    }

    //MARK: Private
    
    private func populateCalendarGaps(cell: CollectionViewCell){
        for gap in gapManager.pendingGaps{
            cell.calendarVC.insertEvent(eventName: "gap", startDate: gap.startDate, endDate: gap.endDate, type: EventType.Gap)
        }
    }
    
    private func drawScheduleCells (cell: CollectionViewCell, row: Int) {
        var durationsDictionary = [String: Int]()
        let gapsToDraw = gapManager.populateCurrentGaps()
        for gap in gapsToDraw {
            durationsDictionary.updateValue(gap.intervalDateToMinutes(startDate: gap.startDate, endDate: gap.endDate), forKey: gap.id)
            let gapWeekNumber = Calendar.current.component(.weekOfYear, from: gap.startDate)
            if row == 0 { //This week
                if currentWeekNumber == gapWeekNumber {
                    cell.calendarVC.insertEvent(eventName: "", startDate: gap.startDate, endDate: gap.endDate, type: EventType.Gap)
                }
            } else { //Next week
                if Calendar.current.isDateInNextWeek(gap.startDate) {
                    cell.calendarVC.insertEvent(eventName: "", startDate: gap.startDate, endDate: gap.endDate, type: EventType.Gap)
                }
            }

        }
        let assignedTask = TaskManager.populateTasks(state: .assigned)
        for task in assignedTask {
            let assignedGap = gapManager.getGapById(id: task.gapid)!
            var assignedTasksInGap = TaskManager.getTasksByGapId(gapid: task.gapid)
            assignedTasksInGap = assignedTasksInGap.filter({$0.state == State.assigned})
            let numberOfAssignedTasksInGap = assignedTasksInGap.count
            let gapWeekNumber = Calendar.current.component(.weekOfYear, from: assignedGap.startDate)
            if row == 0 { //This week
                if currentWeekNumber == gapWeekNumber {
                    if numberOfAssignedTasksInGap == 1 {
                    cell.calendarVC.insertEvent(eventName: task.name, startDate: assignedGap.startDate, endDate: assignedGap.endDate, type: EventType.Task)
                    } else {
                        //TODO: Draw equally the tasks assigned to this gap.
                        guard let availableDuration = durationsDictionary[task.gapid] else { return}
                        let startTime = Date(timeInterval: Double(availableDuration) * -60, since: assignedGap.endDate)
                        let endTime = Date(timeInterval: Double(availableDuration * -60 + task.duration * 60), since: assignedGap.endDate)
                        cell.calendarVC.insertEvent(eventName: task.name, startDate: startTime, endDate: endTime, type: EventType.Task)
                        durationsDictionary.updateValue(availableDuration - task.duration, forKey: assignedGap.id)
                    }
                }
            } else { //Next week
                if Calendar.current.isDateInNextWeek(assignedGap.startDate) {
                    if numberOfAssignedTasksInGap == 1 {
                    cell.calendarVC.insertEvent(eventName: task.name, startDate: assignedGap.startDate, endDate: assignedGap.endDate, type: EventType.Task)
                    } else {
                        //TODO: Draw equally the tasks assigned to this gap.
                        guard let availableDuration = durationsDictionary[task.gapid] else { return}
                        let startTime = Date(timeInterval: Double(availableDuration) * -60, since: assignedGap.endDate)
                        let endTime = Date(timeInterval: Double(availableDuration * -60 + task.duration * 60), since: assignedGap.endDate)
                        cell.calendarVC.insertEvent(eventName: task.name, startDate: startTime, endDate: endTime, type: EventType.Task)
                        durationsDictionary.updateValue(availableDuration - task.duration, forKey: assignedGap.id)
                    }
                }
            }
            
        }
    }
    
    
    private func calculateSectionInset() -> CGFloat { // should be overridden
        return 0
    }
    
    private func configureCollectionViewLayoutItemSize() {
        let inset: CGFloat = calculateSectionInset()
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)

        collectionViewFlowLayout.itemSize = CGSize(width: collectionViewLayout.collectionView!.frame.size.width - inset * 2, height: collectionViewLayout.collectionView!.frame.size.height)
    }
    
    private func indexOfMajorCell() -> Int {
        let itemWidth = collectionViewFlowLayout.itemSize.width
        let proportionalOffset = collectionViewLayout.collectionView!.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let safeIndex = max(0, min(numberOfItems - 1, index))
        return safeIndex
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell()
    }
    

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Stop scrollView sliding:
        targetContentOffset.pointee = scrollView.contentOffset

        // calculate where scrollView should snap to:
        let indexOfMajorCell = self.indexOfMajorCell()

        // calculate conditions:
        let dataSourceCount = collectionView(collectionView!, numberOfItemsInSection: 0)
        let swipeVelocityThreshold: CGFloat = 0.5 // after some trail and error
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < dataSourceCount && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)

        if didUseSwipeToSkipCell {

            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = collectionViewFlowLayout.itemSize.width * CGFloat(snapToIndex)

            // Damping equal 1 => no oscillations => decay animation:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: nil)

        } else {
            // This is a much better way to scroll to a cell:
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @objc private func nextButtonAction () {
        //print ("Next Week touched!")
        let generator = UIImpactFeedbackGenerator(style: .medium)
        if SettingsValues.otherSettings[0] {
            generator.impactOccurred()
        }
        self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .right, animated: true)
    }
    
    @objc private func backButtonAction () {
        //print ("Previous Week touched!")
        let generator = UIImpactFeedbackGenerator(style: .medium)
        if SettingsValues.otherSettings[0] {
            generator.impactOccurred()
        }
        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: true)
    }
    
    private func setupNotificationCenter() {
//        NotificationCenter.default.addObserver(self, selector: #selector(onDataModified), name: .didModifiedData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                                   object: nil)
    }
    
    @objc func onDataModified () {
//        for cell in self.collectionView.visibleCells {
//            if let cell = cell as? CollectionViewCell {
//                cell.calendarVC.deleteAllEvents()
//                cell.calendarVC.setupFakeEvent()
//                if cell.weekLabel.text == "Next Week" {
//                    self.collectionView.reloadItems(at: [IndexPath(row: 1, section: 0)])
//                } else {
//                    self.collectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
//                }
//            }
//             }
//        print("Collection's view data reloaded from notification ❗️")
    }
    
    @objc func willEnterForeground () {
        self.collectionView.reloadData()
    }

}

extension HorizontalCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(indexPath)
    }
}
