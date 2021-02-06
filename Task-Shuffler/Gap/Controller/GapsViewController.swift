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
    var pullcontrol = UIRefreshControl()
    
    //Constants
    let db = DatabaseManager()
    let gapManager = GapManager.instance
    
    //Variables
    var sorted = 0
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //test()
        setupNotificationCenter()
        setupNewGapButton()
        gapManager.fillGaps()
        setupView()
        setupNavigationItems()
        setupSegmentedControl()
        setupTableView()
        
        print("Number of pending gaps = \(gapManager.pendingGaps.count)")
    }
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        refreshOutdated()
        tableView.reloadData()
    }
    
    // MARK: viewDidAppear
    
    override func viewDidAppear(_ animated: Bool) {
        segmentedControl.cornerRadius = segmentedControl.bounds.height / 2
    }
    
    //MARK: PUBLIC
    
    public func addNewGap (gap: GapRealm) {
        db.addData(object: gap)
        gapManager.pendingGaps.insert(gap, at: 0)
        tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        let topIndex = IndexPath(row: 0, section: 0)
        
        if self.tableView.numberOfRows(inSection: 0) > 0{
            self.tableView.scrollToRow(at: topIndex, at: .top, animated: true)
        }
        
        
        if segmentedControl.currentSegment > 0 {
            segmentedControl.setCurrentSegmentIndex(0, animated: true)
        }
        
        gapManager.fillGaps()
        print("GapManager refilled ⬆️")
        print("Number of pending gaps = \(gapManager.pendingGaps.count)")
        NotificationCenter.default.post(name: .didModifiedData, object: nil)
    }
    
    public func checkOutdated(currentGap: GapRealm) -> Bool{
        return Date() > currentGap.endDate
    }
    
    //MARK: PRIVATE
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(onDataModified), name: .didModifiedData, object: nil)
    }
    
    @objc func onDataModified () {
        //gapManager.fillGaps()
        refreshOutdated()
        tableView.reloadData()
        //tableView.reloadSections(IndexSet(integersIn: 0...tableView.numberOfSections - 1), with: .fade)
        //print("❗️NOTIFIED!!! ")
    }
    
    private func test(){
        //db.eraseAll()
        let gap = GapRealm(startDate: Date(), endDate: Date.init(timeIntervalSinceNow: 600), state: "Completed", taskid: "BC64AFD3-43E6-4F88-8665-879DA397E968")
        gapManager.pendingGaps.append(gap)
        db.addData(object: gap)
    }
    
    private func setupNewGapButton() {
        newGapButton.layer.cornerRadius = newGapButton.bounds.size.width/2
        newGapButton.layer.shadowColor = UIColor.mysticBlue.cgColor
        newGapButton.layer.shadowOffset = .init(width: 0, height: 2)
        newGapButton.layer.shadowRadius = 5
        newGapButton.layer.shadowOpacity = 0.7
        newGapButton.backgroundColor = .fireOrange
        newGapButton.setTitleColor(.pearlWhite, for: .normal)
    }
    
