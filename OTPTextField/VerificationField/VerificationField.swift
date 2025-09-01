//
//  VerificationField.swift
//  OTPTextField
//
//  Created by Josep Cerdá Penadés on 28/8/25.
//

import SwiftUI

struct VerificationField: View {

    var type: CodeType
    var style: TextFieldStyle = .roundedBorder
    @Binding var value: String

    // Validate the typed code
    var onChange: (String) async -> TypingState

    // View properties
    @State private var state: TypingState = .typing
    @FocusState private var isActive: Bool

    var body: some View {
        HStack(spacing: style == .roundedBorder ? 6 : 10) {
            ForEach(0..<type.rawValue, id: \.self) { index in
                CharacterView(index)
            }
        }
        .compositingGroup()
        .background {
            TextField("", text: $value)
                .focused($isActive)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .mask(alignment: .trailing) {
                    Rectangle()
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                }
                .allowsTightening(false)
        }
        .contentShape(.rect)
        .onTapGesture {
            isActive = true
        }
        .onChange(of: value) { oldValue, newValue in
            value = String(newValue.prefix(type.rawValue))
            Task {
                state = await onChange(value)
            }
        }
    }
}

// MARK: Methods

private extension VerificationField {

    // Individual character view
    @ViewBuilder
    func CharacterView(_ index: Int) -> some View {
        Group {
            if style == .roundedBorder {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor(index), lineWidth: 1.2)
            } else {
                Rectangle()
                    .fill(borderColor(index))
                    .frame(height: 1)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .frame(width: style == .roundedBorder ? 50 : 40, height: 50)
        .overlay {
            // Character
            let stringValue = string(index)
            if stringValue != "" && stringValue.allSatisfy(\.isNumber) {
                Text(stringValue)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .transition(.blurReplace)
            }
        }
    }

    func string(_ index: Int) -> String {
        if value.count > index {
            let startIndex = value.startIndex
            let stringIndex = value.index(startIndex, offsetBy: index)
            return String(value[stringIndex])
        }
        return ""
    }

    func borderColor(_ index: Int) -> Color {
        switch state {
        case .typing: .gray
        case .valid: .green
        case .invalid: .red
        }
    }
}
