//
//  BlackViewController.swift
//  Demo
//
//  Created by Tomas Hakel on 02/03/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

import UIKit
import INLThemes

class BlackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ThemeService.registerThemeConsumer(self)
    }

	deinit {
		ThemeService.removeThemeConsumer(self)
	}
}
