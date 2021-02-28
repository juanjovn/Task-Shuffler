//
//  ResultsCollectionVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 18/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ResultsCollectionVC: UICollectionViewController {

    let dummyNames = ["Juanjo", "Lucia", "Marcos", "Andy"]
    var tasks = [Task]()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.collectionView!.register(ResultsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear

    }



    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ResultsCollectionViewCell
        let task = tasks[indexPath.row]
        cell.nameLabel.text = task.name
        
        if let gap = GapManager.instance.getGapById(id: task.gapid) {
            cell.dateLabel.text = Utils.formatDate(datePattern: "EEEE ", date: gap.startDate)
            //Append ordinal termination (st, nr, rd, th) if preferred language is not Spanish.
            let languagePrefix = Locale.preferredLanguages[0]
            if !languagePrefix.contains("es") {
                let ordinalDate = Utils.formatDayNumberToOrdinal(date: gap.startDate)!
                cell.dateLabel.text! += ordinalDate
            } else {
                cell.dateLabel.text! += Utils.formatDate(datePattern: "d", date: gap.startDate)
            }
        } else {
            cell.dateLabel.text = "Date"
        }
        
        if let gap = GapManager.instance.getGapById(id: task.gapid) {
            cell.startTime.timeLabel.text = Utils.formatDate(datePattern: "HH:mm", date: gap.startDate)
            cell.endTime.timeLabel.text = Utils.formatDate(datePattern: "HH:mm", date: gap.endDate)
        } else {
            return cell
        }
        
        switch task.priority {
        case .low:
            cell.priorityIcon.tintColor = .powerGreen
        case .medium:
            cell.priorityIcon.tintColor = .darkOrange
        case .high:
            cell.priorityIcon.tintColor = .fireOrange
        }
        
        return cell
    }

}

// MARK: UICollectionViewDelegateFlowLayout
extension ResultsCollectionVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 1.66
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
