
import SwiftUI

struct GetStartedView: View {
    
    @State var didShowAuth = false
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.colorFF6C42,.colorF14279, .colorPrimary ]),startPoint: .top, endPoint: .bottom)
            Image("onboard-veg")
                .resizable()
                .scaledToFit()
                .frame(width: width,height: height,alignment: .bottom)
                .offset(y: height * 0.1)
            if !didShowAuth {
                VStack(spacing: 100) {
                    Image("app-logo")
                    startedButton
                }
            } else {
                AuthenticationView()
            }
        }
        .ignoresSafeArea()
        
    }
    
    
    var startedButton: some View {
        Button {
            withAnimation(.easeInOut) {
                didShowAuth.toggle()
            }
        } label: {
            Text("Get Started")
                .euclardCircular(size: 20, weight: .regular)
                .foregroundStyle(Color.gray)
                .background {
                    RoundedRectangle(cornerRadius: 58/2)
                        .foregroundStyle(Color.white)
                        .frame(width: 260,height: 58)
                }
        }
        .frame(width: 260,height: 58)
    }
    
    
}

#Preview {
    GetStartedView()
}
