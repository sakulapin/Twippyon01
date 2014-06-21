//
//  DetailViewController.h
//  Twippyon
//
//  Created by 國井さくら on 2014/06/21.
//  Copyright (c) 2014年 sakura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "AppDelegate.h"

@interface DetailViewController : UIViewController

@property(nonatomic,strong) UIImage *image;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *text;
@property(nonatomic,copy) NSString *identifier;
@property(nonatomic,copy) NSString *isStr;
@property(nonatomic,copy) NSString *httpErrorMessage;

@end
