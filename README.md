# INLThemes

## 1. Overview
INLThemes is an iOS library for supporting multiple UI themes.
The themes are stored in either a plist or a json file.

## 2. Setup
### 2.1. Set the elementIds
The framework maps theme attributes in the configuration file (text, colours, fonts, constraints, images) to objects using `elementId`s that identifies specific views. You can use one `elementId` for multiple views (e.g. all buttons).
The `elementId` can be set in storyboards. No subclassing is required - after linking the framework `elementId` will be automatically available for all `UIView`s, `UIBarItem`s and `NSLayoutConstraint`s. See section 3 for details on the configuration files and supported theme attributes.

### 2.2. Apply the theme
First `import INLThemes`.

You can create a theme with the name of your configuration file and then apply it to the application.
```
let theme = INLTheme(plist: “MyTheme")
INLThemeService.applyTheme(theme)
```

For views that are created dynamically (e.g. `UITableViewCell`) use the `applyThemeTo()` method when creating them.
```
INLThemeService.applyThemeTo(newView)
```

### 2.3 Register your view controllers
```
override func viewDidLoad() {
    super.viewDidLoad()
    INLThemeService.registerThemeConsumer(self)
}

deinit {
    INLThemeService.removeThemeConsumer(self)
}
```
This will automatically apply the theme when it changes. It can be done before or after applying the theme. You can also register a `UIView` (e.g. if you can’t subclass a view controller).


## 3. Theme configuration files
The library supports two formats: plist and json. The basic structure for both is a dictionary that maps elementIds to dictionaries of theme attributes. For example:
```
--------- plist ---------
<dict>
	<key>mainVC.topLabel</key>
	<dict>
		<key>textColor</key>
		<string>#ffffff</string>
		<key>font</key>
		<string>Helvetica</string>
		<key>fontSize</key>
		<integer>12</integer>
	</dict>
	<key>mainVC.aButton</key>
	<dict>
		<key>backgroundColor</key>
		<string>#888888</string>
		<key>cornerRadius</key>
		<integer>10</integer>
	</dict>
</dict>
--------- json ---------
{
	"mainVC.topLabel": {
		"textColor": "#ffffff",
		"font": "Helvetica”,
		"fontSize”: 12
	},
	"mainVC.aButton": {
		"backgroundColor": "#888888",
		"cornerRadius": 10
	}
}
```

The following theme attributes are supported:

**UIView:** alpha, backgroundColor, cornerRadius, hidden, tintColor<br>
**UIButton:** color, font, fontSize, image, text, textColor<br>
**UICollectionViewCell:** backgroundColor, selectedBackgroundColor<br>
**UIImageView:** image<br>
**UILabel:** font, fontSize, text, textColor<br>
**UINavigationBar:** barTintColor<br>
**UIPageControl:** color, inactiveColor<br>
**UIScrollView:** useDarkIndicator<br>
**UITabBar:** barTintColor<br>
**UITableView:** separatorColor<br>
**UITableViewCell:** backgroundColor, selectedBackgroundColor<br>
**UITextField:** font, fontSize, placeholderColor, placeholder, text, textColor<br>
**UITextView:** font, fontSize, text, textColor<br>
**UIBarButtonItem:** color, image<br>
**UITabBarItem:** image, selectedImage, title<br>
**NSLayoutConstraint:** active, constant, priority<br>

## 4. Supporting additional properties

If the framework does not support an attribute you’d like to configure or you’d like to use the library for your custom properties, you can override the `applyTheme` method in a subclass. If the object is not a subclass of `UIView`, `UIBarItem` or `NSLayoutConstraint` your class needs to conform to the `INLThemedView` protocol.
