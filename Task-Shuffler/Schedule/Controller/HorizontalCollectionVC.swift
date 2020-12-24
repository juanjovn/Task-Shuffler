//
//  HorizontalCollectionVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 21/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

private let currentWeekReuseIdentifier = "currentWeekCell"
private let nextWeekReuseIdentifier = "nextWeekCell"

class HorizontalCollectionVC: UICollectionViewController {
    
    
    //MARK: Constants
    
    let currentWeekNumber = Calendar.current.component(.weekOfYear, from: Date())
    let gapManager = GapManager.instance
    
    //MARK: Variables
    
    private var indexOfCellBeforeDragging = 0
    private var collectionViewFlowLayout: UICollectionViewFlowLayout {
        return collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    var pendingGaps = [GapRealm]()
    var assignedGaps = [GapRealm]()
    var completedGaps = [GapRealm]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: currentWeekReuseIdentifier)
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: nextWeekReuseIdentifier)
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionView.allowsSelection = false //With this True the WeekLabel tinted to yellow in every touch. Setting it to false prevent it.
        fillGaps()
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: currentWeekReuseIdentifier, for: indexPath) as! CollectionViewCell
            cell.labelText = "This Week"
            cell.nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
            cell.backButton.isHidden = true
            cell.nextButton.isHidden = false
            cell.backView.isHidden = true
            cell.nextView.isHidden = false
            
            for gap in pendingGaps{
                let gapWeekNumber = Calendar.current.component(.weekOfYear, from: gap.startDate)
                if currentWeekNumber == gapWeekNumber {
                    cell.calendarVC.insertEvent(eventName: "gap", startDate: gap.startDate, endDate: gap.endDate, type: EventType.Gap)
                }
                
            }
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nextWeekReuseIdentifier, for: indexPath) as! CollectionViewCell
            cell.labelText = "Next Week"
            cell.backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
            cell.backButton.isHidden = false
            cell.nextButton.isHidden = true
            cell.backView.isHidden = false
            cell.nextView.isHidden = true
            
            for gap in pendingGaps{
                let gapWeekNumber = Calendar.current.component(.weekOfYear, from: gap.startDate)
                if currentWeekNumber != gapWeekNumber {
                    cell.calendarVC.insertEvent(eventName: "gap", startDate: gap.startDate, endDate: gap.endDate, type: EventType.Gap)
                }
                
            }
            
            return cell
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: currentWeekReuseIdentifier, for: indexPath)
        }
    }

    //MARK: Private
    
    private func fillGaps(){
        pendingGaps = gapManager.populateGaps(state: .pending)
        assignedGaps = gapManager.populateGaps(state: .assigned)
        completedGaps = gapManager.populateGaps(state: .completed)
    }
    
    private func populateCalendarGaps(cell: CollectionViewCell){
        for gap in pendingGaps{
            cell.calendarVC.insertEvent(eventName: "gap", startDate: gap.startDate, endDate: gap.endDate, type: EventType.Gap)
        }
    }
    
//    private func isDateInNextWeek(_ date: Date) -> Bool {
//        guard let nextWeek = Calendar.current.date(byAdding: DateComponents(weekOfYear: 1), to: Date()) else {
//          return false
//        }
//        return Calendar.current.isDate(date, equalTo: nextWeek, toGranularity: .weekOfYear)
//    }
    
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
        print ("Next Week touched!")
        let generator = UIImpactFeedbackGenerator(style: .medium)
        if SettingsValues.otherSettings[0] {
            generator.impactOccurred()
        }
        self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .right, animated: true)
    }
    
    @objc private func backButtonAction () {
        print ("Previous Week touched!")
        let generator = UIImpactFeedbackGenerator(style: .medium)
        if SettingsValues.otherSettings[0] {
            generator.impactOccurred()
        }
        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: true)
    }
    


}

extension HorizontalCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
