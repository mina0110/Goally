//
//  GoalCardView.swift
//  NanoChallenge2
//
//  Created by Minawati on 23/07/22.
//

import SwiftUI

struct GoalCardView: View {
    
    var emoji: String
    var goalTitle: String
    var goalProgress: Double
    
    var body: some View {
        HStack {

            Text(emoji)
                .font(.system(size: 40))
            
            VStack(alignment: .leading) {
                Text(goalTitle)
                    .font(.system(size: 15, weight: .bold, design: .default))
                    .foregroundColor(.black)
                
                HStack {
                    ProgressView(value: goalProgress)
                        .tint(Color("LightBlue"))
                    
                    Text("\(Int(floor(goalProgress)))%")
                        .font(.system(size: 12))
                        .padding(.bottom, 4)
                        .foregroundColor(Color("DarkGray"))
                }
                
            }
            .padding(.leading, 10)
            
            Spacer()
        }
        .padding(.horizontal, 23)
        .frame(width: 352, height: 76, alignment: .center)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color("LightGray"), lineWidth: 1)

        )
        .padding(.bottom, 7)
    }
}

struct GoalCardView_Previews: PreviewProvider {
    static var previews: some View {
        GoalCardView(emoji: "😥", goalTitle: "Learn Core Data", goalProgress: 0.66)
    }
}
