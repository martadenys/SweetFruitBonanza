import SwiftUI

struct WheelView: View {
    
    @State var rotation: CGFloat = 0.0
    @Binding var currentSegment: String
    @ObservedObject var vm: WheelViewModel
    @Binding var stoped: Bool
    
    var body: some View {
        VStack {
            Pointer(rotation: $rotation, currentSegment: $currentSegment, vm: vm)
            
            Wheel(rotation: $rotation, vm: vm)
                .frame(width: 350, height: 350)
                .rotationEffect(.radians(rotation))
                .animation(.easeInOut(duration: 1.5), value: rotation)
            
            if #available(iOS 15.0, *) {
                Button(action: {
                    let randomAmount = Double(Int.random(in: 7..<15))
                    rotation += CGFloat(randomAmount)
                    if vm.soundEffect {
                        vm.makeClick()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        withAnimation(Animation.spring()) {
                            stoped = true
                            vm.addToSlotsArray(for: currentSegment)
                            vm.checkSlotsCapacity()
                        }
                    }
                }, label: {
                    Text("START")
                        .padding()
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                        .background(Color.orange)
                        .cornerRadius(20)
                }).overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.purple, lineWidth: 7)
                }
                .offset(y: 45)
            } else {
                // Fallback on earlier versions
            }
        }.padding()
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
                    .stroke(Color.purple, lineWidth: 10)
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

struct Pointer: View {
    
    @Binding var rotation: CGFloat
    @Binding var currentSegment: String
    @ObservedObject var vm: WheelViewModel
    
    var body: some View {
        Triangle()
            .fill(Color.red)
            .frame(width: 25, height: 40)
            .rotationEffect(Angle(degrees: 180))
            .gesture(DragGesture().onChanged { value in
                let angle = atan2(value.location.y, value.location.x)
                rotation = angle
            })
            .onChange(of: rotation) { _ in
                currentSegment = vm.calculateSegment(at: rotation, images: vm.images).name
            }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

extension Color {
    static var all: [Color] {
        [Color.yellow, .green, .pink, .red, .gray, .orange, .yellow, .purple]
    }
}

