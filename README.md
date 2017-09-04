# IDLocalizationManager
 IDLocalizationManager is a localization manager class (singleon class) for iOS. It is useful to change in-app localization without having to change iOS language.

## Usage :
Try out the included demo project.

## Installation :
-  create a Localizable.strings file for each *.lproj folder (e.g. en.lproj, it.lproj, fr.lproj, de.lproj...)
- import IDLocalizationManager.h in your class
- use as follow :

``` objective-c
NSString *localizedString = [[IDLocalizationManager sharedManager] localizedStringForKey:(@"Hello")]
```
or, much better

``` objective-c
NSString *localizedString = LocalizedString(@"Hello");
```

## Features :
  
 #### 1. Get current language 
   ``` objective-c
NSString *currentLanguageString = [[IDLocalizationManager sharedManager] currentLanguage];
```
or, much better

``` objective-c
NSString *currentLanguageString = IDLocalizationCurrentLanguage;
```

 #### 2. Get default language 
   ``` objective-c
NSString *defaultLanguageString = [[IDLocalizationManager sharedManager] defaultLanguage];
```
or, much better

``` objective-c
NSString *defaultLanguageString = IDLocalizationDefaultLanguage;
```

   #### Set current language
 ``` objective-c
[[IDLocalizationManager sharedManager] setCurrentLanguage:(@"en")];
```
or, much better

``` objective-c
IDLocalizationSetLanguage(@"en");
```
   #### 3. Reset current language to Default language
   ``` objective-c
[[IDLocalizationManager sharedManager] resetCurrentLanguageToDefault];
```
or, much better

``` objective-c
 IDLocalizationResetLanguageToDefault;
```

   #### Get DisplayName language
   
   ``` objective-c
NSString *displayNameString = [[IDLocalizationManager sharedManager] displayNameForLanguage:(@"en")];
```
or, much better

``` objective-c
NSString *displayNameString = IDLocalizationDisplayNameForLanguage(@"en");
```

 #### 4. Get languages supported by app 
   
 ``` objective-c
NSArray *availableLanguages = [[IDLocalizationManager sharedManager] availableLanguagesWithoutBase:true]
```
or, much better

``` objective-c
NSArray *availableLanguages = IDLocalizationAvailableLanguages;
```

## EasyMethods :
Macros are optional but life savier , it makes life easy.
belows are available macros :
``` 
1.LocalizedString(@"Hello")
2.IDLocalizationSetLanguage(@"en")
3.IDLocalizationAvailableLanguages
4.IDLocalizationCurrentLanguage
5.IDLocalizationDefaultLanguage
6.IDLocalizationResetLanguageToDefault
7.IDLocalizationDisplayNameForLanguage(@"en")
```

# License

Licensed under the New BSD License.