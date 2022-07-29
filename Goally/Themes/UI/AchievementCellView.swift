//
//  AchievementCellView.swift
//  NanoChallenge2
//
//  Created by Minawati on 24/07/22.
//

import SwiftUI

struct AchievementCellView: View {
    
    var achievementTitle: String
    var achievementDescription: String
    
    var body: some View {
        VStack {
            HStack {
                Image("Achievement-Medal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 62, height: 62)
                
                VStack (alignment: .leading) {
                    Text(achievementTitle)
                        .font(.system(size: 18, weight: .bold))
                        .padding(.bottom, 2)

                    Text(achievementDescription)
                        .font(.system(size: 12))
                        .padding(.bottom, 4)
                        .lineSpacing(5)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                
                Spacer()
            }
        }
    }
}

struct AchievementCellView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementCellView(achievementTitle: "First Task", achievementDescription: "Earn this reward when you finish your first task")
    }
}
