//
//  UIViewExtensions.swift
//  INLThemes
//
//  Created by Tomas Hakel on 26/02/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

import UIKit

extension UIButton {

	public override func applyTheme(theme: INLThemeElement) {
		if let color = theme.values["color"] as? String {
			self.imageView!.tintColor = UIColor(hex: color)
		}
		if let backgroundColor = theme.values["backgroundColor"] as? String {
			self.backgroundColor = UIColor(hex: backgroundColor)
		}
		if let textColor = theme.values["textColor"] as? String {
			self.setTitleColor(UIColor(hex: textColor), forState: .Normal)
		}
		if let text = theme.values["text"] as? String {
			self.setTitle(text, forState: .Normal)
		}
		if let image = theme.values["image"] as? String {
			self.setImage(INLAssetService.imageNamed(image), forState: .Normal)
		}
		if let cornerRadius = theme.values["cornerRadius"] as? CGFloat {
			self.layer.cornerRadius = cornerRadius
		}
	}
}
