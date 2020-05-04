//
//  ContentView.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/3/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import SwiftUI
import DesignersWorkshopLibrary

struct ContentView: View {
    var body: some View {
		NavigationView {
			List {
				ForEach (0..<10){
					Section(header: Text("\($0)")) {
						ForEach(0..<5) {
							Text(String($0))
						}
					}
				}
				
			}
			.navigationBarTitle("Content")
			.listStyle(GroupedListStyle())
		}
		.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			ContentView().environment(\.colorScheme, .dark)
			ContentView().environment(\.colorScheme, .light)
		}
    }
}
