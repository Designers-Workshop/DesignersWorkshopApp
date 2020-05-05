//
//  FilePickerView.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/4/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import SwiftUI

struct FilePickerView: View {
	@EnvironmentObject var gs: GlobalSingleton
	@Binding var isShowing: Bool
	
    var body: some View {
		VStack {
			Button(action: {
				self.isShowing = false
			}) {
				Text("Done")
			}.round().padding()
			
			DBVCW().environmentObject(self.gs)
		}
    }
}

struct FilePickerView_Previews: PreviewProvider {
    static var previews: some View {
		FilePickerView(isShowing: .constant(false))
    }
}
