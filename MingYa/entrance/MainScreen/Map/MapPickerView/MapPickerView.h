//
//  MapPickerView.h
//  MingYa
//
//  Created by 镓洲 王 on 10/13/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "NMPikerView.h"


@protocol MapPickerDelegate <NSObject>
-(void)pickerView:(NMPikerView *)pickerView requestDict:(NSDictionary *)paramDict;
@end


@interface MapPickerView : NMPikerView

@property (nonatomic,strong) NSArray *proArr;
@property (nonatomic,strong) NSArray *brandArr;
@property (nonatomic,strong) id<MapPickerDelegate> delegate;


@end
