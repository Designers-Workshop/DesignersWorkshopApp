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
import ASCollectionView

struct StoreView: View {
	@EnvironmentObject var gs: GlobalSingleton
	
	@State var selectedItems: Set<Int> = []
	
	let items = MDBF.main.getProducts()
	
	var section: ASSection<Int> {
		ASSection(id: 0,
				  data: items,
				  dataID: \.self,
				  selectedItems: $selectedItems,
				  shouldAllowSelection: { _ in return true },
				  shouldAllowDeselection: { _ in return true }
		) { product, state in
			
			if state.isSelected {
				VStack {
					
					Image(data: product.image!)
					Text("\(product.name), $\(String(format: "%.2f", product.price))")
					Text("Selected!")
				
				}
			} else {
				VStack {
					Image(data: product.image!).resize()
					Text("\(product.name), $\(String(format: "%.2f", product.price))")
				}
			}
		}
	}
	
    var body: some View {
		VStack {
			ASCollectionView(section: section).layout {
				.grid(layoutMode: .adaptive(withMinItemSize: 100),
					  itemSpacing: 5,
					  lineSpacing: 5,
					  itemSize: .absolute(300))
			}
			
			Button("Order") { self.order() }.round()
		}
    }
	
	func order() {
		for index in selectedItems {
			print(items[index].name)
		}
	}
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}
