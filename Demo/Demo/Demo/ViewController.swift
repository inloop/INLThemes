//
//  ViewController.swift
//  Demo
//
//  Created by Tomas Hakel on 25/02/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

import UIKit
import INLThemes

class ViewController: UIViewController {

	override func viewDidLoad() {
        super.viewDidLoad()
		ThemeService.apply(Theme(plist: "GreenTheme"))
        ThemeService.register(self)
	}

	deinit {
        ThemeService.remove(self)
	}

	var i = 0
    
	@IBAction func changeThemeButton() {
		let theme = {
            i += 1
			switch i % 3 {
			case 0: return Theme(plist: "BlueTheme")
			case 1: return Theme(jsonFile: "RedTheme")
			default: return Theme(plist: "GreenTheme")
			}
		}() as Theme

		ThemeService.apply(theme)
	}
}
