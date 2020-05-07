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
	
    var body: some View {
		
		return NavigationView {
			
			if gs.user != nil {
			
				List {
					
					// MARK: - My Info.
					Section {
						NavigationLink(destination: MyInfoView().environmentObject(self.gs)) {
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
						if gs.sketches != nil {
							ForEach(0..<gs.sketches!.count) { sketchID in
								HStack {
									Image(data: self.gs.sketches![sketchID].image).resizable().resize()
									
									Spacer()
									
									Text(self.gs.sketches![sketchID as Int].name)
								}
							}
						} else {
							Text("No Sketches")
						}
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
