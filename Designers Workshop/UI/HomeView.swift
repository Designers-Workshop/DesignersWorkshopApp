//
//  HomeView.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/2/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import SwiftUI

struct HomeView: View {
	@State private var buttonPressed = false
	
    var body: some View {
		VStack {
			
			// Place a login button on top of the background image.
			ZStack(alignment: .topTrailing) {
				
				Image("Background").resizable()
				
				Button(action: {
					self.buttonPressed.toggle()
				}) {
					// We're either on an iPad...
					if idiom == .pad {
						Text("Login").font(.title)
						
					// ...or on an iPhone.
					} else {
						Text("Login")
					}
				}.round().padding().sheet(isPresented: $buttonPressed) {
					LoginAndSignupView()
				}
			}
		}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.colorScheme, .dark)
    }
}
