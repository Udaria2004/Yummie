//
//  ContentView.swift
//  YummieUI
//

//    Chan Yu Sing
//    3035930345

//    Udayveer Singh
//    3035918634

//    Ishanvi Mohan
//    3035756311

import SwiftUI

struct ContentView: View {
    
    @Binding var otpValue:String
    @Binding var enterdValue:[String]
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            OTPTextField(numberOfFields: 4, otpValue: $otpValue,enterValue: $enterdValue)
        }
        .padding()
    }
}

//#Preview {
//    ContentView()
//}
