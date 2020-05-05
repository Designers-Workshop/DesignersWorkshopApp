//
//  ContentListView.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/3/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import SwiftUI
import DesignersWorkshopLibrary

struct ContentListView: View {
	
	let pages = MDBF.main.getAllPages()
	let dropdowns = MDBF.main.getAllDropdowns()!
	
    var body: some View {
		
		NavigationView {
			List {
				
				ForEach (0..<self.dropdowns.count) { dID in
					
					Section(header: Text("\(self.dropdowns[dID].name)")) {
						
						ForEach(0..<self.pages.count) { pID in
							
							if self.pages[pID].dropdown.id == self.dropdowns[dID].id {
								
								NavigationLink(destination: ContentDetailView(page: self.pages[pID])) {
									Text(self.pages[pID].title)
								}
								
							} else {
								EmptyView()
							}
							
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

struct ContentListView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			Text("")
		}
    }
}
