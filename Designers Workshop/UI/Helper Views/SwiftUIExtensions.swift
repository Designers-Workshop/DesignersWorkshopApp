//
//  SwiftUIExtensions.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/2/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
	func round(by number: CGFloat = 5, withPadding padding: CGFloat = 5, withColor color: Color = .blue, withTextColor textColor: Color = .white) -> some View {
		self.font(.headline).padding(padding).background(color).cornerRadius(number).foregroundColor(textColor)
	}
}

extension Image {
	init(data: Data) {
		self.init(uiImage: UIImage(data: data)!)
		
	}
	
	init(url: URL) {
		self.init(data: try! Data(contentsOf: url))
	}
	
	func resize(width: CGFloat = 250, height: CGFloat = 250) -> some View {
		self.resizable().aspectRatio(contentMode: .fit).frame(maxWidth: width, maxHeight: height)
	}
}
