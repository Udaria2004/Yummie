import SwiftUI

struct AuthenticationView: View {
    
    @StateObject var vm = AuthViewModel()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(Color.white)
                .frame(width: 315,height: 520)
            VStack {
                if vm.seledctedTab < 2 {
                    SegmentView(selectedIndex: $vm.seledctedTab)
                } else {
                    Text("OTP Authentication")
                        .poppins(size: 14, weight: .semibold)
                        .foregroundStyle(Color.black)
                    
                }
               
                TabView(selection: $vm.seledctedTab) {
                    LoginView(email: $vm.email, password: $vm.pass)
                        .tag(0)
                    SignUpView(name: $vm.name, email: $vm.email, phone: $vm.phone, password: $vm.pass, confirm: $vm.confirm)
                        .tag(1)
                    OTPView(otpCode: $vm.otpCode, email: vm.email, enteredValue: $vm.enterValue)
                        .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(width: 270,height: 314)
                actionButton
                    .frame(width: 225,height: 44)
            }
            .frame(width: 315,height: 520)
            .fullScreenCover(isPresented: $vm.isLoggedIn, content: {
                        AppTabView()
            })
            .transition(.opacity)
            .onChange(of: vm.seledctedTab) {  newValue in
                let mode = AuthMode(rawValue: newValue) ?? .login
                vm.didChangeTab(mode: mode)
            }
            .alert(vm.errorTitle, isPresented: $vm.isError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(vm.errorMessage)
            }
            .overlay {
                if vm.isLoading {
                    LoaderView()
                }
            }
        }
       
    }
    
  
    
    var actionButton: some View {
        Button {
            withAnimation {
                vm.didTapButton()
            }
        } label: {
            Text(vm.actionText)
                .foregroundStyle(.white)
                .background {
                    RoundedRectangle(cornerRadius: 22)
                        .foregroundStyle(Color.colorPrimary)
                        .frame(width: 225,height: 44)
                }
        }
        .frame(width: 225,height: 44)
    }
    
}


struct LoginView: View {
    
    @Binding var email:String
    @Binding var password:String
    
    var body: some View {
        VStack {
            UnderlinedTextField(text: $email, placeHolder: "Enter email")
            UnderlinedTextFieldSecure(text: $password, placeHolder: "Password")
        }
    }
}

struct SignUpView: View {
    
    @Binding var name:String
    @Binding var email:String
    @Binding var phone:String
    @Binding var password:String
    @Binding var confirm:String
    
    var body: some View {
        VStack {
            UnderlinedTextField(text: $name, placeHolder: "Full name")
            UnderlinedTextField(text: $email, placeHolder: "Enter email")
            UnderlinedTextField(text: $phone, placeHolder: "Phone number")
            UnderlinedTextFieldSecure(text: $password, placeHolder: "Password")
            UnderlinedTextFieldSecure(text: $confirm, placeHolder: "Confirm password")
        }
    }
}


struct OTPView: View {
    
    @Binding var otpCode:String
    var email:String
    @Binding var enteredValue:[String]
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 2,content: {
                Text("An authentication code has been sent to\n\(email)")
                    .poppins(size: 12, weight: .regular)
                    .foregroundStyle(Color.gray.opacity(0.7))
                    .multilineTextAlignment(.center)
            })
            Spacer()
            OTPTextField(numberOfFields: 4, otpValue: $otpCode, enterValue: $enteredValue)
            HStack {
                Text("Didn't receive the code?")
                    .poppins(size: 12, weight: .regular)
                    .foregroundStyle(.gray.opacity(0.7))
                Text("Resend (60s)")
                    .poppins(size: 12, weight: .regular)
                    .foregroundStyle(.colorPrimary)
            }
            Spacer()
            VStack(spacing: 2) {
                Text("By continue, you agree to our")
                    .poppins(size: 12, weight: .regular)
                    .foregroundStyle(.gray.opacity(0.7))
                Text("Term and Condtions")
                    .poppins(size: 12, weight: .regular)
                    .foregroundStyle(.colorPrimary)
            }
            .padding(.bottom,10)
        }
    }
}



struct SegmentView: View {
    
    @Binding var selectedIndex:Int
    
    var body: some View {
        HStack(spacing: 0) {
            Button {
                withAnimation {
                    selectedIndex = 0
                }
            } label: {
                Text("Log In")
                    .poppins(size: 12, weight: .semibold)
                    .foregroundStyle(selectedIndex == 0 ? Color.white : Color.colorPrimary)
            }
            .frame(width: 225/2,height: 28)
            Button {
                withAnimation {
                    selectedIndex = 1
                }
                
            } label: {
                Text("Sign Up")
                    .poppins(size: 12, weight: .semibold)
                    .foregroundStyle(selectedIndex == 1 ? Color.white : Color.colorPrimary)
            }
            .frame(width: 225/2,height: 28)
        }
        .frame(width: 225,height: 28)
        .onAppear {
            selectedIndex = 0
        }
        .background {
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                .frame(width: 225,height: 28)
                .foregroundStyle(.clear)
                .overlay {
                    HStack {
                        RoundedRectangle(cornerRadius: 14)
                            .frame(width: 225 / 2, height: 28)
                            .foregroundStyle(.colorPrimary)
                            .offset(x: selectedIndex == 0 ? 0 : 225 / 2)
                        Spacer()
                    }
                }
        }
    }
}


struct UnderlinedTextField: View {
    @Binding var text: String
    var placeHolder:String
    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeHolder, text: $text)
                .padding(.vertical, 8)
                .foregroundColor(Color.gray)
                .font(Font.poppins(size: 13, weight: .regular))
                .overlay(
                    RoundedRectangle(cornerRadius: 1)
                        .frame(height: 1)
                        .padding(.top, 35) // Adjust padding as needed
                        .foregroundColor(.gray.opacity(0.2)) // Change the color of the underline as needed
                    , alignment: .bottom
                )
        }
        .frame(height: 40)
    }
}

struct UnderlinedTextFieldSecure: View {
    @Binding var text: String
    @State var isSecure:Bool = true
    var placeHolder:String
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if isSecure {
                    SecureField(placeHolder, text: $text)
                        .padding(.vertical, 8)
                        .foregroundColor(Color.gray)
                        .font(Font.poppins(size: 13, weight: .regular))
                } else {
                    TextField(placeHolder, text: $text)
                        .padding(.vertical, 8)
                        .foregroundColor(Color.gray)
                        .font(Font.poppins(size: 13, weight: .regular))
                }
               
                Button {
                    isSecure.toggle()
                } label: {
                    Image("password-eye")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15,height: 15)
                        .foregroundStyle(isSecure ? .gray.opacity(0.5) : .black)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 1)
                    .frame(height: 1)
                    .padding(.top, 35) // Adjust padding as needed
                    .foregroundColor(.gray.opacity(0.2)) // Change the color of the underline as needed
                , alignment: .bottom
            )
            
        }
        .frame(height: 40)
        
    }
}



#Preview {
    AuthenticationView()
}
