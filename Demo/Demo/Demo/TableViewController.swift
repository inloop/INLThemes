//
//  TableViewController.swift
//  Demo
//
//  Created by Tomas Hakel on 02/03/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

import UIKit
import INLThemes

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
		INLThemeService.registerThemeConsumer(self)
    }

	deinit {
		INLThemeService.removeThemeConsumer(self)
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!

		INLThemeService.applyThemeTo(cell)

		return cell
	}
}
