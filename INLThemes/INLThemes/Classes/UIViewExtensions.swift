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
		super.applyTheme(theme)

		if let color = theme.color("color") {
			self.imageView?.tintColor = color
		}
		if let textColor = theme.color("textColor") {
			self.setTitleColor(textColor, forState: .Normal)
		}
		if let text = theme.string("text") {
			self.setTitle(text, forState: .Normal)
		}
		if let image = theme.image("image") {
			self.setImage(image, forState: .Normal)
		}
		if let font = theme.font() {
			self.titleLabel?.font = font
		}
	}
}


extension UIImageView {
	public override func applyTheme(theme: INLThemeElement) {
		super.applyTheme(theme)

		if let image = theme.image("image") {
			self.image = image
		}
	}
}


extension UILabel {
	public override func applyTheme(theme: INLThemeElement) {
		super.applyTheme(theme)

		if let text = theme["text"] {
			self.text = text
		}
		if let textColor = theme.color("textColor") {
			self.textColor = textColor
		}
		if let font = theme.font() {
			self.font = font
		}
	}
}


extension UINavigationBar {
	public override func applyTheme(theme: INLThemeElement) {
		super.applyTheme(theme)

		if let barTintColor = theme.color("barTintColor") {
			self.barTintColor = barTintColor
		}
	}
}


extension UIPageControl {
	public override func applyTheme(theme: INLThemeElement) {
		super.applyTheme(theme)

		if let color = theme.color("color") {
			self.currentPageIndicatorTintColor = color
		}
		if let inactiveColor = theme.color("inactiveColor") {
			self.pageIndicatorTintColor = inactiveColor
		}
	}
}


extension UITabBar {
	public override func applyTheme(theme: INLThemeElement) {
		super.applyTheme(theme)

		if let barTintColor = theme.color("barTintColor") {
			self.barTintColor = barTintColor
		}
	}
}

extension UITableView {
	public override func applyTheme(theme: INLThemeElement) {
		super.applyTheme(theme)

		if let separatorColor = theme.color("separatorColor") {
			self.separatorColor = separatorColor;
		}
	}
}


extension UITableViewCell {
	public override func applyTheme(theme: INLThemeElement) {
		super.applyTheme(theme)

		if let selectedBackgroundColor = theme.color("selectedBackgroundColor") {
			let backgroundView = UIView(frame: CGRectZero)
			backgroundView.backgroundColor = selectedBackgroundColor
			backgroundView.layer.masksToBounds = true
			self.selectedBackgroundView = backgroundView
		}
	}
}


extension UITextField {

	public override func applyTheme(theme: INLThemeElement) {
		super.applyTheme(theme)

		if let text = theme["text"] {
			self.text = text
		}
		if let placeholder = theme["placeholder"] {
			self.placeholder = placeholder
		}
		if let textColor = theme.color("textColor") {
			self.textColor = textColor
		}
		if let inactiveColor = theme.color("inactiveColor"), placeholder = self.placeholder {
			self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName: inactiveColor])
		}
		if let font = theme.font() {
			self.font = font
		}
	}
}


extension UITextView {
	public override func applyTheme(theme: INLThemeElement) {
		super.applyTheme(theme)

		if let text = theme["text"] {
			self.text = text
		}
		if let textColor = theme.color("textColor") {
			self.textColor = textColor
		}
		if let font = theme.font() {
			self.font = font
		}
	}
}
