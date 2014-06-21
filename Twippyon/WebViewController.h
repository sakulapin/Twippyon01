//
//  WebViewController.h
//  Twippyon
//
//  Created by 國井さくら on 2014/06/21.
//  Copyright (c) 2014年 sakura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
@property(nonatomic,strong) NSURL *openURL;


@end
