//
//  Document.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/2/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import Foundation
import UIKit

class Doc: UIDocument {
	
	override func contents(forType typeName: String) throws -> Any {
		// Encode your document with an instance of NSData or NSFileWrapper
		return Data()
	}
	
	override func load(fromContents contents: Any, ofType typeName: String?) throws {
		// Load your document from contents
	}
}

