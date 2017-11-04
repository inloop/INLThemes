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
		INLThemeService.applyTheme(INLTheme(plist: "GreenTheme"))
		INLThemeService.registerThemeConsumer(self)
	}

	deinit {
		INLThemeService.removeThemeConsumer(self)
	}

	var i = 0
    
	@IBAction func changeThemeButton() {
		let theme = {
            i += 1
			switch i % 3 {
			case 0: return INLTheme(plist: "BlueTheme")
			case 1: return INLTheme(jsonFile: "RedTheme")
			default: return INLTheme(plist: "GreenTheme")
			}
		}() as INLTheme

		INLThemeService.applyTheme(theme)
	}
}
