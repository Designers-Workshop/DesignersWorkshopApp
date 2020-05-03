//
//  HomeView.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/2/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import SwiftUI
import PostgresClientKit
import DesignersWorkshopLibrary

struct HomeView: View {
	@EnvironmentObject var gs: GlobalSingleton
	@State private var showLoginView = false
	
    var body: some View {
		ZStack {
			VStack {
				
				// Place a login button on top of the background image.
				ZStack(alignment: .topTrailing) {
					
					Image("Background").resizable()
					
					Button(action: {
						self.showLoginView.toggle()
					}) {
						
						// A user is signed in...
						if gs.user == nil {
							// We're either on an iPad...
							if idiom == .pad {
								Text("Sign Up/Login").font(.title)
								
								// ...or on an iPhone.
							} else {
								Text("Sign Up/Login")
							}
							
						// Or they are not singed in.
						} else {
							// We're either on an iPad...
							if idiom == .pad {
								Text("Log Out").font(.title)
								
								// ...or on an iPhone.
							} else {
								Text("Log Out")
							}
						}
						
					}.round().padding()
					
				}
			}.sheet(isPresented: $showLoginView) {
				LoginAndSignupView().environmentObject(self.gs)
			}
			
			VStack {
				Text("Designers Workshop").bold().font(.largeTitle).foregroundColor(.white)
				
				Text("Where ideas come to life.").font(.headline).foregroundColor(.white)
			}
		}
    }
}

struct HomeView_Previews: PreviewProvider {
	static let gs = GlobalSingleton()
	
    static var previews: some View {
		//gs.user = User(id: 27, name: "Jeff Lebrun", email: "jeff.a.lebrun@gmail.com", address: "", username: "LebJe", password: "", dateTimeCreated: Date().postgresTimestampWithTimeZone, zone: "EST", isAdmin: true, profilePic: PostgresByteA(data: Data()), forgotPasswordID: nil)
		
		return Group {
			HomeView().environmentObject(gs).environment(\.colorScheme, .dark)
			HomeView().environmentObject(gs).environment(\.colorScheme, .light)
		}
    }
}
