//
//  ContentView.swift
//  OTPTextField
//
//  Created by Josep Cerdá Penadés on 28/8/25.
//

import SwiftUI

struct ContentView: View {

    @State private var code: String = ""

    var body: some View {
        VerificationField(type: .six, style: .roundedBorder, value: $code) { result in
            if result.count < 6 {
                return .typing
            } else if result == "123456" {
                return .valid
            } else {
                return .invalid
            }
        }
    }
}

#Preview {
    ContentView()
}
