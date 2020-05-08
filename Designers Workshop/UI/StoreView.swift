//
//  StoreView.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/7/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import SwiftUI
import PostgresClientKit
import DesignersWorkshopLibrary
import CollectionView

struct StoreView: View {
	@EnvironmentObject var gs: GlobalSingleton
	
	@State var selectedItems: [Product] = []
	
	@State var showReceipt = false
	
	@State var order: Order? = nil
	
	@State var items = MDBF.main.getProducts()
	
	var getOrder: Order {
		self.order ?? Order(id: 0, user: self.gs.user!, productList: [], orderDateTime: Date().postgresTimestampWithTimeZone, zone: "")
	}
	
    var body: some View {
		VStack {
			
			CollectionView(items: $items, selectedItems: $selectedItems, selectionMode: .constant(true)) { item, _ in
				VStack {
					Image(data: item.image!).resize(width: 300, height: 300)
					Text("\(item.name), $\(String(format: "%.2f", item.price))")
				}
			}
			
			Button("Order", action: orderProducts).round().padding()
		}
		.sheet(isPresented: $showReceipt, content: { OrderDetailView(order: self.getOrder, addDoneButton: true, dismissView: self.$showReceipt).environmentObject(self.gs) })
    }
	
	func orderProducts() {
		order = UDBF.main.buyProducts(productList: selectedItems, user: gs.user!, zone: TimeZone.current.abbreviation()!)
		
		gs.orders = UDBF.main.getAllOrders(user: gs.user!)
		
		showReceipt.toggle()
	}
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}
