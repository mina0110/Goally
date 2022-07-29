//
//  CircularProgressBarView.swift
//  NanoChallenge2
//
//  Created by Minawati on 23/07/22.
//

import SwiftUI

struct CircularProgressBarView: View {
    
    let progress: Int16
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color("MistyRose").opacity(0.5),
                        lineWidth: 13
                    )
            
            Circle()
                .trim(from: 0, to: Double(Double(progress)/100))
                .stroke(
                    Color("MistyRose"),
                    style: StrokeStyle(
                        lineWidth: 13,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }
    }
}

struct CircularProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressBarView(progress: 0)
    }
}
