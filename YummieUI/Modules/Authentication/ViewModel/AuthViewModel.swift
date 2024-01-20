
import SwiftUI
import Foundation

enum AuthMode:Int {
    case login = 0
    case signup
    case otp
    
  
    
    static var otpCode = ""
}



class AuthViewModel: ObservableObject {
    //MARK: vars
   
    @Published var verificationCode = ""
   
    let manager = CoreDataManager.shared
    @Published var seledctedTab = 0
    
    @Published var email = ""
    @Published var pass  = ""
    @Published var name  = ""
    @Published var phone  = ""
    @Published var confirm  = ""
    
    @Published var otpCode  = ""

    @Published var isLoggedIn = false
    
    @Published var actionText = ""
    
    @Published var authMode:AuthMode = .login {
        didSet {
            seledctedTab = authMode.rawValue
        }
    }
    
    @Published var isLoading = false
    
    @Published var isNotificationEnable = false
    
    @Published var enterValue:[String] = ["","","",""]
    
    @Published var isError = false
    @Published var errorTitle = ""
    @Published var errorMessage = ""
    
    
    //MARK: init
    init() {
        didChangeTab(mode: authMode)
        registerNotification()
    }
    
  
    
    func didChangeTab(mode:AuthMode) {
        DispatchQueue.main.async { [self] in
            authMode = mode
            switch authMode {
            case .login:
                actionText = "Log In"
            case .signup:
                actionText = "Sign Up"
            case .otp:
                actionText = "Continue"
            }
        }
    
    }
   
    
    func didTapButton() {
        switch authMode {
        case .login:
            didLogin()
        case .signup:
            didTapSignup()
        case .otp:
            didContinue()
        }
    }
   
    
    func didLogin()  {
        if !email.isEmpty && !pass.isEmpty {
            if email.isValidEmail {
                manager.loginWith(email: email, password: pass, completion: { matchedUsers in
                    if matchedUsers.isEmpty {
                        self.showAlert(title: "Email not exist", message: "The email address is not register", actionTitle: "Ok")
                    } else {
                        UserDefaults.standard.set(matchedUsers.first!.uid!.uuidString, forKey: "user_id")
                        self.handleSigningIn()
                    }
                })
                
            } else {
                showAlert(title: "Invalid Email", message: "The email address isn't valid", actionTitle: "Ok")
            }
        } else {
            showAlert(title: "For Login", message: "Please provide email and passowrd", actionTitle: "Ok")
        }
    }
    
    
    func didTapSignup() {
        if !email.isEmpty && !pass.isEmpty && !confirm.isEmpty && !name.isEmpty && !phone.isEmpty {
            if email.isValidEmail {
                if pass.count >= 4 {
                    if pass == confirm {
                        if let alreadyExistUser = self.manager.getUser(email: email) {
                            showAlert(title: "Already Exist", message: "User already exist to database", actionTitle: "Ok")
                        } else {
                            if let user = self.manager.createUser(name: name, email: email, password: pass, phone: phone) {
                                UserDefaults.standard.set(user.uid!.uuidString, forKey: "user_id")
                                self.handleSigningIn()
                            }
                        }
                       
                    } else {
                        showAlert(title: "Password", message: "Your password and confirm password doesn't match", actionTitle: "Ok")
                    }
                } else {
                    showAlert(title: "Password", message: "Please provide atleast 4 digit passowrd", actionTitle: "Ok")
                }
               
            } else {
                showAlert(title: "Invalid Email", message: "The email address isn't valid", actionTitle: "Ok")
            }
        } else {
            showAlert(title: "Information missing", message: "Please fill all the fields properly", actionTitle: "Ok")
        }
    }
    
    func showAlert(title:String,message:String,actionTitle:String) {
        isError.toggle()
        errorTitle = title
        errorMessage = message
    }
    
    
    func didContinue() {
        if isNotificationEnable {
            isLoggedIn.toggle()
        } else {
            let givenOTP = enterValue.map({$0}).joined()
            if givenOTP == otpCode {
                isLoggedIn.toggle()
            } else {
                showAlert(title: "OTP", message: "Your OTP code is not correct please try again", actionTitle: "Ok")
            }
        }
    }
    
    
    func handleSigningIn() {
        isLoading = true
        self.scheduleNotification()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 0.2) {
            } completion: { _ in
                self.authMode = .otp
                self.otpCode = AuthMode.otpCode
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    if self.isNotificationEnable {
                        self.isLoading = false
                    } else {
                        self.isLoading = false
                    }
                }
            }
        }
    }
    
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Yummie"
        let otp = generateRandomOTP()
        content.body = "Your OTP is \(otp)"
        let numberString = String(otp)
        AuthMode.otpCode = numberString
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.0, repeats: false)
        
        let request = UNNotificationRequest(identifier: "ForegroundNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    func generateRandomOTP() -> Int {
        let min = 1000
        let max = 9999
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
    
    func registerNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    self.isNotificationEnable = granted
                }
               
            } else {
                print("Notification permission denied: \(error?.localizedDescription ?? "")")
            }
        }
    }
    
   
}

