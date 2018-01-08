//
//  PickRoleViewController.h
//  MingYa
//
//  Created by 镓洲 王 on 12/30/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentTableViewController.h"

@interface PickRoleViewController : UIViewController

@property (nonatomic,strong) NSString *projectId;
@property (nonatomic,strong) CommentTableViewController *tmpCommentTableVC;


@end
