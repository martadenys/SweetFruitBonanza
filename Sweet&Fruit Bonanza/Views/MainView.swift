//
//  MainView.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 29.09.2023.
//

import SwiftUI


enum Tabs {
   case game, saved, progres
}

struct MainView: View {
    
    @State private var currentTab: Tabs = .game
    @StateObject var vm: WheelViewModel = WheelViewModel()
    
    var body: some View {
        ZStack {
            TabView(selection: $currentTab ) {
                ContentView(vm: vm)
                    .tag(Tabs.game)
                SavedImagesView(vm: vm)
                    .tag(Tabs.saved)
                ProgresView(vm: vm)
                    .tag(Tabs.progres)
               }
            CustomTabBarView(tabs: $currentTab)
                .ignoresSafeArea(.all, edges: .bottom)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(BackgroundView())
            .onAppear {
                vm.updateImage()
            }
    }
}


