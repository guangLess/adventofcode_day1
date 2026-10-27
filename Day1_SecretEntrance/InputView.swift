//
//  InputView.swift
//  Day1_SecretEntrance
//

import SwiftUI

struct InputView: View {
    @Binding var selection: Direction
    @Binding var commitedValue: Int

    var dial: Dial

    @State var inputValue: Int? // draft input and committed input

    var numberInString: String {
        switch inputValue {
        case .none: ""
        case .some(let val):
            String(val)
        }
    }

    var body: some View {
        VStack {
            HStack {
                Picker("", selection: $selection) {
                    ForEach(Direction.allCases) { side in
                        Text(side.rawValue)
                            .padding()
                            .tag(side)
                    }
                }
                .pickerStyle(.segmented)
                .tint(.neonGreen)

                TextField(
                    "Number 1 - 99",
                    value: $inputValue,
                    format: .number,
                )
                .textFieldStyle(.roundedBorder)
                .frame(width: 100)
                .onSubmit {
                    if let inputVal = inputValue {
                        commitedValue = inputVal

                        dial.turn(by: inputVal, direction: selection)
                    }
                }
            }
        }
    }
}

struct DailInput {
    let content: Int

    init(input: String?) throws {
        guard let input = input else {
            throw InputError.emptyInput
        }
        guard let inputVal = Int(input) else {
            throw InputError.notAnNumber
        }

        guard (1...99).contains(inputVal) else {
            throw InputError.outOfRange
        }

        self.content = inputVal
    }
}

public enum InputError: Error {
    case emptyInput
    case outOfRange
    case notAnNumber
}

#Preview {
    InputView(selection: .constant(.left), commitedValue: .constant(1), dial: Dial())
}
