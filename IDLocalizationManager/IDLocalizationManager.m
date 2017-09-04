//
//  IDLocalizationManager.h
//  Singleton IDLocalizationManager
//
//  Created by Deepak on 09/06/17.
//  Copyright © 2017 InsanelyDeepak. All rights reserved.
//

#import "IDLocalizationManager.h"
#import "NSBundle+Language.h"


// Singleton
static IDLocalizationManager* sharedManager = nil;

// my Bundle (not the main bundle!)
static NSBundle* myBundle = nil;


@implementation IDLocalizationManager
//-------------------------------------------------------------
// allways return the same singleton
//-------------------------------------------------------------
+ (IDLocalizationManager*) sharedManager {
    // lazy instantiation
    if (sharedManager == nil) {
        sharedManager = [[IDLocalizationManager alloc] init];
    }
    return sharedManager;
}


//-------------------------------------------------------------
// initiating
//-------------------------------------------------------------
- (id) init {
    self = [super init];
    if (self) {
        // use systems main bundle as default bundle
        myBundle = [NSBundle mainBundle];
    }
    return self;
}


//-------------------------------------------------------------
// translate a string
//-------------------------------------------------------------
// you can use this macro:
// LocalizedString(@"Text");
- (NSString*) localizedStringForKey:(NSString*) key {
    // this is almost exactly what is done when calling the macro NSLocalizedString(@"Text",@"comment")
    // the difference is: here we do not use the systems main bundle, but a bundle
    // we selected manually before (see "setLanguage")
    return [self getlocalized:key];
}
-(NSString *)getlocalized:(NSString *)key {
    NSString *currentLanguage  = [self currentLanguage];
    // path to this languages bundle
    NSString *path = [[NSBundle mainBundle] pathForResource:currentLanguage ofType:@"lproj"];
    if (path == nil) {
        // there is no bundle for that language
        // use main bundle instead
        path = [[NSBundle mainBundle] pathForResource:@"Base" ofType:@"lproj"];
        myBundle = [NSBundle bundleWithPath:path];
        return [myBundle localizedStringForKey:key value:@"" table:nil];
    }
    else {
        // use this bundle as my bundle from now on:
        myBundle = [NSBundle bundleWithPath:path];
        // exception : this is probably unnecessary:
        if (myBundle == nil) {
            path = [[NSBundle mainBundle] pathForResource:@"Base" ofType:@"lproj"];
            myBundle = [NSBundle bundleWithPath:path];
        }
        return [myBundle localizedStringForKey:key value:@"" table:nil];
    }
    return @"";
}
//-------------------------------------------------------------
// get all languages
//-------------------------------------------------------------
- (NSArray *)availableLanguagesWithoutBase:(BOOL)excludeBase{
    NSMutableArray *availableLanguages = [[NSMutableArray alloc] initWithArray:[[NSBundle mainBundle] localizations]];
    // If excludeBase = true, don't include "Base" in available languages
     if (excludeBase) {
         NSUInteger indexOfBase = [availableLanguages indexOfObject:@"Base"];
         [availableLanguages removeObjectAtIndex:indexOfBase];
    }
    
    return availableLanguages;
}
//-------------------------------------------------------------
// get Current language
//-------------------------------------------------------------
- (NSString *)currentLanguage{
    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:IDCurrentLanguageKey];
    if (currentLanguage.length > 0 || currentLanguage != nil) {
          return currentLanguage;
    }
    return [self defaultLanguage];
}
//-------------------------------------------------------------
// get Default language
// Returns: The app's default language.
//-------------------------------------------------------------
- (NSString *)defaultLanguage{
    NSString *defaultLanguage ;
    NSString *preferredLanguage = NSBundle.mainBundle.preferredLocalizations.firstObject;
    
    if (preferredLanguage.length > 0 || preferredLanguage != nil) {
        return preferredLanguage ;
    }
    NSArray *availableLanguages = [self availableLanguagesWithoutBase:true];
    if ([availableLanguages containsObject:preferredLanguage]) {
        defaultLanguage   = preferredLanguage;
    }
    else {
        defaultLanguage   = IDDefaultLanguage;
    }
    return defaultLanguage;
}
//-------------------------------------------------------------
// CurrentIOSLanguage
// Returns: The app's iOS Current language.
//-------------------------------------------------------------
- (NSString *)currentIOSLanguage{
    NSString *defaultLanguage ;
    NSString *preferredLanguage = [[NSLocale preferredLanguages] firstObject];
    
   
    defaultLanguage = [[NSLocale currentLocale] displayNameForKey:NSLocaleLanguageCode value:preferredLanguage];
   
    return defaultLanguage;
}
//-------------------------------------------------------------
//-------------------------------------------------------------
//Resets the current language to the default
//-------------------------------------------------------------
- (void)resetCurrentLanguageToDefault{
    NSString *defaultLanguage = [self defaultLanguage] ;
    [self setCurrentLanguage:defaultLanguage];
}

-(NSString*)displayNameForLanguage:(NSString*)language{
    NSString *currentLanguage =  [self currentLanguage];
    
    NSLocale *locale  = [[NSLocale alloc] initWithLocaleIdentifier:currentLanguage];
 
    NSString *displayName = [locale displayNameForKey:NSLocaleIdentifier value:language];
    if (displayName != nil || displayName.length > 0) {
        return displayName;
    }
    return @"";
}
//-------------------------------------------------------------
// set a Current language
//-------------------------------------------------------------

- (void)setCurrentLanguage:(NSString*)language{
    NSArray *availableLanguages = [self availableLanguagesWithoutBase:true];
    
    NSString *selectedLanguage = [availableLanguages containsObject:language] ? language : [self defaultLanguage];
    NSString *currentLanguage =  [self currentLanguage];
    
    if (selectedLanguage != currentLanguage) {
        [NSBundle setLanguage:selectedLanguage];
        [[NSUserDefaults standardUserDefaults] setObject:selectedLanguage forKey:IDCurrentLanguageKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:IDLanguageChangeNotification object:nil];
    }
    
}
//-------------------------------------------------------------
// set a new language
//-------------------------------------------------------------


@end
