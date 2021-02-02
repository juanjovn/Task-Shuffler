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
        
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    private let taskList = NextToDoTask.calculateNextToDoTask()
    
    var body: some View {
        List(taskList) { taskItem in
            
            let dateText = Utils.formatDate(datePattern: "EEEE ", date: taskItem.startTime)
            let ordinalDate = Utils.formatDayNumberToOrdinal(date: taskItem.startTime)
            let printableDate = dateText + ordinalDate!
            
            ZStack(alignment: .topLeading){
                
                RoundedRectangle(cornerRadius: 20).foregroundColor(Color.white).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).shadow(color: Color(UIColor.mysticBlue.withAlphaComponent(0.5)), radius:5, x: 0, y: 2)
                RoundedRectangle(cornerRadius: 20).foregroundColor(Color(getPriorityColor(priority: taskItem.priority))).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                VStack (alignment: .leading, spacing: 0){
                    
                    HStack (alignment: .top) {
                        Image(systemName: "largecircle.fill.circle").resizable().frame(width: 25, height: 25, alignment: .topLeading).foregroundColor(Color(.mysticBlue)).padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                        Text(taskItem.name).font(.custom("AvenirNext-Medium", size: 25)).foregroundColor(Color(UIColor.mysticBlue)).lineLimit(3).background(Color.clear).minimumScaleFactor(0.5)
                    }.background(Color.clear)
                    Spacer()
                    HStack (alignment: .center){
                        Image(systemName: "calendar").resizable().frame(width: 25, height: 25, alignment: .topLeading).foregroundColor(Color(.mysticBlue)).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        Text(printableDate).font(.init(UIFont.avenirRegular(ofSize: 20))).foregroundColor(Color(UIColor.mysticBlue))
                    }.background(Color.clear)
                    Spacer()
                    HStack(alignment: .center){
                        TimeSwiftUIView(color: .opalRed, time: Utils.formatDate(datePattern: "HH:mm", date: taskItem.startTime)).padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 15))
                        TimeSwiftUIView(color: .turquesa, time: Utils.formatDate(datePattern: "HH:mm", date: taskItem.endTime))
                        Spacer()
                        //Image(systemName: "exclamationmark.circle").resizable().scaledToFit().foregroundColor(Color(.fireOrange)).shadow(color: Color(UIColor.mysticBlue.withAlphaComponent(0.6)), radius:3, x: 0, y:0)
                        Text("\(taskItem.duration)'").font(.custom("AvenirNext-Medium", size: 30)).foregroundColor(Color(UIColor.mysticBlue)).background(Color.clear).shadow(color: Color(UIColor.mysticBlue.withAlphaComponent(0.4)), radius:2, x: 0, y: 2)
                        Spacer()
                    }.background(Color.clear).frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 20, maxHeight: 40, alignment: .leading)
                }.background(Color.clear).padding(EdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 20))
                
            }.listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)).frame(height: 200).listRowBackground(Color.clear)
        }.background(Color.clear)
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

