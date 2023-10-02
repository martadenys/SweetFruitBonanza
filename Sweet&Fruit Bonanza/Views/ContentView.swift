//
//  ContentView.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 20.09.2023.
//

import SwiftUI



struct ContentView: View {
    
    @State private var currentSegment: String = ""
    @State private var showInfo: Bool = false
    @State private var stoped: Bool = false
    @ObservedObject var vm: WheelViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
   
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    HStack {
                        Button(action: {
                            withAnimation(Animation.spring()) {
                                if vm.soundEffect {
                                    vm.makeClick()
                                    showInfo.toggle()
                                }
                            }
                        }, label: {
                            if #available(iOS 15.0, *) {
                                Image(systemName: "info.circle")
                                    .padding()
                                    .foregroundStyle(Color.yellow)
                                    .font(.system(size: 25).weight(.bold))
                                    .background(
                                        Circle()
                                            .foregroundColor(Color.white)
                                            .overlay {
                                                Circle()
                                                    .stroke(Color.yellow,lineWidth: 5)
                                            }
                                    )
                            } else {
                                // Fallback on earlier versions
                            }
                        }).padding(5)
                        SlotsGrid(proxy: geo, vm: vm)
                        Button(action: {
                            vm.soundEffect.toggle()
                            if vm.soundEffect {
                                vm.makeClick()
                            }
                        }, label: {
                            if #available(iOS 15.0, *) {
                                Image(systemName:vm.soundEffect ? "speaker.wave.2.fill" : "speaker.slash.fill")
                                    .padding()
                                    .foregroundColor(Color.yellow)
                                    .font(.system(size: 25).weight(.bold))
                                    .background(
                                        Circle()
                                            .foregroundColor(Color.white)
                                            .overlay {
                                                Circle()
                                                    .stroke(Color.yellow,lineWidth: 5)
                                            }
                                    )
                            } else {
                                // Fallback on earlier versions
                            }
                        }).frame(width: 70)
                    }.padding()
                    .offset(y: geo.size.height * -0.40)
                    .blur(radius: vm.isBonus || showInfo ? 10 : 0)
                    if verticalSizeClass == .compact {
                        Group {
                            WheelView(currentSegment: $currentSegment, vm: vm, stoped: $stoped)
                                .scaleEffect(0.5)
                            Image("2")
                                .resizable()
                                .frame(width: geo.size.width / 15, height: geo.size.height / 11)
                        }.offset(y: geo.size.height / -5)
                    } else if verticalSizeClass == .regular {
                        WheelView(currentSegment: $currentSegment, vm: vm, stoped: $stoped)
                            .blur(radius: vm.isBonus || showInfo  ? 10 : 0)
                        Image("2")
                            .resizable()
                            .frame(width: geo.size.width / 6, height: geo.size.height / 11)
                    }
                  
                      if vm.isBonus {
                        withAnimation(Animation.spring()) {
                            BonusBannerView(vm: vm, proxy: geo)
                                .onAppear {
                                    vm.winSound()
                                }
                        }
                      } else if showInfo {
                          InfoCardView(showInfo: $showInfo, vm: vm)
                      }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(BackgroundView())
                .fullScreenCover(isPresented: $stoped, content: {
                    ImageDetailView(image: $currentSegment, vm: vm)
                })
        }
    }
}

/*
#Preview {
    ContentView(vm: WheelViewModel())
}

*/
