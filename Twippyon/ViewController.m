//
//  ViewController.m
//  Twippyon
//
//  Created by 國井さくら on 2014/06/14.
//  Copyright (c) 2014年 sakura. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *accountDisplayLabel;

@property (nonatomic,strong) ACAccountStore *accountStore;
@property (nonatomic,copy) NSArray *twitterAccounts;
@property (nonatomic,copy) NSString *identifier;

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.accountStore = [[ACAccountStore alloc]init];
    ACAccountType *twitterType =
    [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [self.accountStore requestAccessToAccountsWithType:twitterType options:NULL completion:^(BOOL granted,NSError *error){
        if(granted){//認証成功時
            self.twitterAccounts = [self.accountStore accountsWithAccountType:twitterType];
            if(self.twitterAccounts.count > 0){
            ACAccount *account = self.twitterAccounts[0];
            dispatch_async(dispatch_get_main_queue(),^{
                self.accountDisplayLabel.text = account.username;
            });
                
    
        }else{
            dispatch_async(dispatch_get_main_queue(),^{
                self.accountDisplayLabel.text = @"アカウントなし";
            });
        }
    }else {
        NSLog(@"Account Error: %@", [error localizedDescription]);
        dispatch_async(dispatch_get_main_queue(),^{
            self.accountDisplayLabel.text = @"アカウント認証エラー";
        });
    }}];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tweet:(id)sender {
    NSLog(@"pass");
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        NSString *serviceType = SLServiceTypeTwitter;
        SLComposeViewController *composeCtl =
        [SLComposeViewController composeViewControllerForServiceType:serviceType];
        [composeCtl setCompletionHandler:^(SLComposeViewControllerResult result){
            if(result == SLComposeViewControllerResultDone){
                NSLog(@"投稿成功！");
            }
    
    }];
    [self presentViewController:composeCtl animated:YES completion:nil];
    
 }
}
- (IBAction)setAccountAction:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc]init];
    sheet.delegate = self;
    
    sheet.title =@"Select your account";
    for(ACAccount *account in self.twitterAccounts){
        [sheet addButtonWithTitle:account.username];
    }
    [sheet addButtonWithTitle:@"Cancel"];
    sheet.cancelButtonIndex = self.twitterAccounts.count;
    [sheet showInView:self.view];
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(self.twitterAccounts.count > 0){
        if(buttonIndex !=self.twitterAccounts.count){
            ACAccount *account = self.twitterAccounts[buttonIndex];
            self.identifier = account.identifier;
            self.accountDisplayLabel.text = account.username;
            NSLog(@"Acount set! %@", account.username);
        }else{
              NSLog(@"cancel!");
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"timeLineSegue"]){
        TimeLineTableViewController *timeLineVC = segue.destinationViewController;
        if([timeLineVC isKindOfClass:[TimeLineTableViewController class]]){
            timeLineVC.identifier = self.identifier;
        }
    }
}


@end
