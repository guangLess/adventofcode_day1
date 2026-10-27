//
//  InputView.swift
//  Day1_SecretEntrance
//

import SwiftUI

struct InputView: View {
    @Binding var selection: Direction
    @Binding var commitedValue: DailInput?
    @State var inputValue: Int?

    var dial: Dial

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
                    do {
                        let inputVal = try DailInput(input: inputValue.map(String.init))
                        commitedValue = inputVal
                        dial.turn(by: inputVal.content, direction: selection)
                    } catch {
                        // todo: error handle text in the input box
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
    InputView(selection: .constant(.left), commitedValue: .constant(try! DailInput(input: "2")), dial: Dial())
}
