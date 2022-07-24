//
//  Login.swift
//  TheMovieDB
//
//  Created by Mariano Manuel on 7/15/22.
//

import SwiftUI
import CoreData

struct Login: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var appState: AppState
    @ObservedObject var network = Network()
    @State var username: String = ""
    @State var password: String = ""
    @State var editingUsername: Bool = false
    @State var editingPassword: Bool = false
    @State var message1: String = ""
    @State var message2: String = ""
    @State var loading: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        editingUsername = false
                        editingPassword = false
                    }
                VStack {
                    TextField("Username", text: $username)
                        .padding(8)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image(systemName: "person")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                                if editingUsername {
                                    Button(action: {
                                        self.username = ""
                                        editingUsername.toggle()
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    }, label: {
                                        Image(systemName: "multiply.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    })
                                }
                            }
                        )
                        .padding(.horizontal, 10)
                        .onTapGesture {
                            self.editingUsername = true
                        }
                    SecureField("Password", text: $password)
                        .padding(8)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image(systemName: "key")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                                if editingPassword {
                                    Button(action: {
                                        self.password = ""
                                        editingPassword.toggle()
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    }, label: {
                                        Image(systemName: "multiply.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    })
                                }
                            }
                        )
                        .padding(.horizontal, 10)
                        .onTapGesture {
                            self.editingPassword = true
                        }
                    Button {
                        editingUsername = false
                        editingPassword = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        loading = true
                        testLoginAndConnectivity()
                    } label: {
                        Text("Login")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(40)
                    .padding(10)
                    Text(message1)
                        .foregroundColor(.white)
                    Text(message2)
                        .foregroundColor(.white)
                }
                .overlay {
                    if loading {
                        ProgressView()
                            .scaleEffect(3)
                    }
                }
            }
            .navigationTitle(Text("The Movie DB"))
        }
    }
    
    private func testLoginAndConnectivity() {
        message1 = ""
        message2 = ""
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (_) in
            message1 = network.connectionDescription
            loading = false
        }
        if username == "admin" && password == "password" && network.isConnected {
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (_) in
                message2 = "Success"
                appState.loggedIn = true
                loading = false
            }
        } else if username == "admin" && password == "password" && !network.isConnected {
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (_) in
                message2 = ""
                loading = false
            }
        } else if username == "" || password == "" {
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (_) in
                message2 = "Enter username and password."
                loading = false
            }
        } else {
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (_) in
                message2 = "Incorrect username or password. Try Again."
                loading = false
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
