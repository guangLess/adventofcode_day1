//
//  ContentView.swift
//  Day1_SecretEntrance
//
//  Created by func$ on 10/15/26.
//

import SwiftUI

struct ContentView: View {
    let dotCount = 100
    let dotSize: CGFloat = 5

    var body: some View {
        GeometryReader { geometry in
            let radius = min(geometry.size.width, geometry.size.height) / 2
            ZStack {
                ForEach(0..<dotCount, id: \.self) { i in
                    let angle = Angle(degrees: Double(i) / Double(dotCount) * 360)

                    Circle()
                            .frame(width: dotSize, height: dotSize)
                    .offset(x: radius * cos(angle.radians),
                            y: radius * sin(angle.radians))

                    Text("\(i)")
                        .font(.caption2)
                        .fontWeight(.ultraLight)
                        .offset(x: (radius + 30) * cos(angle.radians),
                                y: (radius + 30) * sin(angle.radians))

                }
            }
            .frame(width: geometry.size.width,
                   height: geometry.size.height)
        }
    }
}

/**

 .offset(x: radius * cos(angle.radians),
 y: radius * sin(angle.radians))

 */

#Preview {
    ContentView().padding(50)
}
