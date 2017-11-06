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
	open func register(_ themeConsumer: ThemeConsumer) {
		themeConsumers.append(themeConsumer)
		if let theme = currentTheme {
			apply(theme, to: themeConsumer)
		}
	}

	open func remove(_ themeConsumer: ThemeConsumer) {
		themeConsumers = themeConsumers.filter { !$0.isEqual(themeConsumer) }
	}

	// MARK: - Apply theme
	open func apply(_ theme: Theme) {
		currentTheme = theme
		themeConsumers.forEach { apply(theme, to: $0) }
	}

	open func apply(_ theme: Theme, to themeConsumer: ThemeConsumer) {
		apply(theme, toViews: themeConsumer.themedViews())
	}

	open func applyTheme(to themeConsumer: ThemeConsumer) {
		if let currentTheme = self.currentTheme {
			apply(currentTheme, to: themeConsumer)
		}
	}

	func apply(_ theme: Theme, toViews themedViews: [ThemedView]) {
		themedViews.forEach {
			if let element = theme.uiElements[$0.elementId] {
				$0.apply(element)
			}
		}
	}

	// MARK: - Convinience
	open class func register(_ themeConsumer: ThemeConsumer) {
        shared.register(themeConsumer)
	}

	open class func remove(_ themeConsumer: ThemeConsumer) {
        shared.remove(themeConsumer)
	}

	open class func apply(_ theme: Theme) {
		shared.apply(theme)
	}

	open class func apply(_ theme: Theme, to themeConsumer: ThemeConsumer) {
		shared.apply(theme, to: themeConsumer)
	}

	open class func applyTheme(to themeConsumer: ThemeConsumer) {
        shared.applyTheme(to: themeConsumer)
	}
}
