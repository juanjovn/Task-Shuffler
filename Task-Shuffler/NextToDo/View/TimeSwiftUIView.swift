//
//  TimeSwiftUIView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 2/2/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import SwiftUI

struct TimeSwiftUIView: View {
    var color: UIColor
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30).foregroundColor(Color(color)).frame(width:80, height: 30).shadow(color: Color(UIColor.mysticBlue.withAlphaComponent(0.7)), radius:2, x: 0, y: 2)
            Text("42:42").foregroundColor(Color(.pearlWhite))
        }
    }
}

struct TimeSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSwiftUIView(color: .opalRed)
    }
}
