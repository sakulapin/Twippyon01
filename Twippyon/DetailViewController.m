//
//  DetailViewController.m
//  Twippyon
//
//  Created by 國井さくら on 2014/06/21.
//  Copyright (c) 2014年 sakura. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UITextView *nameView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.title = @"Detail view";
    self.profileImageView.image = self.image;
    self.nameView.text = self.name;
    self.textView.text = self.text;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)retweetAction:(id)sender {
    ACAccountStore *accountStore = [[ACAccountStore alloc]init];
    ACAccount *account = [accountStore accountWithIdentifier:self.identifier];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.twitter.com"
                   @"/1.1/statuses/retweeet/%@.json",self.isStr]];
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                             requestMethod:SLRequestMethodPOST
                                                      URL:url
                                               parameters:nil];
    request.account = account;
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
    [request performRequestWithHandler:^(NSData *resonseData,
                                         NSHTTPURLResponse *urlREsponse,
                                         NSError *error){
        if(resonseData){
            self.httpErrorMessage = nil;
            if(urlREsponse.statusCode >= 200 && urlREsponse.statusCode <300){
                NSDictionary *postResonseData =
                [NSJSONSerialization JSONObjectWithData:resonseData options:NSJSONReadingMutableContainers
                                                  error:NULL];
                NSLog(@"SUCCESS! Created Retweet with ID:%@",postResonseData[@"id_str"]);
                
        
            }else{
                self.httpErrorMessage =
                [NSString stringWithFormat:@"The reaponse code is %d",
                 urlREsponse
                 .statusCode];
                NSLog(@"HTTP Error:%@", self.httpErrorMessage);
                
            }
        }else{
            NSLog(@"ERROR: An error occures while posting: %@",[error localizedDescription]);
        
        }
        dispatch_async(dispatch_get_main_queue(),^{
            UIApplication *application = [UIApplication sharedApplication];
            application.networkActivityIndicatorVisible = NO;
        });
        
    }];
}

@end
