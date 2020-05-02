//
//  GlobalSingleton.swift
//  Designers Workshop
//
//  Created by Jeff Lebrun on 5/2/20.
//  Copyright © 2020 Designers Workshop. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import DesignersWorkshopLibrary

class GlobalSingleton: ObservableObject {
	@Published var document: UIDocument? = nil
	@Published var user: User? = nil
}
