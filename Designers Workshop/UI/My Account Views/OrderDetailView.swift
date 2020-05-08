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
	
	var addDoneButton = false
	
	@Binding var dismissView: Bool
	
	var total: Double {
		var total = 0.0
		
		for product in order.productList {
			total += product.price
		}
		
		return total
	}
	
    var body: some View {
		VStack {
			
			if addDoneButton {
				Button("Done", action: { self.$dismissView.wrappedValue = false }).round().padding()
			}
			
			VStack {
				Text("Order Number: \(String(order.id))").font(.title).bold()
				
				Divider()
				
				// Product List.
				List {
					Section(header: Text("Products: ")) {
						
						ForEach(0..<order.productList.count) { pID in
							HStack {
								Image(data: self.order.productList[pID].image ?? UIImage(named: "Missing")!.pngData()!).resize(width: 200, height: 200)
								
								Spacer()
								
								Text(self.order.productList[pID].name + ",")
								
								Text(String(format: "$%.2f", self.order.productList[pID].price))
							}
						}
					}
				}.frame(maxHeight: 300)
				
				Divider()
				
				// Order details.
				VStack(alignment: .center) {
					Text("Delivered To: \(order.user.address)").font(.system(size: 20))
					Text("Ordered On: \(Misc.main.fomatter(date: order.orderDateTime.date, format: "MM/dd/yyyy, h:mm a"))").font(.system(size: 20))
					Text("Total: \(String(format: "$%.2f", total))").font(.system(size: 20))
				}
				
			}.listStyle(GroupedListStyle())
			
			Spacer()
		}
    }
}

struct OrderDetailView_Previews: PreviewProvider {
	static var gs = GlobalSingleton()
	
	static let order = Order(id: 1, user: User(id: 1, name: "", email: "", address: "", username: "", password: "", dateTimeCreated: Date().postgresTimestampWithTimeZone, zone: "EST", isAdmin: true, profilePic: PostgresByteA(data: Data()), forgotPasswordID: nil), productList: [], orderDateTime: Date().postgresTimestampWithTimeZone, zone: "EST")
	
    static var previews: some View {
		OrderDetailView(order: order, dismissView: .constant(false)).environmentObject(gs)
    }
}
