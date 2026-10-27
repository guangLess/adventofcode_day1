//
//  ContentView.swift
//  Day1_SecretEntrance
//
//  Created by func$ on 10/15/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        DialView()
            .padding(50)
    }
}

struct DialView: View {

    let dotCount = 100
    @State private var lineAngle: Double = 0

    @State var direction: Direction = .left
    @State var numberOfStep: DailInput?
    @State var dial = Dial()

    var body: some View {
        VStack(alignment: .trailing, spacing: 8) {
            dialGeometryView()
            .frame(minWidth: 200, minHeight: 200)

            InputView(selection: $direction,
                      commitedValue: $numberOfStep,
                      dial: dial)
            .border(.green, width: 1)
        }
    }

    @ViewBuilder
    func dialGeometryView() -> some View {
        GeometryReader { geometry in
            let radius = min(geometry.size.width, geometry.size.height) / 2
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)

            ZStack {
                ForEach(0..<dotCount, id: \.self) { i in
                    let angle = Angle(degrees: Double(i) / Double(dotCount) * 360)

                    Text("\(i)")
                        .font(.caption2)
                        .fontWeight(.ultraLight)
                        .offset(x: (radius + 30) * cos(angle.radians),
                                y: (radius + 30) * sin(angle.radians))
                }

                Text("\(dial.code)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(8)
                    .background(Circle().fill(Color.neonGreen))
                    .position(center)

                Needle(center: center, radius: radius, size: geometry.size, angle: dial.angle)
            }
            .frame(width: geometry.size.width,
                   height: geometry.size.height)
            .border(.green, width: 1)
        }
    }
}

struct Needle: View {

    let center: CGPoint
    let radius: Double
    let size: CGSize
    let angle: Double

    var body: some View {
        let maxDistance = sqrt(pow(size.width, 2) + pow(size.height, 2))
        let endpoint = CGPoint(
            x: center.x + maxDistance * cos(angle),
            y: center.y + maxDistance * sin(angle)
        )

        Path { path in
            path.move(to: center)
            path.addLine(to: endpoint)
        }
        .stroke(.pink, lineWidth: 1)
        .contentShape(
            Path { path in
                path.move(to: center)
                path.addLine(to: endpoint)
            }
            .strokedPath(StrokeStyle(lineWidth: radius))
        )
    }
}

extension Color {
    static let neonGreen = Color(red: 57 / 255, green: 255 / 255, blue: 20 / 255)
}

#Preview {
    ContentView()
}
