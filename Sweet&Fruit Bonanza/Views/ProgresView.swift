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
            VStack {
                HStack {
                    Text("Total scores: \(vm.returnTotalScores())")
                        .padding()
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(Color.white)
                        .background(Color.black.opacity(0.5).blur(radius: 5))
                        .cornerRadius(15)
                    Spacer()
                }
                LazyVGrid(columns: columns) {
                    ForEach(vm.lockedImages) { image in
                        LockedImageView(vm: vm, image: image)
                            .onAppear {
                                vm.trimCalculate(for: image, scores: vm.returnTotalScores())
                            }
                    }
                }.background(Color.black.opacity(0.4).blur(radius: 5))
                    .cornerRadius(20)
            }.onAppear {
                vm.getScores()
            }
        }.padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(BackgroundView())
    }
}

/*
#Preview {
    ProgresView(vm: WheelViewModel())
}
*/


