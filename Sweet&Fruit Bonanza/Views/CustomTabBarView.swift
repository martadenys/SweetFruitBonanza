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
                        .foregroundColor(Color.purple.opacity(0.7))
                        .blur(radius: 6)
                        .frame(width: proxy.size.width / 1, height: proxy.size.height / 7.5)
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.purple,lineWidth: 5)
                        .padding()
                        .frame(width: proxy.size.width / 1, height: proxy.size.height / 7.5)
                    HStack(spacing: 70) {
                        VStack {
                            Image(systemName: "dice.fill")
                                .font(.title)
                                .foregroundColor(tabs == .game ? Color.purple.opacity(0.5) : Color.white)
                                .onTapGesture {
                                    withAnimation(Animation.default) {
                                        tabs = .game
                                    }
                                }
                            Text("Game")
                                .font(.caption2)
                                .foregroundColor(tabs == .game ? Color.purple.opacity(0.5) : Color.white)
                        }.frame(width: proxy.size.width / 5.5, height: proxy.size.height / 12.5)
                        .background(tabs == .game ? Color.white : Color.clear)
                            .cornerRadius(20)
                        VStack {
                            Image(systemName: "bookmark.fill")
                                .font(.title)
                                .foregroundColor(tabs == .saved ? Color.purple.opacity(0.5) : Color.white)
                                .onTapGesture {
                                    withAnimation(Animation.default) {
                                        tabs = .saved
                                    }
                                }
                            Text("Saved")
                                .font(.caption2)
                                .foregroundColor(tabs == .saved ? Color.purple.opacity(0.5) : Color.white)
                        }.frame(width: proxy.size.width / 6.0, height: proxy.size.height / 12.5)
                            .background(tabs == .saved ? Color.white : Color.clear)
                                .cornerRadius(20)
                        VStack {
                            Image(systemName: "mountain.2.fill")
                                .font(.title)
                                .foregroundColor(tabs == .progres ? Color.purple.opacity(0.5) : Color.white)
                                .onTapGesture {
                                    withAnimation(Animation.default) {
                                        tabs = .progres
                                    }
                                }
                            Text("Discover")
                                .font(.caption2)
                                .foregroundColor(tabs == .progres ? Color.purple.opacity(0.5) : Color.white)
                        }.frame(width: proxy.size.width / 5.5, height: proxy.size.height / 12.5)
                            .background(tabs == .progres ? Color.white : Color.clear)
                                .cornerRadius(20)
                    }
                }
            }
        }
    }
}

