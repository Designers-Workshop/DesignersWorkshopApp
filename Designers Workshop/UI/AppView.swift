//
//  AppView.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/2/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import SwiftUI
import DesignersWorkshopLibrary
import PostgresClientKit

struct AppView: View {
	@EnvironmentObject var gs: GlobalSingleton
	
    var body: some View {
		TabView {
			// Home View.
			HomeView()
				.environmentObject(gs)
				.tabItem {
					Text("Home")
				Image(systemName: "house.fill")
			}
			
			// Content.
			ContentListView()
				.environmentObject(gs)
				.tabItem {
					Text("Content")
					Image(systemName: "doc.richtext")
			}
			
			// Submit Your Sketch.
			SubmitYourSketchView()
				.environmentObject(gs)
				.tabItem {
					Text("Submit Your Sketch")
					Image(systemName: "square.and.arrow.up.fill")
			}
			
			// Store.
			StoreView()
				.environmentObject(gs)
				.tabItem {
					Text("Store")
					Image(systemName: "cart.fill")
			}
			
			// My Account.
			MyAccountView()
				.environmentObject(gs)
				.tabItem {
					Text("My Account")
					Image(systemName: "person.crop.circle.fill")
			}
		}
    }
}

struct AppView_Previews: PreviewProvider {
	static let gs = GlobalSingleton()
	
    static var previews: some View {
		Text("")
    }
}
