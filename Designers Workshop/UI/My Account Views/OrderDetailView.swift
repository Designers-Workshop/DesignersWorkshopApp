//
//  OrderDetailView.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/5/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import SwiftUI
import DesignersWorkshopLibrary
import PostgresClientKit

struct OrderDetailView: View {
	@EnvironmentObject var gs: GlobalSingleton
	var order: Order
	
    var body: some View {
		VStack {
			Text("Order Number: \(String(order.id))").font(.title).bold()
			
			Divider()
			
			// Product List.
			List {
				Section(header: Text("Products: ")) {
					
					ForEach(0..<order.productList.count) { pID in
						HStack {
							Image(data: self.order.productList[pID as Int].image ?? UIImage(named: "Missing")!.pngData()!).resize(width: 200, height: 200)
							
							Spacer()
							
							Text(self.order.productList[pID].name + ",")
							
							Text(String(format: "$%.2f", self.order.productList[pID as Int].price))
						}
					}
				}
			}
		}.listStyle(GroupedListStyle())
    }
}

struct OrderDetailView_Previews: PreviewProvider {
	static var gs = GlobalSingleton()
	
	static let order = Order(id: 1, user: User(id: 1, name: "", email: "", address: "", username: "", password: "", dateTimeCreated: Date().postgresTimestampWithTimeZone, zone: "EST", isAdmin: true, profilePic: PostgresByteA(data: Data()), forgotPasswordID: nil), productList: [], orderDateTime: Date().postgresTimestampWithTimeZone, zone: "EST")
	
    static var previews: some View {
		OrderDetailView(order: order).environmentObject(gs)
    }
}
