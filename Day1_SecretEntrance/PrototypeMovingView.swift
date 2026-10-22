//
//  PrototypeMovingView.swift
//  Day1_SecretEntrance
//
//  Created by func$ on 10/21/26.
//

import SwiftUI

/*
struct PrototypeMovingView: View {
    let dotCount = 100
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

                        Creature(angle: angle, radius: radius, time: time, amplitude: amplitude, frequency: frequency)

                        Text("\(i)")
                            .font(.caption2)
                            .fontWeight(.ultraLight)
                            .offset(x: (radius + 30) * cos(angle.radians),
                                    y: (radius + 30) * sin(angle.radians))

                    }

                    Circle()
                        .frame(width: 5, height: 5)
                        .position(center)

                    Needle(center: center, radius: radius, size: geometry.size)
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height)

            }

        }
    }

}



struct Creature: View {
    let dotSize: CGFloat = 5

    let angle: Angle
    let radius: CGFloat
    let time: Double
    let amplitude: CGFloat
    let frequency: Double

    var body: some View {
        let ripple = amplitude
        * sin(frequency * angle.radians - time)
        * cos(time)
        let r = radius + ripple + 30

        Circle()
            .frame(width: dotSize, height: dotSize)
            .offset(x: r * cos(angle.radians),
                    y: r * sin(angle.radians))
    }
}

#Preview {
    PrototypeMovingView()
}
*/
