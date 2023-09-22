//
//  ContentView.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 20.09.2023.
//

import SwiftUI



struct ContentView: View {
    
    @State private var currentSegment: String = ""
    @State private var stoped: Bool = false
    @State private var showSaved: Bool = false
    @StateObject var vm: WheelViewModel = WheelViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    HStack {
                        Button(action: {
                            withAnimation(Animation.spring()) {
                                self.showSaved.toggle()
                                if vm.soundEffect {
                                    vm.makeClick()
                                }
                            }
                        }, label: {
                            Image(systemName: "bookmark")
                                .padding()
                                .foregroundStyle(Color.yellow)
                                .font(.system(size: 25).weight(.bold))
                                .background(
                                Circle()
                                    .foregroundStyle(Color.white)
                                    .overlay {
                                        Circle()
                                            .stroke(Color.yellow,lineWidth: 5)
                                    }
                                )
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            vm.soundEffect.toggle()
                            if vm.soundEffect {
                                vm.makeClick()
                            }
                        }, label: {
                            Image(systemName:vm.soundEffect ? "speaker.wave.2.fill" : "speaker.slash.fill")
                                .padding()
                                .foregroundStyle(Color.yellow)
                                .font(.system(size: 25).weight(.bold))
                                .background(
                                Circle()
                                    .foregroundStyle(Color.white)
                                    .overlay {
                                        Circle()
                                            .stroke(Color.yellow,lineWidth: 5)
                                    }
                                )
                        })
                    }.padding()
                    .offset(y: geo.size.height * -0.40)
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
                        Image("2")
                            .resizable()
                            .frame(width: geo.size.width / 6, height: geo.size.height / 11)
                    }
                  
                    if showSaved {
                        SavedImagesView(vm:vm, closeSaved: $showSaved)
                         
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(BackgroundView())
                .fullScreenCover(isPresented: $stoped, content: {
                    ImageDetailView(image: $currentSegment)
                })
        }
    }
}

/*
#Preview {
    ContentView()
}
*/
