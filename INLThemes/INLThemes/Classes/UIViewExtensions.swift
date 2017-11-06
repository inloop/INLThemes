//
//  UIViewExtensions.swift
//  INLThemes
//
//  Created by Tomas Hakel on 26/02/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

import UIKit


extension UIButton {
	open override func apply(_ theme: ThemeElement) {
		super.apply(theme)

		if let color = theme.color("color") {
			self.imageView?.tintColor = color
		}
		if let textColor = theme.color("textColor") {
			self.setTitleColor(textColor, for: .normal)
		}
		if let text = theme.string("text") {
			self.setTitle(text, for: .normal)
		}
		if let image = theme.image("image") {
			self.setImage(image, for: .normal)
		}
		if let font = theme.font() {
			self.titleLabel?.font = font
		}
	}
}


extension UICollectionViewCell {
	open override func apply(_ theme: ThemeElement) {
		super.apply(theme)

		if let backgroundColor = theme.color("backgroundColor") {
			let backgroundView = UIView(frame: .zero)
			backgroundView.backgroundColor = backgroundColor
			backgroundView.layer.masksToBounds = true
			self.backgroundView = backgroundView
		}
		if let selectedBackgroundColor = theme.color("selectedBackgroundColor") {
			let backgroundView = UIView(frame: .zero)
			backgroundView.backgroundColor = selectedBackgroundColor
			backgroundView.layer.masksToBounds = true
			self.selectedBackgroundView = backgroundView
		}
	}
}


extension UIImageView {
	open override func apply(_ theme: ThemeElement) {
		super.apply(theme)

		if let image = theme.image("image") {
			self.image = image
		}
	}
}


extension UILabel {
	open override func apply(_ theme: ThemeElement) {
		super.apply(theme)

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
	open override func apply(_ theme: ThemeElement) {
		super.apply(theme)

		if let barTintColor = theme.color("barTintColor") {
			self.barTintColor = barTintColor
		}
	}
}


extension UIPageControl {
	open override func apply(_ theme: ThemeElement) {
		super.apply(theme)

		if let color = theme.color("color") {
			self.currentPageIndicatorTintColor = color
		}
		if let inactiveColor = theme.color("inactiveColor") {
			self.pageIndicatorTintColor = inactiveColor
		}
	}
}


extension UIScrollView {
	open override func apply(_ theme: ThemeElement) {
		super.apply(theme)

		if let useDarkIndicator = theme.bool("useDarkIndicator") {
			self.indicatorStyle = useDarkIndicator ? .black : .white
		}
	}
}

extension UISwitch {
	open override func apply(_ theme: ThemeElement) {
		super.apply(theme)

		if let tintColor = theme.color("tintColor") {
			self.onTintColor = tintColor
		}
	}
}


extension UITabBar {
	open override func apply(_ theme: ThemeElement) {
		super.apply(theme)

		if let barTintColor = theme.color("barTintColor") {
			self.barTintColor = barTintColor
		}
	}
}


extension UITableView {
	open override func apply(_ theme: ThemeElement) {
		super.apply(theme)

		if let separatorColor = theme.color("separatorColor") {
			self.separatorColor = separatorColor;
		}
	}
}


extension UITableViewCell {
	open override func apply(_ theme: ThemeElement) {
		super.apply(theme)

		if let backgroundColor = theme.color("backgroundColor") {
			let backgroundView = UIView(frame: CGRect.zero)
			backgroundView.backgroundColor = backgroundColor
			backgroundView.layer.masksToBounds = true
			self.backgroundView = backgroundView
		}

		if let selectedBackgroundColor = theme.color("selectedBackgroundColor") {
			let backgroundView = UIView(frame: CGRect.zero)
			backgroundView.backgroundColor = selectedBackgroundColor
			backgroundView.layer.masksToBounds = true
			self.selectedBackgroundView = backgroundView
		}
	}
}


extension UITextField {

	open override func apply(_ theme: ThemeElement) {
		super.apply(theme)

		if let text = theme["text"] {
			self.text = text
		}
		if let placeholder = theme["placeholder"] {
			self.placeholder = placeholder
		}
		if let textColor = theme.color("textColor") {
			self.textColor = textColor
		}
		if let inactiveColor = theme.color("placeholderColor"), let placeholder = self.placeholder {
			self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.foregroundColor: inactiveColor])
		}
		if let font = theme.font() {
			self.font = font
		}
	}
}


extension UITextView {
	open override func apply(_ theme: ThemeElement) {
		super.apply(theme)

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
