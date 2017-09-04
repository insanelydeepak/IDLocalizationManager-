//
//  ViewController.h
//  IDLocalizationManagerDemo
//
//  Created by Deepak on 04/09/17.
//  Copyright © 2017 InsanelyDeepak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDLocalizationManager.h"
@interface ViewController : UIViewController
{
    UIAlertController *alertSheet ;
    NSArray *availableLanguges;
    IBOutlet UIButton *changeLanguage;
    IBOutlet UIButton *resetLanguage;
    
}

@property (weak, nonatomic) IBOutlet UILabel *lblText;
- (IBAction)changeLanguage:(id)sender;
- (IBAction)resetLanguage:(id)sender;

@end

