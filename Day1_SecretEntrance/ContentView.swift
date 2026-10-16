//
//  ContentView.swift
//  Day1_SecretEntrance
//
//  Created by func$ on 10/15/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Dail()
            .padding(50)
    }
}

struct Dail: View {
    let dotCount = 100
    let dotSize: CGFloat = 5
    let amplitude: CGFloat = 20
    let frequency: Double = 5

    @State private var lineAngle: Double = 0

    var body: some View {
        TimelineView(.animation) { timeline in

            let time = timeline.date.timeIntervalSinceReferenceDate

            GeometryReader { geometry in
                let radius = min(geometry.size.width, geometry.size.height) / 2
                let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)

                ZStack {
                    ForEach(0..<dotCount, id: \.self) { i in
                        let angle = Angle(degrees: Double(i) / Double(dotCount) * 360)

/*
                        let positionedAngleMove = 3 + 2*cos(angle.radians * 58)


                        let ripple = amplitude * positionedAngleMove * sin(
                            1 * angle.radians - time
                        )

                        let waveB = 60 * sin(120 * angle.radians + time*0.5)

                        let r = radius + ripple + waveB

 */


                        let ripple = amplitude
                                     * sin(frequency * angle.radians - time)
                                     * cos(time)
                        let r = radius + ripple + 30


                        /* wave
                        let waveA = 16 * sin(3 * angle.radians - time * 2)
                        let waveB = 6 * sin(11 * angle.radians + time)

                        let r = radius + waveA + waveB
                         */


                        Circle()
                            .frame(width: dotSize, height: dotSize)
                            .offset(x: r * cos(angle.radians),
                                    y: r * sin(angle.radians))

                        Text("\(i)")
                            .font(.caption2)
                            .fontWeight(.ultraLight)
                            .offset(x: (radius + 30) * cos(angle.radians),
                                    y: (radius + 30) * sin(angle.radians))

                    }

                    Circle()
                        .frame(width: dotSize, height: dotSize)
                        .position(center)

                    Needle(center: center, radius: radius, size: geometry.size)
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height)

            }

        }
    }
}



struct Needle: View {

    let center: CGPoint
    let radius: Double
    let size: CGSize

    @State private var angle: Double = 0

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
        .gesture(
            DragGesture()
                .onChanged { value in
                    let dx = value.location.x - center.x
                    let dy = value.location.y - center.y

                    angle = atan2(dy, dx)
                }
        )

    }
}
/**

 .offset(x: radius * cos(angle.radians),
 y: radius * sin(angle.radians))

 */

#Preview {
    ContentView()
}
