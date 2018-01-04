//
//  ProjectPickerView.h
//  MingYa
//
//  Created by 镓洲 王 on 10/30/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "NMPikerView.h"

@class ProjectPickerView;
@protocol ProjectPickerDelegate<NSObject>

-(void)projectPicker:(ProjectPickerView *)pickerView andParam:(NSDictionary *)paramDict;

@end


@interface ProjectPickerView : NMPikerView

@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,weak) IBOutlet UICollectionView *collectionView;


@property (nonatomic,strong) NSArray *proArr;
@property (nonatomic,strong) NSArray *brandArr;

@property (nonatomic,strong) id<ProjectPickerDelegate> delegate;


@end
