//
//  CodeType.swift
//  OTPTextField
//
//  Created by Josep Cerdá Penadés on 28/8/25.
//

enum CodeType: Int, CaseIterable {
    case four = 4
    case six = 6

    var stringValue: String {
        "\(rawValue) Digit"
    }
}
