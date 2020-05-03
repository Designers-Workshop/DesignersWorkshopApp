//
//  DBVCW.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/2/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import Foundation
import SwiftUI

struct DBVCW: UIViewControllerRepresentable {
	@EnvironmentObject var gs: GlobalSingleton
	
	func updateUIViewController(_ uiViewController: DocumentBrowserViewController, context: Context) {
		
	}
	
	func makeUIViewController(context: Context) -> DocumentBrowserViewController {
		
		let d = DocumentBrowserViewController()
		d.gs = gs
		return d
	}
}
