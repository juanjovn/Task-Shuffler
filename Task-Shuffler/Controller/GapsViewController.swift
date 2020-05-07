//
//  GapsViewController.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 29/02/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit
import AMTabView
import SJFluidSegmentedControl
import RealmSwift

class GapsViewController: AMTabsViewController {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: SJFluidSegmentedControl!
    @IBOutlet weak var segmentedControlBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var newGapButton: UIButton!
    @IBOutlet weak var newGapButtonBottomConstraint: NSLayoutConstraint!
    
    //Constants
    let db = DatabaseManager()
    
    //Variable
    var pendingGaps = [GapRealm]()
    var assignedGaps = [GapRealm]()
    var completedGaps = [GapRealm]()
    var sorted = 0
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //test()
        setupNewGapButton()
        fillGaps()
        setupView()
        setupNavigationItems()
        setupSegmentedControl()
        setupTableView()
    }
    
    // MARK: viewDidAppear
    
    override func viewDidAppear(_ animated: Bool) {
        segmentedControl.cornerRadius = segmentedControl.bounds.height / 2
        tableView.reloadData()
    }
    
    private func test(){
        //db.eraseAll()
        let gap = GapRealm(startDate: Date(), endDate: Date.init(timeIntervalSinceNow: 7200), state: "Pending", taskid: "BC64AFD3-43E6-4F88-8665-879DA397E968")
        pendingGaps.append(gap)
        db.addData(object: gap)
    }
    
    private func setupNewGapButton() {
        newGapButton.layer.cornerRadius = newGapButton.bounds.size.width/2
        newGapButton.layer.shadowOffset = .init(width: 0, height: 1)
        newGapButton.backgroundColor = .fireOrange
        newGapButton.setTitleColor(.pearlWhite, for: .normal)
    }
    
    private func fillGaps(){
        pendingGaps = GapManager.populateGaps(state: .pending)
        assignedGaps = GapManager.populateGaps(state: .assigned)
        completedGaps = GapManager.populateGaps(state: .completed)
    }
    
    private func setupNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "sort"), style: .plain, target: self, action: #selector(sortButtonAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear"), style: .plain, target: self, action: #selector(settingsButtonAction))
    }
    
    private func setupView(){
        view.backgroundColor = .paleSilver
    }
    
    @objc func settingsButtonAction(){
        present(UINavigationController(rootViewController: SettingsVC()), animated: true)
    }
    
    @objc func sortButtonAction(){
        let sortMenu = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)
        let sortByDateAction = UIAlertAction(title: "Date", style: .default, handler: {
            action in
            self.sortActions(sortType: .date)
        })
        let sortByDurationAction = UIAlertAction(title: "Duration", style: .default, handler: {
            action in
            self.sortActions(sortType: .duration)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        
        sortMenu.addAction(sortByDateAction)
        sortMenu.addAction(sortByDurationAction)
        sortMenu.addAction(cancelAction)
        
        sortMenu.pruneNegativeWidthConstraints()
        self.present(sortMenu, animated: true, completion: nil)
    }
    
    private enum SortType: String {
        case date = "startDate"
        case duration = "duration"
    }
    
    private func sortActions(sortType: SortType){
        let gapResults = db.getData(objectClass: GapRealm.self)
        var sortedResults: Results<Object>
        if sorted <= 0{
            sortedResults = db.sortData(data: gapResults, keyPath: sortType.rawValue, asc: true)
            sorted = 1
        } else {
            sortedResults = db.sortData(data: gapResults, keyPath: sortType.rawValue, asc: false)
            sorted = -1
        }
        
        if segmentedControl.currentSegment == 0{
            pendingGaps = GapManager.populateArray(results: sortedResults.filter("state == '\(State.pending.rawValue)' "))
            assignedGaps = GapManager.populateArray(results: sortedResults.filter("state == '\(State.assigned.rawValue)' "))
        } else {
            completedGaps = GapManager.populateArray(results: sortedResults.filter("state == '\(State.completed.rawValue)' "))
        }
        
        tableView.reloadSections(IndexSet(integersIn: 0...tableView.numberOfSections - 1), with: .fade)
    }
    
    private func setupSegmentedControl(){
        segmentedControl.dataSource = self
        segmentedControl.delegate = self
        segmentedControl.cornerRadius = segmentedControl.bounds.height / 2
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .paleSilver
        let nib = UINib(nibName: "GapCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "gapCell")
        
        let insets = UIEdgeInsets(top: 18, left: 0, bottom: 120, right: 0)
        tableView.contentInset = insets
        
        tableView.rowHeight = UIScreen.main.bounds.width / 5
    }
    
    @IBAction func newGapAction(_ sender: Any) {
        present(NewGapVC(), animated: true, completion: nil)
    }

}

//MARK: Segmented Control

extension GapsViewController: SJFluidSegmentedControlDataSource, SJFluidSegmentedControlDelegate{
    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
        2
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, gradientColorsForSelectedSegmentAtIndex index: Int) -> [UIColor] {
        if index == 0{
            return [UIColor.fireOrange]
        } else {
            return [UIColor.powerGreen]
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
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didChangeFromSegmentAtIndex fromIndex: Int, toSegmentAtIndex toIndex: Int) {
        
        tableView.reloadSections(IndexSet(integersIn: 0...1), with: .fade)
        
        if tableView.numberOfRows(inSection: 0) > 0{
            let topIndex = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: topIndex, at: .top, animated: true)
            tableView.reloadData()
        }
        
    }
    
}

