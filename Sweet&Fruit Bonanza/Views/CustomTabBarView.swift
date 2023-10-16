//
//  CustomTabBarView.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 29.09.2023.
//

import SwiftUI

struct CustomTabBarView: View {
    
    @Binding var tabs: Tabs
    
    var body: some View {
        GeometryReader{ proxy in
            VStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .padding()
                        .foregroundColor(Color.yellow.opacity(0.8))
                        .frame(width: proxy.size.width / 1, height: proxy.size.height / 7.5)
                    HStack(spacing: 70) {
                        VStack {
                            if tabs == .game {
                                Image(systemName: "dice.fill")
                                    .font(.title)
                                    .foregroundColor(tabs == .game ? Color.yellow.opacity(0.5) : Color.white)
                                Text("Game")
                                    .font(.custom("ChalkboardSE-Regular", size: 15))
                                    .foregroundColor(tabs == .game ? Color.yellow.opacity(0.5) : Color.white)
                            } else {
                                Image(systemName: "dice.fill")
                                    .font(.title)
                                    .foregroundColor(tabs == .game ? Color.yellow.opacity(0.5) : Color.white)
                            }
                        }.frame(width: proxy.size.width / 5.5, height: proxy.size.height / 12.5)
                            .onTapGesture {
                                withAnimation(Animation.spring()) {
                                    tabs = .game
                                }
                            }
                            .background(tabs == .game ? Color.white : Color.clear)
                            .cornerRadius(20)
                        VStack {
                            if tabs == .saved {
                                Image(systemName: "bookmark.fill")
                                    .font(.title)
                                    .foregroundColor(tabs == .saved ? Color.yellow.opacity(0.5) : Color.white)
                                Text("Saved")
                                    .font(.custom("ChalkboardSE-Regular", size: 15))
                                    .foregroundColor(tabs == .saved ? Color.yellow.opacity(0.5) : Color.white)
                            } else {
                                Image(systemName: "bookmark.fill")
                                    .font(.title)
                                    .foregroundColor(tabs == .saved ? Color.yellow.opacity(0.5) : Color.white)
                            }
                        }.frame(width: proxy.size.width / 6.0, height: proxy.size.height / 12.5)
                            .onTapGesture {
                                withAnimation(Animation.spring()) {
                                    tabs = .saved
                                }
                            }
                            .background(tabs == .saved ? Color.white : Color.clear)
                            .cornerRadius(20)
                        VStack {
                            if tabs == .progres {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .font(.title)
                                    .foregroundColor(tabs == .progres ? Color.yellow.opacity(0.5) : Color.white)
                                Text("Images")
                                    .font(.custom("ChalkboardSE-Regular", size: 15))
                                    .foregroundColor(tabs == .progres ? Color.yellow.opacity(0.5) : Color.white)
                            } else {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .font(.title)
                                    .foregroundColor(tabs == .progres ? Color.yellow.opacity(0.5) : Color.white)
                            }
                        }.frame(width: proxy.size.width / 5.5, height: proxy.size.height / 12.5)
                            .onTapGesture {
                                withAnimation(Animation.default) {
                                    tabs = .progres
                                }
                            }
                            .background(tabs == .progres ? Color.white : Color.clear)
                            .cornerRadius(20)
                    }
                }
            }
        }
    }
}

