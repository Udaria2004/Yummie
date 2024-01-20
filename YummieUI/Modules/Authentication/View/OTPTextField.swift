
import SwiftUI

struct OTPTextField: View {
    
    let numberOfFields : Int
    @Binding var enterValue : [String]
    @FocusState private var fieldFocus: Int?
    @State var oldValue = ""
    @Binding var otpValue: String
    
    init(numberOfFields: Int,  otpValue: Binding<String>, enterValue: Binding<[String]>) {
        self.numberOfFields = numberOfFields
        self._otpValue = otpValue
        self._enterValue = enterValue
        //        self.enterValue = Array(repeating: "", count: numberOfFields)
    }
    
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfFields, id: \.self) { index in
                TextField("", text: $enterValue[index], onEditingChanged: { editing in
                    
                    if editing {
                        oldValue = enterValue[index]
                    }
                })
                .frame(width: 60, height: 48, alignment: .center)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(5)
                .multilineTextAlignment(.center)
                .focused($fieldFocus, equals: index)
                .keyboardType(.numberPad)
                .tag(index)
                .onChange(of: enterValue[index]) { newValue in
                    
                    if  enterValue[index].count > 1 {
                        let currentValue = Array(enterValue[index])
                        if currentValue[0] == Character(oldValue) {
                            enterValue[index] = "\(enterValue[index].suffix(1))"
                        } else {
                            enterValue[index] = "\(enterValue[index].prefix(1))"
                        }
                        
                    }
                    if !newValue.isEmpty {
                        if index == numberOfFields - 1 {
                            fieldFocus = nil
                        } else {
                            fieldFocus = (fieldFocus ?? 0) + 1
                        }
                        
                    } else {
                        fieldFocus = (fieldFocus ?? 0) - 1
                    }
                    
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        // Dismiss the keyboard
                        fieldFocus = nil
                    }
                    .padding(.trailing, 20)
                }
            }
            
        }
        
        .onAppear {
            // Fill OTP values when OTP value changes
            for (index, char) in otpValue.enumerated() {
                if index < numberOfFields {
                    enterValue[index] = String(char)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                fieldFocus = nil
            }
        }
    }
}

//#Preview {
//    OTPTextField(numberOfFields: 4, enterValue: [])
//}
