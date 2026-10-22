//
//  ComputationDailing.swift
//  Day1_SecretEntrance
//
//  Created by func$ on 10/22/26.
//

import Foundation
import SwiftUI

public enum Direction: String, CaseIterable, Identifiable {

    case right
    case left
    public var id: String { rawValue }
}

@Observable
// config of the data structure? how do I call it
final class Dial {
    private(set) var code = 0
    private var numericalCircle: CyclicArray

    var angle: Double = .zero

    init(startIndex: Int = 50, range: [Int] = Array(0..<100)) {
        self.numericalCircle = CyclicArray(startIndex: startIndex,
                                            thisArray: range)
    }

    func dial(number: Int, to direction: Direction) {
        for _ in 1...number {
            switch direction {
            case .right:
                numericalCircle.next()
            case .left:
                numericalCircle.previous()
            }

            if numericalCircle.currentIndex == 0 {
                code += 1
            }
        }
    }

    func rotate(number: Int, direction: Direction) {
        let radiansPerNumber = 2 * Double.pi / 100
        let change = Double(number) * radiansPerNumber
        switch direction {
        case .right:
            angle -= change
        case .left:
            angle += change
        }
    }
}

// Data structure
public struct CyclicArray {

    private let startIndex: Int // set make it inject init later
    private let thisArray: [Int]

    private(set) var currentIndex: Int
    private var lastIndex: Int { // make it more permonent later, like only update it if thisArray is updated
        thisArray.count - 1
    }

    init(startIndex: Int, thisArray: [Int]) {
        self.startIndex = startIndex
        self.thisArray = thisArray

        self.currentIndex = startIndex
    }

    // public
    mutating func next() -> Int {
        var nextIndex = currentIndex + 1

        if nextIndex >= thisArray.count {
            nextIndex = 0
        }
        currentIndex = nextIndex

        return thisArray[nextIndex]
    }

    mutating func previous() -> Int {
        var preIndex = currentIndex - 1

        if preIndex <= 0 {
            preIndex = lastIndex
        }
        currentIndex = preIndex
        return thisArray[currentIndex]
    }

    mutating func reset() {
        currentIndex = startIndex
    }
}
