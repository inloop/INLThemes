//
//  INLThemeElement.swift
//  INLThemes
//
//  Created by Tomas Hakel on 01/03/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

import Foundation

extension INLThemeElement {

	public subscript (elementId:String) -> String? {
		return values[elementId] as? String
	}

	public func string(_ elementId: String) -> String? {
		return self[elementId]
	}

	public func number(_ elementId: String) -> Double? {
		guard let number = values[elementId] as? NSNumber
			else { return nil }

		return number.doubleValue
	}

	public func color(_ elementId: String) -> UIColor? {
		guard let color = self[elementId]
			else { return nil }

		return UIColor(hex: color)
	}

	public func image(_ elementId: String) -> UIImage? {
		guard let image = self[elementId]
			else { return nil }

		return INLAssetService.imageNamed(image)
	}

	public func bool(_ elementId: String) -> Bool? {
		guard let number = values[elementId] as? NSNumber
			else { return nil }

		return number.boolValue
	}

	public func font() -> UIFont? {
		guard let fontName = self["font"], let fontSize = self.number("fontSize")
			else { return nil }

		return UIFont(name: fontName, size: CGFloat(fontSize))
	}
}
