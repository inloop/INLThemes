//
//  INLThemeService.swift
//  INLThemes
//
//  Created by Tomas Hakel on 01/03/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

import Foundation


@objc(INLThemeService)
open class ThemeService: NSObject {
    static let shared = ThemeService()

	var currentTheme: Theme?
	var themeConsumers = [ThemeConsumer]()

	// MARK: - Register theme consumer
	open func registerThemeConsumer(_ themeConsumer: ThemeConsumer) {

		themeConsumers.append(themeConsumer)
		if let theme = currentTheme {
			applyTheme(theme, to: themeConsumer)
		}
	}

	open func removeThemeConsumer(_ themeConsumer: ThemeConsumer) {

		themeConsumers = themeConsumers.filter { !$0.isEqual(themeConsumer) }
	}

	// MARK: - Apply theme
	open func applyTheme(_ theme: Theme) {

		currentTheme = theme;
		themeConsumers.forEach { applyTheme(theme, to: $0) }
	}

	open func applyTheme(_ theme: Theme, to themeConsumer: ThemeConsumer) {

		applyTheme(theme, toViews: themeConsumer.themedViews())
	}

	open func applyThemeTo(_ themeConsumer: ThemeConsumer) {

		if let currentTheme = self.currentTheme {
			applyTheme(currentTheme, to: themeConsumer)
		}
	}

	func applyTheme(_ theme: Theme, toViews themedViews: [ThemedView]) {

		themedViews.forEach {
			if let element = theme.uiElements[$0.elementId] {
				$0.applyTheme(element)
			}
		}
	}

	// MARK: - Convinience
	open class func registerThemeConsumer(_ themeConsumer: ThemeConsumer) {
		shared.registerThemeConsumer(themeConsumer)
	}

	open class func removeThemeConsumer(_ themeConsumer: ThemeConsumer) {
		shared.removeThemeConsumer(themeConsumer)
	}

	open class func applyTheme(_ theme: Theme) {
		shared.applyTheme(theme)
	}

	open class func applyTheme(_ theme: Theme, to themeConsumer: ThemeConsumer) {
		shared.applyTheme(theme, to: themeConsumer)
	}

	open class func applyThemeTo(_ themeConsumer: ThemeConsumer) {
		shared.applyThemeTo(themeConsumer)
	}
}
