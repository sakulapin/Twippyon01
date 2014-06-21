//
//  MyUIApplication.m
//  Twippyon
//
//  Created by 國井さくら on 2014/06/21.
//  Copyright (c) 2014年 sakura. All rights reserved.
//

#import "MyUIApplication.h"

@implementation MyUIApplication

-(BOOL)openURL:(NSURL *)url
{
    if(!url){
        return NO;
    }
    self.myOpenURL = url;
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    WebViewController *webViewController =
    [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    WebViewController.openURl = self.myOpenURL;
    WebViewController.title = @"Web View";
    [AppDelegate.navigationController pushViewController animated:YES];
    self.myOpenURL = nil;
    return YES;



}

@end
