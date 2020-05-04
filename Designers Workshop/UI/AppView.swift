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
			ContentView()
				.environmentObject(gs)
				.tabItem {
					Text("Content")
					Image(systemName: "doc.richtext")
			}
			
			// Submit Your Sketch.
			HomeView()
				.environmentObject(gs)
				.tabItem {
					Text("Submit Your sketch")
					Image(systemName: "square.and.arrow.up.fill")
			}
			
			// Store.
			HomeView()
				.environmentObject(gs)
				.tabItem {
					Text("Store")
					Image(systemName: "cart.fill")
			}
			
			// About Us.
			HomeView()
				.environmentObject(gs)
				.tabItem {
					Text("About Us")
					Image(systemName: "info.circle.fill")
			}
			
			// My Account.
			HomeView()
				.environmentObject(gs)
				.tabItem {
					Text("My Account")
					Image(systemName: "person.crop.circle.fill")
			}
		}
    }
}

fileprivate struct ContentView_Previews: PreviewProvider {
	static let gs = GlobalSingleton()
	
    static var previews: some View {
		Group {
			AppView().environmentObject(gs).environment(\.colorScheme, .dark)
			AppView().environmentObject(gs).environment(\.colorScheme, .light)
		}
    }
}
