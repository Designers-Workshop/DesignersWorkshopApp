//
//  MyInfoView.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/6/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import SwiftUI
import DesignersWorkshopLibrary
import PostgresClientKit

struct MyInfoView: View {
	@EnvironmentObject var gs: GlobalSingleton
	
	@State private var name = ""
	@State private var email = ""
	@State private var address = ""
	@State private var username = ""
	@State private var password = ""
	
	@State var showDocBrowser = false
	
    var body: some View {
		
		VStack {
			if gs.user != nil {
				Image(data: gs.user!.profilePic.data).resize(width: 300, height: 300).clipShape(Circle())
				
				Form {
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
							Image(data: gs.user!.profilePic.data)
								.resizable()
								.frame(maxWidth: 100, maxHeight: 100)
						}
						
						Button(action: { self.showDocBrowser.toggle() }) {
							Text("Choose New Image")
						}
						.round()
					}
				}
				
				HStack {
					Button("Change Info") {
						self.gs.user = UDBF.main.changeUserInfo(user: User(id: self.gs.user!.id, name: self.name, email: self.email, address: self.address, username: self.username, password: Misc.main.hashPassword(username: self.username, password: self.password), dateTimeCreated: Date().postgresTimestampWithTimeZone, zone: TimeZone.current.abbreviation()!, isAdmin: self.gs.user!.isAdmin, profilePic: PostgresByteA(data: self.gs.document?.fileURL != nil ? try! Data(contentsOf: self.gs.document!.fileURL) : self.gs.user!.profilePic.data), forgotPasswordID: self.gs.user!.forgotPasswordID), oldID: self.gs.user!.id)
						}.round().padding()
					
					Button("Delete Your Account") {
						UDBF.main.deleteUser(user: self.gs.user!)
						self.gs.user = nil
					}
					.round(withColor: .red)
					.padding()
				}
				
				
			} else {
				Text("Please create an account or log in.")
			}
		}
		.sheet(isPresented: $showDocBrowser, content: { FilePickerView(isShowing: self.$showDocBrowser).environmentObject(self.gs) })
		.onAppear(perform: {
			self.name = self.gs.user!.name
			self.email = self.gs.user!.email
			self.address = self.gs.user!.address
			self.username = self.gs.user!.username
			self.password = self.gs.password
		})
		
    }
}

struct MyInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyInfoView()
    }
}
