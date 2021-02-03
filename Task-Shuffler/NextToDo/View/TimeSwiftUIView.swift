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
    var time: String
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                RoundedRectangle(cornerRadius: metrics.size.height).foregroundColor(Color(color)).shadow(color: Color(UIColor.mysticBlue.withAlphaComponent(0.7)), radius:2, x: 0, y: 2)
                Text(time).foregroundColor(Color(.pearlWhite))
            }
        }
    }
}

struct TimeSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSwiftUIView(color: .opalRed, time: "42:42")
    }
}
