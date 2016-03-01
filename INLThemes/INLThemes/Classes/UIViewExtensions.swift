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
	}
}
