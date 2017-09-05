//
//  ViewController.m
//  IDLocalizationManagerDemo
//
//  Created by Deepak on 04/09/17.
//  Copyright © 2017 InsanelyDeepak. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    availableLanguges = IDLocalizationAvailableLanguages;
    
    // Add an observer for IDLanguageChangeNotification. This is posted whenever a language changes and allows the viewcontroller to make the necessary UI updated. Very useful for places in your app when a language change might happen.
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(notificationLanguageDidChanged) name:IDLanguageChangeNotification object:nil];
    
   
    [self setUIText];


}
-(void)setUIText {
    _lblText.text = LocalizedString(@"welcome");
    [change setTitle:LocalizedString(@"change") forState:UIControlStateNormal];
    [reset setTitle:LocalizedString(@"reset") forState:UIControlStateNormal];
    
    
    //------------- Get What iOS Language is now -------------
    NSLog(@"iOS (System) Language: %@",IDLocalizationCurrentIOSLanguageLanguage);
    //------------- Get Current Language -------------
    NSLog(@"Current Language for Application: %@",IDLocalizationCurrentLanguage);
    //------------- Get Default Language  which will be used for reset-------------
    NSLog(@"Default Language for Application: %@",IDLocalizationDefaultLanguage);

}
-(void)notificationLanguageDidChanged {
    [self setUIText];
}
-(void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changeLanguage:(id)sender {
    alertSheet = [UIAlertController alertControllerWithTitle:LocalizedString(@"Alert_Title") message:LocalizedString(@"Alert_Msg") preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSString *language in availableLanguges) {
        NSString *displayName = IDLocalizationDisplayNameForLanguage(language);
        UIAlertAction *actionLanguage = [UIAlertAction actionWithTitle:displayName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            IDLocalizationSetLanguage(language);
            NSLog(@"Change language to: %@",displayName);
           
        }];
        [alertSheet addAction:actionLanguage];
    }
    [self presentViewController:alertSheet animated:YES completion:nil];
}

- (IBAction)resetLanguage:(id)sender {
    IDLocalizationResetLanguageToDefault;
    NSLog(@"Reset language to application default: %@",IDLocalizationDefaultLanguage);
}

@end
