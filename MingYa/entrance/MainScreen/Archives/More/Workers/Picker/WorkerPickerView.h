//
//  WorkerPickerView.h
//  MingYa
//
//  Created by 镓洲 王 on 10/24/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "NMPikerView.h"


typedef NS_ENUM(NSUInteger, NMWorkerPickerType) {
    NMWorkerPickerTypeCity,
    NMWorkerPickerTypeWorker,
};


@protocol WorkerPickerDelegate<NSObject>
-(void)changePickerLayoutAs:(NMWorkerPickerType)type;
-(void)pickerView:(NMPikerView *)pickerView requestDict:(NSDictionary *)paramDict;
@end


@interface WorkerPickerView : NMPikerView

@property (nonatomic,strong) id<WorkerPickerDelegate> delegateController;
@property (nonatomic,strong) NSArray *proArr;
@property (nonatomic,strong) NSArray *workerTypeArr;

//@property (nonatomic,strong) id<WorkerPickerDelegate> delegate;

@end
