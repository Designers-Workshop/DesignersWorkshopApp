//
//  SubmitYourSketchView.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/4/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import SwiftUI
import DesignersWorkshopLibrary
import PostgresClientKit

struct SubmitYourSketchView: View {
	
	@EnvironmentObject var gs: GlobalSingleton
	
	@State var showDocBrowser: Bool = false
	
	@State var name = ""
	
	var canUpload: Bool { gs.document != nil }
	
    var body: some View {
		
		VStack {
			if gs.user != nil {
				Text("Select a sketch to upload:").padding()
				
				Button(action: { self.showDocBrowser.toggle() }) {
					Text("Choose Sketch")
					}.round().padding()
				
				if gs.document != nil {
					Image(url: gs.document!.fileURL).resize()
				}
				
				Form {
					TextField("Sketch Name: ", text: $name)
					
					if canUpload {
						Button(action: { self.upload() }) {
							Text("Upload")
						}.round().padding()
					} else {
						Button(action: { self.upload() }) {
							Text("Upload")
						}.round(withColor: .gray).disabled(true).padding()
					}
				}
				
				
			} else {
				Text("Please login or create an account before uploading a sketch.").font(.subheadline).bold()
			}
		}.sheet(isPresented: $showDocBrowser, content: {
			FilePickerView(isShowing: self.$showDocBrowser).environmentObject(self.gs)
		})
		
    }
	
	func upload() {
		UDBF.main.uploadFile(user: gs.user!, file: try! Data(contentsOf: gs.document!.fileURL), timestamp: Date().postgresTimestampWithTimeZone, zone: TimeZone.current.abbreviation()!, name: name)
		
		gs.document = nil
		name = ""
	}
}

struct SubmitYourSketchView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			SubmitYourSketchView().environment(\.colorScheme, .dark)
			SubmitYourSketchView().environment(\.colorScheme, .light)
		}
    }
}
