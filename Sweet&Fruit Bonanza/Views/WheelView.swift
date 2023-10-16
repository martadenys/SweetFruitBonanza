import SwiftUI

struct WheelView: View {
    
    @State var rotation: CGFloat = 0.0
    @Binding var currentSegment: String
    @ObservedObject var vm: WheelViewModel
    @Binding var stoped: Bool
    
    var body: some View {
        VStack {
            Wheel(rotation: $rotation, vm: vm)
                .frame(width: 320, height: 320)
                .rotationEffect(.radians(rotation))
            if #available(iOS 15.0, *) {
                Button(action: {
                    if vm.soundEffect {
                        vm.makeClick()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(Animation.spring()) {
                            stoped = true
                            currentSegment = vm.images.randomElement()?.name ?? "no name"
                            vm.addToSlotsArray(for: currentSegment)
                            vm.checkSlotsCapacity()
                        }
                    }
                }, label: {
                    Text("TAKE")
                        .padding()
                        .font(.custom("ChalkboardSE-Regular", size: 30))
                        .foregroundColor(.yellow)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                }).overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.yellow, lineWidth: 3)
                }
                .offset(y: 35)
            } else {
                // Fallback on earlier versions
            }
        }.padding()
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 7).speed(0.1).repeatForever()) {
                    rotation += CGFloat(360)
                }
            }
    }
}

struct Wheel: View {
    
    @Binding var rotation: CGFloat
    @ObservedObject var vm: WheelViewModel

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(vm.images.indices, id: \.self) { index in
                    ZStack {
                        Circle()
                            .inset(by: proxy.size.width / 4)
                            .trim(from: CGFloat(index) * segmentSize, to: CGFloat(index + 1) * segmentSize)
                            .stroke(Color.all[index], style: StrokeStyle(lineWidth: proxy.size.width / 2))
                            .rotationEffect(.radians(.pi * segmentSize))
                            .opacity(0.8)
                        label(text: vm.images[index].name, index: CGFloat(index), offset: proxy.size.width / 2.6)
                    }
                }
            }.overlay(
                Circle()
                    .stroke(Color.yellow, lineWidth: 3)
            )
        }
    }
    
    var segmentSize: CGFloat {
        1 / CGFloat(vm.images.count)
    }
    
    func rotation(index: CGFloat) -> CGFloat {
        (.pi * (2 * segmentSize * (CGFloat(index + 1))))
    }
    
    func label(text: String, index: CGFloat, offset: CGFloat) -> some View {
        Image(text)
            .resizable()
            .frame(width: 70, height: 70 )
            .rotationEffect(.radians(rotation(index: CGFloat(index))))
            .offset(x: cos(rotation(index: index)) * offset, y: sin(rotation(index: index)) * offset)
    }
}

extension Color {
    static var all: [Color] {
        [Color.yellow, .green, .pink, .red, .gray, .orange, .yellow, .purple]
    }
}

