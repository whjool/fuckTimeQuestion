//
//  CalenderTool.h
//  timeTest
//
//  Created by hun on 2018/7/27.
//  Copyright © 2018年 hun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalenderTool : NSObject


+(BOOL)isElderThan18WithDate:(NSString *)birthDateStr;

-(void)loopJob;

@end
