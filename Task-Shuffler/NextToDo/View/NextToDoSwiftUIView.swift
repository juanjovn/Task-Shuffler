//
//  NextToDoSwiftUIView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 2/2/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import SwiftUI

struct NextToDoSwiftUIView: View {
    
    init() {
        if #available(iOS 14.0, *) {
            // iOS 14 doesn't have extra separators below the list by default.
        } else {
            // To remove only extra separators below the list:
            UITableView.appearance().tableFooterView = UIView()
        }
        
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().separatorColor = .clear
        let insets = UIEdgeInsets(top: 10, left: 0, bottom: 120, right: 0)
        UITableView.appearance().contentInset = insets
        
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    @SwiftUI.State fileprivate var taskList = NextToDoTask.calculateNextToDoTask()
    let taskListTest = [NextToDoTask(id: "1", name: "Tarea de prueba con doble linea", startTime: Calendar.current.currentDate, endTime: Calendar.current.currentDate, duration: 180, priority: .high)]
    
    var body: some View {
        if #available(iOS 14.0, *) { //Hardcode solution because .listStyle(SidebarListStyle()) is only available in iOS 14 for removing the separator bar.
            List(){
                ForEach(taskList) { taskItem in
                    let dateText = Utils.formatDate(datePattern: "EEEE ", date: taskItem.startTime)
                    let ordinalDate = Utils.formatDayNumberToOrdinal(date: taskItem.startTime)
                    let printableDate = dateText + ordinalDate!
                    
                    ZStack(alignment: .topLeading) {
                        
                        RoundedRectangle(cornerRadius: 20).foregroundColor(Color.white).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).shadow(color: Color(UIColor.mysticBlue.withAlphaComponent(0.5)), radius:5, x: 0, y: 2)
                        RoundedRectangle(cornerRadius: 20).foregroundColor(Color(getPriorityColor(priority: taskItem.priority))).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        VStack (alignment: .leading, spacing: 0){
                            
                            HStack (alignment: .top) {
                                //Image(systemName: "largecircle.fill.circle").resizable().frame(width: 25, height: 25, alignment: .topLeading).foregroundColor(Color(.mysticBlue)).padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                                Text(taskItem.name).font(.custom("AvenirNext-Medium", size: UIFont.scaleFont(25))).foregroundColor(Color(UIColor.mysticBlue)).lineLimit(3).background(Color.clear).minimumScaleFactor(0.75)
                            }
                            Spacer()
                            HStack (alignment: .center){
                                Image(systemName: "calendar").resizable().frame(width: 25, height: 25, alignment: .topLeading).foregroundColor(Color(.mysticBlue)).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                Text(printableDate).font(.init(UIFont.avenirRegular(ofSize: UIFont.scaleFont(20)))).foregroundColor(Color(UIColor.mysticBlue))
                            }
                            Spacer()
                            HStack(alignment: .center){
                                Spacer()
                                TimeSwiftUIView(color: .opalRed, time: Utils.formatDate(datePattern: "HH:mm", date: taskItem.startTime)).frame(minWidth: 50, maxWidth: 80, minHeight: 15, maxHeight: 30, alignment: .leading)
                                //Spacer()
                                TimeSwiftUIView(color: .turquesa, time: Utils.formatDate(datePattern: "HH:mm", date: taskItem.endTime)).frame(minWidth: 50, maxWidth: 80, minHeight: 15, maxHeight: 30, alignment: .leading)
                                Spacer()
                                //Image(systemName: "exclamationmark.circle").resizable().scaledToFit().foregroundColor(Color(.fireOrange)).shadow(color: Color(UIColor.mysticBlue.withAlphaComponent(0.6)), radius:3, x: 0, y:0)
                                Text("\(taskItem.duration)'").font(.custom("AvenirNext-Medium", size: UIFont.scaleFont(25))).foregroundColor(Color(UIColor.mysticBlue)).shadow(color: Color(UIColor.mysticBlue.withAlphaComponent(0.4)), radius:2, x: 0, y: 2)
                                //Spacer()
                            }.frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 20, maxHeight: 40, alignment: .leading)
                        }.padding(EdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 20))
                        
                    }
                    
                }.listRowBackground(Color.clear)
            }.listStyle(SidebarListStyle()).onAppear(perform: updateData)
            .onReceive(pub) { (output) in
                self.updateData()
            }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                self.updateData()
                //print("Enter foreground triggered! ❗️")
            }//IOS 14
        } else {
            List(){
                if taskList.isEmpty { //This is  needed only in iOS 13. It crashed in the onAppear when the list was empty the first time gaps was shuffled.
                    emptySection
                } else {
                    ForEach(taskList) { taskItem in
                        let dateText = Utils.formatDate(datePattern: "EEEE ", date: taskItem.startTime)
                        let ordinalDate = Utils.formatDayNumberToOrdinal(date: taskItem.startTime)
                        let printableDate = dateText + ordinalDate!
                        
                        ZStack(alignment: .topLeading) {
                            
                            RoundedRectangle(cornerRadius: 20).foregroundColor(Color.white).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).shadow(color: Color(UIColor.mysticBlue.withAlphaComponent(0.5)), radius:5, x: 0, y: 2)
                            RoundedRectangle(cornerRadius: 20).foregroundColor(Color(getPriorityColor(priority: taskItem.priority))).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            
                            VStack (alignment: .leading, spacing: 0){
                                
                                HStack (alignment: .top) {
                                    //Image(systemName: "largecircle.fill.circle").resizable().frame(width: 25, height: 25, alignment: .topLeading).foregroundColor(Color(.mysticBlue)).padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                                    Text(taskItem.name).font(.custom("AvenirNext-Medium", size: UIFont.scaleFont(25))).foregroundColor(Color(UIColor.mysticBlue)).lineLimit(3).background(Color.clear).minimumScaleFactor(0.75)
                                }
                                Spacer()
                                HStack (alignment: .center){
                                    Image(systemName: "calendar").resizable().frame(width: 25, height: 25, alignment: .topLeading).foregroundColor(Color(.mysticBlue)).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    Text(printableDate).font(.init(UIFont.avenirRegular(ofSize: UIFont.scaleFont(20)))).foregroundColor(Color(UIColor.mysticBlue))
                                }
                                Spacer()
                                HStack(alignment: .center){
                                    Spacer()
                                    TimeSwiftUIView(color: .opalRed, time: Utils.formatDate(datePattern: "HH:mm", date: taskItem.startTime)).frame(minWidth: 50, maxWidth: 80, minHeight: 15, maxHeight: 30, alignment: .leading)
                                    //Spacer()
                                    TimeSwiftUIView(color: .turquesa, time: Utils.formatDate(datePattern: "HH:mm", date: taskItem.endTime)).frame(minWidth: 50, maxWidth: 80, minHeight: 15, maxHeight: 30, alignment: .leading)
                                    Spacer()
                                    //Image(systemName: "exclamationmark.circle").resizable().scaledToFit().foregroundColor(Color(.fireOrange)).shadow(color: Color(UIColor.mysticBlue.withAlphaComponent(0.6)), radius:3, x: 0, y:0)
                                    Text("\(taskItem.duration)'").font(.custom("AvenirNext-Medium", size: UIFont.scaleFont(25))).foregroundColor(Color(UIColor.mysticBlue)).shadow(color: Color(UIColor.mysticBlue.withAlphaComponent(0.4)), radius:2, x: 0, y: 2)
                                    //Spacer()
                                }.frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 20, maxHeight: 40, alignment: .leading)
                            }.padding(EdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 20))
                            
                        }
                        
                    }.listRowBackground(Color.clear)
                }
                
            }
            .onAppear(perform: updateData)
            .onReceive(pub) { (output) in
                self.updateData()
            }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                self.updateData()
                //print("Enter foreground triggered! ❗️")
            }
        }
    }
    
    let pub = NotificationCenter.default
        .publisher(for: NSNotification.Name("didModifiedData"))
    
    func updateData() {
        taskList = NextToDoTask.calculateNextToDoTask()
    }
    
}

var emptySection: some View {
    Section {
        Text("")
    }
}




struct NextToDoSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NextToDoSwiftUIView()
    }
}

private func getPriorityColor(priority: Priority) -> UIColor {
    var color = UIColor()
    
    switch priority {
    case .low:
        color = UIColor.turquesa.withAlphaComponent(0.8)
    case .medium:
        color = UIColor.darkOrange.withAlphaComponent(0.8)
    case .high:
        color = UIColor.fireOrange.withAlphaComponent(0.8)
    }
    
    return color
}

