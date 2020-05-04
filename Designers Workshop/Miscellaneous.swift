//
//  Miscellaneous.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/2/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import DesignersWorkshopLibrary
import SwiftSoup

var idiom: UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }

func extractLinkFromIframe(page: Page) -> String {
	var l: String = ""
	
	do {
		let html: String = page.contents!
		let doc: Document = try SwiftSoup.parse(html)
		guard let link: Element = try doc.select("iframe").first() else { return l }
		
		l = try link.attr("src")
		
	} catch Exception.Error(let type, let message) {
		print(message)
	} catch {
		print("error")
	}
	
	return l
}

func extractText(page: Page) -> String {
	var text: String = ""
	
	do {
		let html: String = page.contents!
		let doc: Document = try SwiftSoup.parse(html)
		guard let t: Elements = try doc.select("p") else { return text }
		
		for c in t {
			text += ((try? c.text()) ?? "") + "\n"
		}
		
	} catch Exception.Error(let type, let message) {
		print(message)
	} catch {
		print("error")
	}
	
	return text
}
