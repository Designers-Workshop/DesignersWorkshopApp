//
//  MyAccountView.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/4/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import SwiftUI
import DesignersWorkshopLibrary

struct MyAccountView: View {
	@EnvironmentObject var gs: GlobalSingleton
	
	var sketches: [Sketch]? {
		if gs.user != nil {
			return UDBF.main.getAllSketches(user: gs.user!)
		} else {
			return nil
		}
	}
	
    var body: some View {
		
		return NavigationView {
			
			if gs.user != nil {
			
				List {
					
					// MARK: - My Info.
					Section {
						NavigationLink(destination: Text("Hello, World")) {
							Text("My Info")
						}
					}
					
					// MARK: - My Orders.
					Section(header: Text("My Orders")) {
						
						if gs.orders != nil {
							
							ForEach(0..<gs.orders!.count) { oID in
								
								NavigationLink(destination: OrderDetailView(order: self.gs.orders![oID]).environmentObject(self.gs)) {
									
									Text("Order ID: \(self.gs.orders![oID].id) | Ordered On: \(Misc.main.fomatter(date: self.gs.orders![oID].orderDateTime.date , format: "MM/dd/yyyy, h:mm a"))")
								}
								
							}
							
						} else {
							Text("No Orders.")
						}
					}
					
					// MARK: - My Sketches.
					
					Section(header: Text("My Sketches")) {
						Text("")
					}
				}.id(UUID())
				
				.navigationBarTitle("My Account")
				.listStyle(GroupedListStyle())
			} else {
				Text("Please login or create an account before viewing your account.").font(.subheadline).bold()
			}
		}
		
		.navigationViewStyle(StackNavigationViewStyle())
    }
	
}

struct MyAccountView_Previews: PreviewProvider {
	static let gs = GlobalSingleton()
	
    static var previews: some View {
		MyAccountView().environmentObject(gs)
    }
}
