//
//  InformationCell.h
//  HOTELINTRO
//
//  Created by xin on 2017/11/3.
//  Copyright © 2017年 pasaaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelDataModel.h"

@protocol HotelDelegate <NSObject>
- (void)hotelCellCallNumber:(HotelDataModel *)model;
- (void)hotelCellCollectModels:(HotelDataModel *)model;
@end

@interface HotelCell : UITableViewCell
@property (nonatomic, weak) id<HotelDelegate> delegate;
@property (nonatomic, strong) HotelDataModel *model;
@property (nonatomic, assign) BOOL isCollectionCell;
@end
