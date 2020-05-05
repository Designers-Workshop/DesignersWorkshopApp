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
	@Binding var shouldDisplay: Bool
	
	@State var showDocBrowser = false
	
	@EnvironmentObject var gs: GlobalSingleton
	
	@State var name = ""
	@State var email = ""
	@State var address = ""
	@State var username = ""
	@State var password = ""
	
	/// Login/Sign up progress.
	@State var progress: Float = 0.0
	
	@State var showSuccessView = false
	
	@State var message = ""
	
	/// `True`, if the login/sign up failed.
	@State var failed = false
	
	/// LOS - Login Or Sign Out.
	@State var los = 0
	
	static let authChoices = ["Login", "Sign Up"]
	
	/// `true` if the user can authenticate, `false` otherwise.
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
					Section(header: Text("Info")) {
						TextField("Name: ", text: $name)
						TextField("Email: ", text: $email)
						TextField("Address: ", text: $address)
						TextField("Username: ", text: $username)
						SecureField("Password: ", text: $password)
					}
					
					Section(header: Text("Profile Picture")) {
						if gs.document != nil {
							Image(url: gs.document!.fileURL)
								.resizable()
								.frame(maxWidth: 100, maxHeight: 100)
						} else {
							Image("generic")
								.resizable()
								.frame(maxWidth: 100, maxHeight: 100)
						}
						
						Button(action: { self.showDocBrowser.toggle() }) {
							Text("Choose Image")
						}.round()
					}
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
		}
		.sheet(isPresented: $showSuccessView, content: {
			VStack {
				Text("\(self.failed ? "Failure" : "Success!")").bold().font(.title)
				Text(self.message).font(.headline)
			}
		})
		.sheet(isPresented: $showDocBrowser, content: {
			FilePickerView(isShowing: self.$showDocBrowser).environmentObject(self.gs)
		})
    }
	
	func authenticate() {
		if $los.wrappedValue == 0 {
			let hash = Misc.main.hashPassword(username: username, password: password)
			
			progress = 0.3
			
			gs.user = UDBF.main.logIn(username: username, password: hash)
			gs.orders = UDBF.main.getAllOrders(user: gs.user!)
			
			gs.document = nil
			
			if gs.user != nil {
				progress = 1.0
				showSuccessView.toggle()
				
				message = "Successfully \($los.wrappedValue == 0 ? "logged in" : "signed up.")"
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					self.showSuccessView = false
					self.shouldDisplay = false
				}
			} else {
				progress = 0.0
				
				message = "Invalid Credentials."
				
				failed = true
				
				showSuccessView.toggle()
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					self.showSuccessView = false
					self.failed = false
				}
				
			}
			
		} else {
			let hash = Misc.main.hashPassword(username: username, password: password)
			
			progress = 0.3
			
			var img = Data()
			
			if gs.document != nil {
				img = try! Data(contentsOf: gs.document!.fileURL)
			} else {
				img = UIImage(named: "generic")!.pngData()!
			}
			
			gs.user = UDBF.main.signUp(name: name, email: email, address: address, username: username, password: hash, profilePic: img, dateTimeCreated: Date().postgresTimestampWithTimeZone, zone: TimeZone.current.abbreviation(for: Date()) ?? "EST")
			gs.orders = UDBF.main.getAllOrders(user: gs.user!)
			
			gs.document = nil
			
			if gs.user != nil {
				progress = 1.0
				showSuccessView.toggle()
				
				message = "Successfully \($los.wrappedValue == 0 ? "logged in" : "signed up.")"
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					self.showSuccessView.toggle()
					self.shouldDisplay = false
				}
			} else {
				progress = 0.0
				
				message = "Unable to create your account."
				
				failed = true
				
				showSuccessView.toggle()
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					self.showSuccessView.toggle()
					self.failed = false
				}
				
			}
		}
	}
}

struct LoginAndSignupView_Previews: PreviewProvider {
	static let gs = GlobalSingleton()
    static var previews: some View {
		Text("")
    }
}
