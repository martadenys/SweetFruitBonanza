//
//  BonusBannerView.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 30.09.2023.
//

import SwiftUI

struct BonusBannerView: View {
    
    @ObservedObject var vm: WheelViewModel
    let proxy: GeometryProxy
    
    var body: some View {
        ZStack (alignment: .center) {
                Image("bonus")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
        }.onTapGesture {
            vm.isBonus = false
            vm.slotsArray.removeAll()
        }
    }
}
