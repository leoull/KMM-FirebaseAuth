import SwiftUI
import shared

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(spacing: 15.0) {
            ValidatedTextField(
                titleKey: "Username",
                secured: false,
                text: $username,
                errorMessage: "Error",
                onChange: {
                    //TODO: add input validation here
                }
            )
            ValidatedTextField(
                titleKey: "Password",
                secured: true,
                text: $password,
                errorMessage: "Error",
                onChange: {
                    //TODO: add input validation here
                }
            )
            Button("Login") {
                FirebaseAuth().login(user: username, pass: password)
            }
        }
        .padding(.all)
    }
}

class FirebaseAuth {
    let authRepo: FirebaseAuthentication = FirebaseAuthentication()
    func login(user: String, pass: String) {
        authRepo.loginWithEmailAndPass(email: user,password: pass) { result, error in
            guard result != nil, error == nil else {
                print("++Error")
                return
            }
            // Success
            print("++Success", result)
            }
    }
}

struct ValidatedTextField: View {
    let titleKey: String
    let secured: Bool
    @Binding var text: String
    let errorMessage: String?
    let onChange: () -> ()

    @ViewBuilder var textField: some View {
        if secured {
            SecureField(titleKey, text: $text)
        }  else {
            TextField(titleKey, text: $text)
        }
    }

    var body: some View {
        ZStack {
            textField
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .onChange(of: text) { _ in
                    onChange()
                }
            if let errorMessage = errorMessage {
                HStack {
                    Spacer()
                    FieldTextErrorHint(error: errorMessage)
                }.padding(.horizontal, 5)
            }
        }
    }
}

struct FieldTextErrorHint: View {
    let error: String
    @State private var showingAlert = false

    var body: some View {
        Button(action: { self.showingAlert = true }) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error"), message: Text(error), dismissButton: .default(Text("Got it!")))
        }
    }
}
