

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct ContentView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @State var message = ""
    @State var alert = ""
    @State var show = ""
    @State var text = "Регистрация еще не пройдена"
    
    var body: some View {
        GeometryReader{metrics in
            VStack {
                Text("Sign UP")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 25)
                    .padding(.top, metrics.size.height / 5)
                VStack(alignment: .leading){
                    Text("Email")
                        .foregroundColor(.gray)
                    TextField("Enter your email", text: $email)
                    Divider()
                }
                VStack(alignment: .leading){
                    Text("Password")
                        .foregroundColor(.gray)
                    SecureField("Enter your password", text: $password)
                    Divider()
                }.padding(.top, 20)
                Button {
                    signUpWithPassword(email: self.email, password: self.password) { Verified, Messages in
                        if(!Verified){
                            self.text = "ошибка"
                        } else {
                            self.text = "Успешно"
                        }
                        
                    }
                } label: {
                    Text("Зарегистрироваться")
                        .frame(width: metrics.size.width,height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }.padding(.top, 50)
                    
                Text("(OR)")
                    .padding(.vertical, 30)
                    .foregroundColor(.gray)
                
                HStack{
                    Text("Don't have an account ?")
                        .foregroundColor(.gray)
                    Button {
                        //
                    } label: {
                        Text("Sign up")
                    }

                }
                Text(self.text)
            }
        }.padding(.horizontal, 20)
            .background(Color.white)
    }
}

func signInWithPassword(email: String, password: String, completition: @escaping (Bool, String) -> Void){
    Auth.auth().signIn(withEmail: email, password: password){ authResult, error in
        if(error != nil){
            completition(false, (error?.localizedDescription)!)
            return
        }
        completition(true, (authResult?.user.email)!)
    }
}

func signUpWithPassword(email: String, password: String, completition: @escaping (Bool, String) -> Void){
    Auth.auth().createUser(withEmail: email, password: password){ authResult, error in
        if(error != nil){
            completition(false, (error?.localizedDescription)!)
            return
        }
        completition(true, (authResult?.user.email)!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
