//
//  LoginAndSignupView.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/2/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import SwiftUI
import PostgresClientKit
import DesignersWorkshopLibrary

struct LoginAndSignupView: View {
	@EnvironmentObject var gs: GlobalSingleton
	@State var name = ""
	@State var email = ""
	@State var address = ""
	@State var username = ""
	@State var password = ""
	@State var progress: Float = 0.0
	@State var showSuccessView = false
	
	/// LOS - Login Or Sign Out.
	@State var los = 0
	static let authChoices = ["Login", "Sign Up"]
	
	var shouldAuthenticate: Bool {
		if $los.wrappedValue == 0 {
			return !username.isEmpty && !password.isEmpty
		} else {
			return !name.isEmpty && !email.isEmpty && !address.isEmpty && !username.isEmpty && !password.isEmpty
		}
	}
	
    var body: some View {
		VStack {
			
			ProgressBar(value: $progress)
				.frame(height: 5)
				.foregroundColor(.blue)
				.padding()
			
			if $los.wrappedValue == 0 {
				Text("Login").font(.headline).padding()
			} else {
				Text("Sign Up").font(.headline).padding()
			}
			
			Form {
				Section {
					Picker("Login", selection: $los) {
						ForEach(0..<Self.authChoices.count) {
							Text(Self.authChoices[$0])
						}
					}.pickerStyle(SegmentedPickerStyle())
				}
				
				if $los.wrappedValue == 0 {
					TextField("Username: ", text: $username)
					SecureField("Password: ", text: $password)
				} else {
					TextField("Name: ", text: $name)
					TextField("Email: ", text: $email)
					TextField("Address: ", text: $address)
					TextField("Username: ", text: $username)
					SecureField("Password: ", text: $password)
				}
				
				Section {
					if shouldAuthenticate {
						if $los.wrappedValue == 0 {
							Button("Login", action: authenticate).round()
						} else {
							Button("Sign Up", action: authenticate).round()
						}
					} else {
						if $los.wrappedValue == 0 {
							Button("Login", action: authenticate)
								.round(withColor: .gray).disabled(true)
						} else {
							Button("Sign Up") {
								print("Hello, World")
							}.round(withColor: .gray).disabled(true)
						}
						
					}
				}
			}
		}.actionSheet(isPresented: $showSuccessView, content: {
			
			ActionSheet(title: Text("Success!"), message: Text("Successfully \($los.wrappedValue == 0 ? "logged" : "signed") in"), buttons: [.default(Text("Done"))])
		})
    }
	
	func authenticate() {
		if $los.wrappedValue == 0 {
			let hash = Misc.main.hashPassword(username: username, password: password)
			
			progress = 0.3
			
			gs.user = UDBF.main.logIn(username: username, password: hash)
			
			if gs.user != nil {
				progress = 1.0
				showSuccessView = true
				
			}
		} else {
			let hash = Misc.main.hashPassword(username: username, password: password)
			
			progress = 0.3
			
			
			gs.user = UDBF.main.signUp(name: name, email: email, address: address, username: username, password: hash, profilePic: UIImage(named: "generic")!.pngData()!, dateTimeCreated: Date().postgresTimestampWithTimeZone, zone: TimeZone.current.abbreviation(for: Date()) ?? "EST")
			
			if gs.user != nil {
				progress = 1.0
				showSuccessView = true
				
			}
		}
	}
}

struct LoginAndSignupView_Previews: PreviewProvider {
	static let gs = GlobalSingleton()
    static var previews: some View {
		Group {
			LoginAndSignupView().environmentObject(gs).colorScheme(.light)
			LoginAndSignupView().environmentObject(gs).colorScheme(.dark)
		}
    }
}
