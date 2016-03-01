//
//  INLThemeService.swift
//  INLThemes
//
//  Created by Tomas Hakel on 01/03/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

import Foundation


public class INLThemeService {

	public class var sharedService: INLThemeService {
		struct Static {
			static var instance = INLThemeService()
		}
		return Static.instance
	}

	var currentTheme: INLTheme?
	var themeConsumers = [INLThemeConsumer]()

	// MARK: - Register theme consumer
	public func registerThemeConsumer(themeConsumer: INLThemeConsumer) {

		themeConsumers.append(themeConsumer)
		if let theme = currentTheme {
			applyTheme(theme, to: themeConsumer)
		}
	}

	public func removeThemeConsumer(themeConsumer: INLThemeConsumer) {

		themeConsumers = themeConsumers.filter { !$0.isEqual(themeConsumer) }
	}

	// MARK: - Apply theme
	public func applyTheme(theme: INLTheme) {

		currentTheme = theme;
		themeConsumers.forEach { applyTheme(theme, to: $0) }
	}

	public func applyTheme(theme: INLTheme, to themeConsumer:INLThemeConsumer) {

		applyTheme(theme, toViews: themeConsumer.themedViews())
	}

	func applyTheme(theme: INLTheme, toViews themedViews:[INLThemedView]) {

		themedViews.forEach {
			if let element = theme.uiElements[$0.elementId] {
				$0.applyTheme(element)
			}
		}
	}

	// MARK: - Convinience
	public class func registerThemeConsumer(themeConsumer: INLThemeConsumer) {
		sharedService.registerThemeConsumer(themeConsumer)
	}

	public class func removeThemeConsumer(themeConsumer: INLThemeConsumer) {
		sharedService.removeThemeConsumer(themeConsumer)
	}

	public class func applyTheme(theme: INLTheme) {
		sharedService.applyTheme(theme)
	}

	public class func applyTheme(theme: INLTheme, to themeConsumer:INLThemeConsumer) {
		sharedService.applyTheme(theme, to: themeConsumer)
	}
}
