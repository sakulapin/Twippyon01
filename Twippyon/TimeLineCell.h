//
//  TimeLineCell.h
//  Twippyon
//
//  Created by 國井さくら on 2014/06/14.
//  Copyright (c) 2014年 sakura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeLineCell : UITableViewCell

@property (nonatomic,strong) UILabel *tweetTextLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *profileImageView;
@property (nonatomic) float tweetTextLabelHeight;

@end
