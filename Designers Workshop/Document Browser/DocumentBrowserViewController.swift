//
//  DocumentBrowserViewController.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/2/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class DocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate {
	
	var gs: GlobalSingleton? = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		delegate = self
		
		allowsDocumentCreation = true
		allowsPickingMultipleItems = false
		
		// Update the style of the UIDocumentBrowserViewController
		// browserUserInterfaceStyle = .dark
		// view.tintColor = .white
		
		// Specify the allowed content types of your application via the Info.plist.
		
		// Do any additional setup after loading the view.
	}
	
	
	// MARK: UIDocumentBrowserViewControllerDelegate
	
	func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
		let newDocumentURL: URL? = nil
		
		// Set the URL for the new document here. Optionally, you can present a template chooser before calling the importHandler.
		// Make sure the importHandler is always called, even if the user cancels the creation request.
		if newDocumentURL != nil {
			importHandler(newDocumentURL, .move)
		} else {
			importHandler(nil, .none)
		}
	}
	
	func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
		guard let sourceURL = documentURLs.first else { return }
		
		// Present the Document View Controller for the first document that was picked.
		// If you support picking multiple items, make sure you handle them all.
		presentDocument(at: sourceURL)
	}
	
	func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
		// Present the Document View Controller for the new newly created document
		presentDocument(at: destinationURL)
	}
	
	func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
		// Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
	}
	
	// MARK: Document Presentation
	
	func presentDocument(at documentURL: URL) {
		let document = Document(fileURL: documentURL)
		
		// Access the document
		document.open(completionHandler: { success in
			if success {
				if let singleton = self.gs {
					singleton.document = document
				}
			} else {
				// Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
			}
		})
	}
	
	func closeDocument(_ document: Document) {
		dismiss(animated: true) {
			document.close(completionHandler: nil)
		}
	}
}
