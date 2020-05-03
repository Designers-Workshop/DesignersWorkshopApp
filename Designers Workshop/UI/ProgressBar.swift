//
//  ProgressBar.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/3/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
	@Binding var value: Float
	
	var body: some View {
		GeometryReader { geometry in
			ZStack(alignment: .leading) {
				Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
					.opacity(0.3)
					.foregroundColor(Color(UIColor.gray))
				
				Rectangle().frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
					.foregroundColor(Color(UIColor.systemBlue))
					.animation(.linear)
			}.cornerRadius(45.0)
		}
	}
}

struct ProgressBar_Previews: PreviewProvider {
	static var previews: some View {
		ProgressBar(value: .constant(0.5))
			.frame(height: 5)
			.foregroundColor(.blue)
			.padding()
	}
}
