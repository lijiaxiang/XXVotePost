//
//  XXValidityPeriodModel.h
//  XXVotePost
//
//  Created by apple on 16/1/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, validityPeriodType) {
    validityPeriodOneDay,//一天 default
    validityPeriodOneWeek, //一周
    validityPeriodOneMonth //一个月
};
@interface XXValidityPeriodModel : NSObject
@property (nonatomic, assign) validityPeriodType validityPeriodType;
@end
