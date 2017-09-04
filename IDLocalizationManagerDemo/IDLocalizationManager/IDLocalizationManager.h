//
//  IDLocalizationManager.h
//  Singleton IDLocalizationManager
//
//  Created by Deepak on 09/06/17.
//  Copyright © 2017 InsanelyDeepak. All rights reserved.
//

#import <Foundation/Foundation.h>
#define IDLanguageChangeNotification @"IDLanguageChangeNotification"
#define IDCurrentLanguageKey         @"IDCurrentLanguageKey"
#define IDDefaultLanguage            @"en"


// macros (optional, but makes life easy)
// Use "LocalizedString(key)" the same way you would use "NSLocalizedString(key,comment)"
#define LocalizedString(key) [[IDLocalizationManager sharedManager] localizedStringForKey:(key)]

// "language" can be "en", "en-US", "english"
#define IDLocalizationSetLanguage(language) [[IDLocalizationManager sharedManager] setCurrentLanguage:(language)]
#define IDLocalizationAvailableLanguages    [[IDLocalizationManager sharedManager] availableLanguagesWithoutBase:true]
#define IDLocalizationCurrentLanguage       [[IDLocalizationManager sharedManager] currentLanguage]
#define IDLocalizationCurrentIOSLanguageLanguage [[IDLocalizationManager sharedManager] currentIOSLanguage]
#define IDLocalizationDefaultLanguage       [[IDLocalizationManager sharedManager] defaultLanguage]

#define IDLocalizationResetLanguageToDefault  [[IDLocalizationManager sharedManager] resetCurrentLanguageToDefault]
#define IDLocalizationDisplayNameForLanguage(language) [[IDLocalizationManager sharedManager] displayNameForLanguage:(language)]


@interface IDLocalizationManager : NSObject
+ (IDLocalizationManager *)sharedManager;

// this gets the string localized:
- (NSString*)localizedStringForKey:(NSString*) key;
//get availableLanguages:
- (NSArray *)availableLanguagesWithoutBase:(BOOL)excludeBase;
//get Current Defaultlanguage:
- (NSString *)currentLanguage;
//get  Defaultlanguage:
- (NSString *)defaultLanguage;
//get  CurrentIOSLanguage: Detect iOS Language
- (NSString *)currentIOSLanguage;
//reset to Defaultlanguage:
- (void)resetCurrentLanguageToDefault;
//get DisplayName for language:
-(NSString*)displayNameForLanguage:(NSString*)language;
//set a new language:
- (void)setCurrentLanguage:(NSString*)language;

- (NSString *)getlocalized:(NSString*)lang;
@end
