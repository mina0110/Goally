//
//  AchievementPopUpView.swift
//  NanoChallenge2
//
//  Created by Minawati on 27/07/22.
//

import SwiftUI

struct AchievementPopUpView: View {
    var body: some View {
        VStack {
            Image("Achievement-Achieved")
                .resizable()
                .scaledToFit()

            Text("Congrats!")
                .font(.system(size: 24, weight: .bold))
                .padding(.bottom, 6)

            Text("You’ve just finish your first task")
                .font(.system(size: 12))
                .padding(.bottom, 6)
        }
    }
}

struct AchievementPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementPopUpView()
    }
}
