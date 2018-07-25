//
//  LYModel.h
//  LYAutoLayout
//
//  Created by Lee on 2018/7/23.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYModel : NSObject

@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *comments;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *forwarding;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *likes;
@property(nonatomic,copy)NSString *mark;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *picurl;
@property(nonatomic,copy)NSString *portrait;
@property(nonatomic,copy)NSString *postid;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *username;

@property (nonatomic, assign) BOOL unfold;

@end