//    private func gapManager.fillGaps(){
//        pendingGaps = gapManager.populateGaps(state: .pending)
//        gapManager.assignedGaps = gapManager.populateGaps(state: .assigned)
//        gapManager.completedGaps = gapManager.populateGaps(state: .completed)
//    }
    
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
            gapManager.pendingGaps = gapManager.populateArray(results: sortedResults.filter("state == '\(State.pending.rawValue)' "))
            gapManager.assignedGaps = gapManager.populateArray(results: sortedResults.filter("state == '\(State.assigned.rawValue)' "))
        } else {
            gapManager.completedGaps = gapManager.populateArray(results: sortedResults.filter("state == '\(State.completed.rawValue)' "))
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
        
        //Refresh control
        pullcontrol.addTarget(self, action: #selector(pullRefreshControl), for: UIControl.Event.valueChanged)
        tableView.addSubview(pullcontrol)
    }
    
    @objc private func pullRefreshControl() {
        refreshOutdated()
        tableView.reloadSections(IndexSet(integersIn: 0...2), with: .fade)
        self.pullcontrol.endRefreshing()
//        if checkOutdated(currentGap: gap) {
//            zelda.dateLabel.text = "OUTDATED"
//        }
    }
    
    private func refreshOutdated() {
        var isChanged = false
        for gap in gapManager.pendingGaps {
            if checkOutdated(currentGap: gap) {
                isChanged = true
                do {
                    try db.realm.write{
                        gap.state = State.outdated.rawValue
                    }
                } catch {
                    print("Error updating to database")
                }
            }
        }
        
        var gaps = [GapRealm]()
        let usedGaps = gapManager.assignedGaps + gapManager.filledGaps
        if usedGaps.count > 0 {
            for gap in usedGaps {
                if checkOutdated(currentGap: gap) {
                    isChanged = true
                    gaps.append(gap)
                    do {
                        try db.realm.write{
                            if SettingsValues.taskSettings[0] {
                                gap.state = State.completed.rawValue
                            } else {
                                gap.state = State.outdated.rawValue
                            }
                        }
                    } catch {
                        print("Error updating to database")
                    }
                }
            }
            
            for gap in gaps {
                var assignedTasks = db.getData(objectClass: TaskRealm.self)
                assignedTasks = assignedTasks.filter("gapid = '\(gap.id)'")
                for taskRealm in assignedTasks {
                    let task = taskRealm as! TaskRealm
                    do {
                        try db.realm.write{
                            if SettingsValues.taskSettings[0] {
                                task.state = State.completed.rawValue
                            }
                        }
                    } catch {
                        print("Error writing update to database")
                    }
                }
            }
        }
        
        if isChanged {
            gapManager.fillGaps()
        }
        
    }
    
    @IBAction func newGapAction(_ sender: Any) {
        let newGapVC = NewGapVC()
        newGapVC.gapsVC = self
        present(newGapVC, animated: true, completion: nil)
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
        
        refreshOutdated()
        tableView.reloadSections(IndexSet(integersIn: 0...2), with: .fade)
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
        var assignedTasks = db.getData(objectClass: TaskRealm.self)
        switch indexPath.section {
        case 0:
            if segmentedControl.currentSegment == 0 {
                gap = gapManager.pendingGaps[indexPath.row]
                print(gap.description)
                gapManager.pendingGaps.remove(at: indexPath.row)
            } else {
                gap = gapManager.completedGaps[indexPath.row]
                gapManager.completedGaps.remove(at: indexPath.row)
            }
        case 1:
            if segmentedControl.currentSegment == 0 {
                gap = gapManager.assignedGaps[indexPath.row]
            } else {
                gap = gapManager.outdatedGaps[indexPath.row]
            }
            assignedTasks = assignedTasks.filter("gapid = '\(gap.id)'")
            for taskRealm in assignedTasks {
                let task = taskRealm as! TaskRealm
                do {
                    try db.realm.write{
                        task.gapid = ""
                        if segmentedControl.currentSegment == 0 {
                            task.state = State.pending.rawValue
                        }
                        print("Updated object: \(task.description)")
                    }
                } catch {
                    print("Error writing update to database")
                }
            }
            if segmentedControl.currentSegment == 0 {
                gapManager.assignedGaps.remove(at: indexPath.row)
                
                //Update notifications
                NotificationManager.instance.removeAllTypeNotifications()
                NotificationManager.instance.scheduleMultipleTasksNotifications(for: TaskManager.populateTasks(state: .assigned))
            } else {
                gapManager.outdatedGaps.remove(at: indexPath.row)
            }
            
        case 2:
            gap = gapManager.filledGaps[indexPath.row]
            assignedTasks = assignedTasks.filter("gapid = '\(gap.id)'")
            for taskRealm in assignedTasks {
                let task = taskRealm as! TaskRealm
                do {
                    try db.realm.write{
                        task.gapid = ""
                        task.state = State.pending.rawValue
                        print("Updated object: \(task.description)")
                    }
                } catch {
                    print("Error writing update to database")
                }
            }
            gapManager.filledGaps.remove(at: indexPath.row)
            
            //Update notifications
            NotificationManager.instance.removeAllTypeNotifications()
            NotificationManager.instance.scheduleMultipleTasksNotifications(for: TaskManager.populateTasks(state: .assigned))
            
        default:
            break
        }

        tableView.deleteRows(at: [indexPath], with: .fade)
        db.deleteData(object: gap)
        print("Number of pending gaps = \(gapManager.pendingGaps.count)")
        NotificationCenter.default.post(name: .didModifiedData, object: nil)

        hideAssignedIfEmpty()
    }
    
    private func hideAssignedIfEmpty() {
        if !existGaps(gaps: gapManager.assignedGaps){
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
        let newGapVC = NewGapVC()
        newGapVC.gapsVC = self
        newGapVC.isEditing = true
        switch segmentedControl.currentSegment {
        case 1:
            newGapVC.editedGap = gapManager.completedGaps[indexPath.row]
        case 0:
            if indexPath.section == 0 {
                newGapVC.editedGap = gapManager.pendingGaps[indexPath.row]
            }
        default:
            break
        }
        if indexPath.section == 0 {
            present(newGapVC, animated: true, completion: nil)
        }
    }
    
    private func markCompleted(indexPath: IndexPath) {
        var gap = GapRealm()
        let updatedGap = GapRealm()

        if indexPath.section == 0 {
            gap = gapManager.pendingGaps[indexPath.row]
            gapManager.pendingGaps.remove(at: indexPath.row)
        } else if indexPath.section == 1 {
            gap = gapManager.assignedGaps[indexPath.row]
            gapManager.assignedGaps.remove(at: indexPath.row)
            markTaskCompleted(gapid: gap.id)
        } else if indexPath.section == 2 {
            gap = gapManager.filledGaps[indexPath.row]
            gapManager.filledGaps.remove(at: indexPath.row)
            markTaskCompleted(gapid: gap.id)
        }
        
        
        
        updatedGap.id = gap.id
        updatedGap.duration = gap.duration
        updatedGap.startDate = gap.startDate
        updatedGap.endDate = gap.endDate
        updatedGap.state = State.completed.rawValue
        gapManager.completedGaps.insert(updatedGap, at: 0)
        tableView.deleteRows(at: [indexPath], with: .fade)
        db.updateData(object: updatedGap)
        hideAssignedIfEmpty()
    }
    
    private func markTaskCompleted (gapid: String) {
        let assignedTasks = TaskManager.populateTasks(state: .assigned)
        var newTask = Task(id: "", name: "", duration: 0, priority: .high, state: .pending, gapid: "")
        for task in assignedTasks {
            if task.gapid == gapid {
                newTask = task
                newTask.state = .completed
                TaskManager.updateTask(task: newTask)
            }
        }
        
        //Update notifications
        NotificationManager.instance.removeAllTypeNotifications()
        NotificationManager.instance.scheduleMultipleTasksNotifications(for: TaskManager.populateTasks(state: .assigned))
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return segmentedControl.currentSegment == 0 ? gapManager.pendingGaps.count : gapManager.completedGaps.count
        } else if section == 1 {
            return segmentedControl.currentSegment == 0 ? gapManager.assignedGaps.count : gapManager.outdatedGaps.count
        } else {
            return segmentedControl.currentSegment == 0 ? gapManager.filledGaps.count : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let zelda = tableView.dequeueReusableCell(withIdentifier: "gapCell", for: indexPath) as! GapCell
        var gap = GapRealm()
        
        switch indexPath.section {
            case 0:
                if segmentedControl.currentSegment == 0{
                    gap = gapManager.pendingGaps[indexPath.row]
                } else {
                    gap = gapManager.completedGaps[indexPath.row]
                }
                
            case 1:
                if segmentedControl.currentSegment == 0{
                    gap = gapManager.assignedGaps[indexPath.row]
                } else {
                    gap = gapManager.outdatedGaps[indexPath.row]
                }
            case 2:
                gap = gapManager.filledGaps[indexPath.row]
            
            default:
                break
            
        }
        
        zelda.dateLabel.text = Utils.formatDate(datePattern: "E d", date: gap.startDate)
        zelda.monthLabel.text = Utils.formatDate(datePattern: "MMM", date: gap.startDate)
        zelda.startTimeLabel.text = Utils.formatDate(datePattern: "HH:mm", date: gap.startDate)
        zelda.endTimeLabel.text = Utils.formatDate(datePattern: "HH:mm", date: gap.endDate)
        zelda.backgroundColor = UIColor.clear
        let onTapBackground = UIView()
        onTapBackground.backgroundColor = UIColor.iron.withAlphaComponent(0.25)
        zelda.selectedBackgroundView = onTapBackground
        
        return zelda
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let firstSectionTitle: String = segmentedControl.currentSegment == 0 ? "Free" : "Completed"
        let secondSectionTitle: String = segmentedControl.currentSegment == 0 ? "Assigned" : "Outdated"
        let thirdSectionTitle: String = segmentedControl.currentSegment == 0 ? "Filled" : ""
        switch section {
        case 0:
            return firstSectionTitle
        case 1:
            if existGaps(gaps: gapManager.assignedGaps) && segmentedControl.currentSegment == 0 {
                return secondSectionTitle
            } else if existGaps(gaps: gapManager.outdatedGaps) && segmentedControl.currentSegment == 1 {
                return secondSectionTitle
            } else {
                return nil
            }
        case 2:
            if existGaps(gaps: gapManager.filledGaps){
                return thirdSectionTitle
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