extension GapsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isTracking{
            hideButton()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            showButton()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        showButton()
    }
    
    func hideButton() {
        UIView.animate(withDuration: 0.5) {
            self.newGapButton.alpha = 0
            self.newGapButtonBottomConstraint.constant = 0
            self.segmentedControl.alpha = 0
            self.segmentedControlBottomConstraint.constant = 30
            
            // This conditional is just for avoid a xcode warning about UITableView:
            // [TableView] Warning once only: UITableView was told to layout its visible cells and other contents without being in the view hierarchy (the table view or one of its superviews has not been added to a window).
            if self.view.window != nil{
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func showButton() {
        UIView.animate(withDuration: 0.3) {
            self.newGapButton.alpha = 1
            self.newGapButtonBottomConstraint.constant = 80
            self.segmentedControl.alpha = 1
            self.segmentedControlBottomConstraint.constant = 0
            
            // This conditional is just for avoid a xcode warning about UITableView:
            // [TableView] Warning once only: UITableView was told to layout its visible cells and other contents without being in the view hierarchy (the table view or one of its superviews has not been added to a window).
            if self.view.window != nil{
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView

        if let textlabel = header.textLabel {
            textlabel.font = .avenirDemiBold(ofSize: 20)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if (SettingsValues.taskSettings[1]){
                Alert.confirmation(title: "Confirm delete?", message: nil, vc: self, handler: {_ in
                    self.deleteGap(indexPath)
                })
            } else {
                deleteGap(indexPath)
            }
        }
    }
    
    func deleteGap (_ indexPath: IndexPath){
        var gap = GapRealm()
        switch indexPath.section {
        case 0:
            if segmentedControl.currentSegment == 0 {
                gap = pendingGaps[indexPath.row]
                pendingGaps.remove(at: indexPath.row)
            } else {
                gap = completedGaps[indexPath.row]
                completedGaps.remove(at: indexPath.row)
            }
        case 1:
            gap = assignedGaps[indexPath.row]
            assignedGaps.remove(at: indexPath.row)
        default:
            break
        }

        tableView.deleteRows(at: [indexPath], with: .fade)
        db.deleteData(object: gap)

        hideAssignedIfEmpty()
    }
    
    private func hideAssignedIfEmpty() {
        if !existGaps(gaps: assignedGaps){
            tableView.reloadSections(IndexSet(integer: 1), with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var swipeAction = UIContextualAction()
        if segmentedControl.currentSegment == 0 {
            swipeAction = UIContextualAction(style: .normal, title: "✓", handler: {
                (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
                self.markCompleted(indexPath: indexPath)
                print("✅ Marcado completado")
                success(true)
            })
            swipeAction.image = UIGraphicsImageRenderer(size: CGSize(width: 26, height: 20)).image { _ in
                UIImage(named: "tick")?.draw(in: CGRect(x: 0, y: 0, width: 26, height: 20))
            }
            swipeAction.backgroundColor = .powerGreen
        } else {
            swipeAction = UIContextualAction(style: .normal, title: "⎌", handler: {
                (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
                //self.restoreTask(indexPath: indexPath)
                print("⎌ Marcado restaurar")
                success(true)
            })
            swipeAction.image = UIGraphicsImageRenderer(size: CGSize(width: 26, height: 26)).image { _ in
                UIImage(named: "restore")?.draw(in: CGRect(x: 0, y: 0, width: 26, height: 26))
            }
            swipeAction.backgroundColor = .systemOrange
        }
        
        return UISwipeActionsConfiguration(actions: [swipeAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 0 && segmentedControl.currentSegment == 0{
//            isTaskEditing = true
//            performSegue(withIdentifier: "newTaskSegue", sender: tableView)
//        }
//
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func markCompleted(indexPath: IndexPath) {
        var gap = GapRealm()
        let updatedGap = GapRealm()

        if indexPath.section == 0 {
            gap = pendingGaps[indexPath.row]
            pendingGaps.remove(at: indexPath.row)
        } else {
            gap = assignedGaps[indexPath.row]
            assignedGaps.remove(at: indexPath.row)
        }
        
        updatedGap.id = gap.id
        updatedGap.duration = gap.duration
        updatedGap.startDate = gap.startDate
        updatedGap.endDate = gap.endDate
        updatedGap.state = State.completed.rawValue
        completedGaps.insert(updatedGap, at: 0)
        tableView.deleteRows(at: [indexPath], with: .fade)
        db.updateData(object: updatedGap)
        hideAssignedIfEmpty()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return segmentedControl.currentSegment == 0 ? pendingGaps.count : completedGaps.count
        } else {
            return segmentedControl.currentSegment == 0 ? assignedGaps.count : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let zelda = tableView.dequeueReusableCell(withIdentifier: "gapCell", for: indexPath) as! GapCell
        var gap = GapRealm()
        
        switch indexPath.section {
            case 0:
                if segmentedControl.currentSegment == 0{
                    gap = pendingGaps[indexPath.row]
                } else {
                    gap = completedGaps[indexPath.row]
                }
                
            case 1:
                gap = assignedGaps[indexPath.row]
            
            default:
                break
            
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        //let ordinal = formatter.string(from: <#T##NSNumber#>)
        zelda.dateLabel.text = Utils.formatDate(datePattern: "E d", date: gap.startDate)
        zelda.monthLabel.text = Utils.formatDate(datePattern: "MMM", date: gap.startDate)
        zelda.startTimeLabel.text = Utils.formatDate(datePattern: "HH:mm", date: gap.startDate)
        zelda.endTimeLabel.text = Utils.formatDate(datePattern: "HH:mm", date: gap.endDate)
        
        return zelda
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let firstSectionTitle: String = segmentedControl.currentSegment == 0 ? "Free" : "Completed"
        let secondSectionTitle: String = segmentedControl.currentSegment == 0 ? "Assigned" : ""
        switch section {
        case 0:
            return firstSectionTitle
        case 1:
            if existGaps(gaps: assignedGaps){
                return secondSectionTitle
            } else{
                return nil
            }
        default:
            return ""
        }
    }
    
    func existGaps (gaps: [GapRealm]) -> Bool {
        return gaps.count > 0
    }
    
}

extension GapsViewController: TabItem{
    
    var tabImage: UIImage? {
        return UIImage(named: "clock")
    }
    
}
