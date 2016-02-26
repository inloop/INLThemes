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
		INLThemeService.applyTheme(INLTheme(plist: "GreenTheme"))
		INLThemeService.registerThemeConsumer(self)
	}

	deinit {
		INLThemeService.removeThemeConsumer(self)
	}

	var i = 0
	@IBAction func changeThemeButton() {
		let theme = i++ % 2 == 0 ? "BlueTheme" : "GreenTheme"

		INLThemeService.applyTheme(INLTheme(plist: theme))
	}
}

