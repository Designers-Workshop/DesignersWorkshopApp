//
//  ContentDetailView.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/4/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import SwiftUI
import DesignersWorkshopLibrary
import WebKit

struct ContentDetailView: View {
	let page: Page
	
    var body: some View {
		VStack {
			Text(page.title).bold().font(.title).padding()
			
			if page.title == "About Us" {
				Text("""
					
1. We are kids of all ages
					
2. We create amazing designs
					
3. While having fun!
""").font(.headline).padding()
				
			} else if page.title == "Links" {
				Text("Youtube Channel\nOur Email").font(.headline).padding()
			} else {
				if extractText(page: page).isEmpty == true && (page.contents ?? "").contains("img") != true {
					HTMLStringView(url: extractLinkFromIframe(page: page))
				} else {
					Text(extractText(page: page)).font(.headline).padding()
				}
			}
			
			if page.image != nil {
				Image(data: page.image!).resizable().aspectRatio(contentMode: .fit).frame(maxWidth: 250, maxHeight: 250)
			}
		}
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
		Text("")
	}
}

struct HTMLStringView: UIViewRepresentable {
	let url: String
	
	func makeUIView(context: Context) -> WKWebView {
		return WKWebView()
	}
	
	func updateUIView(_ webView: WKWebView, context: Context) {
		// WKWebView setup.
		webView.configuration.allowsInlineMediaPlayback = true
		webView.load(URLRequest(url: URL(string: url)!))
	}
}
