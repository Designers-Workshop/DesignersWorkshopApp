//
//  SwiftUIExtensions.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/2/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import Foundation
import SwiftUI

extension Button {
	func round(by number: CGFloat = 5, withPadding padding: CGFloat = 5) -> some View {
		self.font(.headline).padding(padding).background(Color.blue).cornerRadius(number).foregroundColor(.white)
	}
}
