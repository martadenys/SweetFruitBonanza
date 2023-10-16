//
//  ProgresView.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 29.09.2023.
//

import SwiftUI

struct ProgresView: View {
    
    @ObservedObject var vm: WheelViewModel
    var columns: [GridItem] = [GridItem(.flexible()),GridItem(.flexible()),]
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                Text("Collect scores to unlock new images")
                    .padding()
                    .font(.custom("ChalkboardSE-Regular", size: 25))
                    .foregroundColor(Color.white)
                    .background(Color.black.opacity(0.5).blur(radius: 5))
                    .multilineTextAlignment(.center)
                    .cornerRadius(15)
                
                LazyVGrid(columns: columns) {
                    ForEach(vm.lockedImages) { image in
                        LockedImageView(vm: vm, image: image)
                            .onAppear {
                                vm.trimCalculate(for: image, scores: vm.returnTotalScores())
                            }
                    }
                    
                }.background(Color.black.opacity(0.5).blur(radius: 5))
                    .cornerRadius(20)
                Text("Total scores: \(vm.returnTotalScores())")
                    .padding()
                    .font(.custom("ChalkboardSE-Regular", size: 25))
                    .foregroundColor(Color.white)
                    .background(Color.black.opacity(0.5).blur(radius: 5))
                    .multilineTextAlignment(.center)
                    .cornerRadius(15)
            }.onAppear {
                vm.getScores()
            }
        }.padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(BackgroundView())
    }
}




