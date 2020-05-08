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
	@State var showLoginView = false
	
    var body: some View {
		ZStack {
			VStack {
				
				// Place a login button on top of the background image.
				ZStack(alignment: .topTrailing) {
					
					Image("Background").resizable()
					
					Button(action: {
						if self.gs.user == nil {
							self.showLoginView.toggle()
						} else {
							self.gs.user = nil
							UserDefaults().set(0, forKey: "UserID")
						}
						
					}) {
						
						// A user is signed in...
						if gs.user == nil {
							// We're either on an iPad...
							if idiom == .pad {
								Text("Sign Up/Login").font(.system(size: 20))
								
								// ...or on an iPhone.
							} else {
								Text("Sign Up/Login")
							}
							
						// Or they are not signed in.
						} else {
							// We're either on an iPad...
							if idiom == .pad {
								Text("Log Out").font(.system(size: 20))
								
								// ...or on an iPhone.
							} else {
								Text("Log Out")
							}
						}
						
					}.round().padding()
					
				}
			}.sheet(isPresented: $showLoginView) {
				LoginAndSignupView(shouldDisplay: self.$showLoginView).environmentObject(self.gs)
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
		Text("")
    }
}
