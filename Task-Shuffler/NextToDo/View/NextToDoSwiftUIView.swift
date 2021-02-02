//
//  NextToDoSwiftUIView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 2/2/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import SwiftUI

struct NextToDoSwiftUIView: View {
    var body: some View {
        List(){
            ZStack(alignment: .topLeading){
                HStack{
                    Spacer()
                    RoundedRectangle(cornerRadius: 20).foregroundColor(Color(UIColor.darkOrange.withAlphaComponent(0.5))).shadow(color: Color(UIColor.mysticBlue.withAlphaComponent(0.5)), radius:5, x: 0, y: 2)
                    Spacer()
                }
                
                VStack (alignment: .leading, spacing: 0){
                    
                    HStack (alignment: .top) {
                        Image(systemName: "largecircle.fill.circle").resizable().scaledToFit().frame(width: 25, height: 25, alignment: .topLeading).foregroundColor(Color(.mysticBlue)).padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                        Text("Nombre de tarea muy largo ocupando todo").font(.custom("AvenirNext-Medium", size: 25)).foregroundColor(Color(UIColor.mysticBlue)).lineLimit(nil).background(Color.clear)
                    }.background(Color.pink)
                    Spacer()
                    HStack (alignment: .center){
                        Image(systemName: "calendar.badge.clock").resizable().scaledToFit().frame(width: 25, height: 25, alignment: .topLeading).foregroundColor(Color(.mysticBlue)).padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                        Text("November 30th").font(.init(UIFont.avenirRegular(ofSize: 20))).foregroundColor(Color(UIColor.mysticBlue))
                    }.background(Color.yellow)
                    Spacer()
                    HStack(alignment: .center){
                        TimeSwiftUIView(color: .opalRed).padding(EdgeInsets(top: 0, leading: 35, bottom: 0, trailing: 20))
                        TimeSwiftUIView(color: .turquesa)
                        Spacer()
                        //Image(systemName: "exclamationmark.circle").resizable().scaledToFit().foregroundColor(Color(.fireOrange)).shadow(color: Color(UIColor.mysticBlue.withAlphaComponent(0.6)), radius:3, x: 0, y:0)
                        Text("180'").font(.custom("AvenirNext-Medium", size: 25)).foregroundColor(Color(UIColor.mysticBlue)).background(Color.clear).shadow(color: Color(UIColor.mysticBlue.withAlphaComponent(0.4)), radius:2, x: 0, y: 2)
                        Spacer()
                    }.background(Color.clear).frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 20, maxHeight: 40, alignment: .leading)
                }.background(Color.clear).padding(EdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25))
                
            }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(height: 200)
        }
    }
}




struct NextToDoSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NextToDoSwiftUIView()
    }
}

