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
    var body: some View {
		TabView {
			HomeView()
				.tabItem {
				Image(systemName: "house.fill")
			}
			
		}
    }
}

struct ContentView_Previews: PreviewProvider {
	static let gs = GlobalSingleton()
	
    static var previews: some View {
		AppView().environmentObject(gs).environment(\.colorScheme, .dark)
    }
}
