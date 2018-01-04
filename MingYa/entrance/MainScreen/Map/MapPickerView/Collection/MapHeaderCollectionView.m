//
//  MapHeaderCollectionView.m
//  MingYa
//
//  Created by 镓洲 王 on 11/21/17.
//  Copyright © 2017 镓洲 王. All rights reserved.
//

#import "MapHeaderCollectionView.h"


@interface MapHeaderCollectionView()
@end


@implementation MapHeaderCollectionView


-(void)setHeaderName:(NSString *)headerName{
    _headerName = headerName;
    self.label.text = headerName;
}

@end
