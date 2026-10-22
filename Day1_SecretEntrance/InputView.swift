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

    let neonGreen = Color(red: 57 / 255, green: 255 / 255, blue: 20 / 255)


    var body: some View {
        VStack {
            HStack {
                /// picker
                Picker("", selection: $selection) {
                    ForEach(Direction.allCases) { side in
                        Text(side.rawValue)
                            .padding()
                            .tag(side)
                    }
                }
                .pickerStyle(.segmented)
                .tint(neonGreen)

                TextField(
                    "Number 1 - 99",
                    value: $inputValue,
                    format: .number,
                    //prompt: Text("1...99")
                )
                .textFieldStyle(.roundedBorder)
                .frame(width: 100)
                .onSubmit {
                    if let inputVal = inputValue {
                        commitedValue = inputVal

                        dial.dial(number: inputVal, to: selection)
                        dial.rotate(number: inputVal, direction: selection)
                    }
                }
            }
            Text("-> \(selection.rawValue + numberInString)" + String(dial.code))
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
