UIFontWDCustomLoader
======
![screenshot](Media/Screenshot-iOS7.png)

You can use UIFontWDCustomLoader category to load any compatible font into your iOS projects at runtime without messing with plist, font unknown names or strange magic.

The only things you'll have to know are your font filenames and this library name.

You can also use this library to load new fonts after app installation. 
##Usage
###Adding font to Project
1. Drag'n drop your font into Xcode project, selecting "Add to Targets" when prompted.
2. Check "Target Membership" of your added font files (File inspector on the right).

If you can't see a font, check under `Build Phases > Copy Bundle Resource`: you must see the font filename listed here.

###Using font

```objective-c
#import "UIFont+WDCustomLoader.h"
```

####One time setup (Explicit registration):

```objective-c
/* FONT COLLECTION FILE (TTC OR OTC) */

// Create an NSURL for your font file: 'Lao MN.ttc'
NSURL *chalkboardFontURL = [[NSBundle mainBundle] URLForResource:@"Lao MN" withExtension:@"ttc"]];

// Do the registration.
NSArray *fontPostScriptNames = [UIFont registerFontFromURL:chalkboardFontURL];

// If everything went ok, fontPostScriptNames will become @[@"LaoMN",@"LaoMN-Bold"] 
// and collection will be registered.
// (Note: On iOS < 7.0 you will get an empty array)

// Then, anywhere in your code, you can do
UIFont *chalkboardFont = [UIFont fontWithName:@"LaoMN" size:18.0f];
```

or    
    
```objective-c
/* SINGLE FONT FILE (TTF OR OTF) */

// Create an NSURL for your font file: 'Lato-Hairline.ttf'
NSURL *latoHairlineFontURL = [[NSBundle mainBundle] URLForResource:@"Lato-Hairline" withExtension:@"ttf"]];

// Do the registration.
NSArray *fontPostScriptNames = [UIFont registerFontFromURL:latoHairlineFontURL];

// If everything went ok, fontPostScriptNames will become @[@"Lato-Hairline"] 
// and collection will be registered.

// Then, anywhere in your code, you can do
UIFont *latoHairlineFont = [UIFont fontWithName:@"Lato-Hairline" size:18.0f];

// or
UIFont *latoHairlineFont = [UIFont customFontWithURL:latoHairlineFontURL size:18.0f];
    
// or (*deprecated*)
UIFont *myCustomFont = [UIFont customFontOfSize:18.0f withName:@"Lato-Hairline" withExtension:@"ttf"];
```

####No setup (Implicit registration)

```objective-c
/* SINGLE FONT (TTF OR OTF) */

// Create an NSURL for your font file: 'Lato-Hairline.ttf'
NSURL *latoHairlineFontURL = [[NSBundle mainBundle] URLForResource:@"Lato-Hairline" withExtension:@"ttf"]];

// Then, anywhere in your code, you can do
UIFont *latoHairlineFont = [UIFont customFontWithURL:latoHairlineFontURL size:18.0f];

// or (*deprecated*)
UIFont *myCustomFont = [UIFont customFontOfSize:18.0f withName:@"Lato-Hairline" withExtension:@"ttf"];
```

**NOTE:** *Font registration will be made on first* `[ UIFont customFont… ]` *method call.*

##Prerequisites
UIFontWDCustomLoader requires:

- ARC
- Deployment target greater or equal to iOS 4.1
- CoreText Framework

This library has been tested with: iOS 5, 6 and 7

##Install
###Basic
Simply download it from [here](https://github.com/daktales/UIFontWDCustomLoader/archive/master.zip) and include it in your project manually.

###GIT submodule
You have the canonical `git submodule` option. Simply issue

    git submodule add https://github.com/daktales/UIFontWDCustomLoader.git <path>

in your root folder of your repository.

###Cocoapods
Nearly done.

##License
This code is distributed under the terms and conditions of the [MIT license](LICENSE). 

##Thanks
The entire idea behind this library came after I see how FlatUIKit loads its fonts. So a big thanks to them. [Link](https://github.com/Grouper/FlatUIKit)