//
//  SubmitYourSketchView.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/4/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

// TODO: Show success view.

import SwiftUI
import DesignersWorkshopLibrary
import PostgresClientKit

struct SubmitYourSketchView: View {
	
	@EnvironmentObject var gs: GlobalSingleton
	
	@State var showDocBrowser: Bool = false
	
	@State var name = ""
	
	@State private var progress: Float = 0.0
	
	var canUpload: Bool { gs.document != nil }
	
    var body: some View {
		
		VStack {
			if gs.user != nil {
				ProgressBar(value: $progress)
					.frame(height: 5)
					.foregroundColor(.blue)
					.padding()
			
				Text("Select a sketch to upload:").padding()
				
				Button(action: { self.showDocBrowser.toggle() }) {
					Text("Choose Sketch")
					}
					.round()
					.padding()
				
				if gs.document != nil {
					Image(url: gs.document!.fileURL).resize()
				}
				
				Form {
					TextField("Sketch Name: ", text: $name)
					
					if canUpload {
						Button(action: {
							
							self.progress = 0.3
							
							UDBF.main.uploadFile(user: self.gs.user!, file: try! Data(contentsOf: self.gs.document!.fileURL), timestamp: Date().postgresTimestampWithTimeZone, zone: TimeZone.current.abbreviation()!, name: self.name)
							
							self.progress = 1.0
							
							self.gs.document = nil
							self.gs.sketches = UDBF.main.getAllSketches(user: self.gs.user!)
							self.name = ""
							
							self.progress = 0.0
						}) {
							Text("Upload")
						}.round()
						
					} else {
						Button(action: {}) {
							Text("Upload")
						}
						.round(withColor: .gray).disabled(true)
						.padding()
					}
				}
				
				
			} else {
				Text("Please login or create an account before uploading a sketch.").font(.subheadline).bold()
			}
		}.sheet(isPresented: $showDocBrowser, content: {
			FilePickerView(isShowing: self.$showDocBrowser).environmentObject(self.gs)
		})
		
    }
	
}

struct SubmitYourSketchView_Previews: PreviewProvider {
    static var previews: some View {
		Text("")
    }
}
