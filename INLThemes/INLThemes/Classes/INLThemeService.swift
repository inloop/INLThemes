//
//  INLThemeService.swift
//  INLThemes
//
//  Created by Tomas Hakel on 01/03/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

import Foundation


@objc
open class INLThemeService: NSObject {
    static let shared = INLThemeService()

	var currentTheme: INLTheme?
	var themeConsumers = [INLThemeConsumer]()

	// MARK: - Register theme consumer
	open func registerThemeConsumer(_ themeConsumer: INLThemeConsumer) {

		themeConsumers.append(themeConsumer)
		if let theme = currentTheme {
			applyTheme(theme, to: themeConsumer)
		}
	}

	open func removeThemeConsumer(_ themeConsumer: INLThemeConsumer) {

		themeConsumers = themeConsumers.filter { !$0.isEqual(themeConsumer) }
	}

	// MARK: - Apply theme
	open func applyTheme(_ theme: INLTheme) {

		currentTheme = theme;
		themeConsumers.forEach { applyTheme(theme, to: $0) }
	}

	open func applyTheme(_ theme: INLTheme, to themeConsumer: INLThemeConsumer) {

		applyTheme(theme, toViews: themeConsumer.themedViews())
	}

	open func applyThemeTo(_ themeConsumer: INLThemeConsumer) {

		if let currentTheme = self.currentTheme {
			applyTheme(currentTheme, to: themeConsumer)
		}
	}

	func applyTheme(_ theme: INLTheme, toViews themedViews:[INLThemedView]) {

		themedViews.forEach {
			if let element = theme.uiElements[$0.elementId] {
				$0.applyTheme(element)
			}
		}
	}

	// MARK: - Convinience
	open class func registerThemeConsumer(_ themeConsumer: INLThemeConsumer) {
		shared.registerThemeConsumer(themeConsumer)
	}

	open class func removeThemeConsumer(_ themeConsumer: INLThemeConsumer) {
		shared.removeThemeConsumer(themeConsumer)
	}

	open class func applyTheme(_ theme: INLTheme) {
		shared.applyTheme(theme)
	}

	open class func applyTheme(_ theme: INLTheme, to themeConsumer:INLThemeConsumer) {
		shared.applyTheme(theme, to: themeConsumer)
	}

	open class func applyThemeTo(_ themeConsumer: INLThemeConsumer) {
		shared.applyThemeTo(themeConsumer)
	}
}
