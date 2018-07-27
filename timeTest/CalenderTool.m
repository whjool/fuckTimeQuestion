//
//  CalenderTool.m
//  timeTest
//
//  Created by hun on 2018/7/27.
//  Copyright © 2018年 hun. All rights reserved.
//

#import "CalenderTool.h"

@interface CalenderTool ()

@property(nonatomic,strong)NSCalendar *calendar;

@end

@implementation CalenderTool


+(NSDateFormatter *)shareDateFormatter:(NSString *)format
{
    [NSTimeZone timeZoneForSecondsFromGMT:3600*8];
    NSDateFormatter *dateFormat= [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    dateFormat.lenient = YES;
    return dateFormat;
}

+(BOOL)isElderThan18WithDate:(NSString *)birthDateStr
{
    if (birthDateStr.length>0)
    {
        NSDateFormatter *formatter =[self shareDateFormatter:@"yyyy-MM-dd"];
        
        NSDate *birthDate = [formatter dateFromString:birthDateStr];
        
        NSInteger age = [self getDiffYear_dateWithBegin:birthDate andEnd:[NSDate date]];
        if (age>=18)
        {
            return YES;
        }
    }
    
    return NO;
}

+(NSInteger)getDiffYear_dateWithBegin:(NSDate *)beginDate andEnd:(NSDate *)endDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents * components =  [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:beginDate toDate:endDate options:NSCalendarWrapComponents];
    NSLog(@"year:%ld,month:%ld,day:%ld",components.year,components.month,components.day);
    return components.year;
}

+(NSInteger)get_DateYear:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:date];
    return comp1.year;
}


-(NSCalendar *)calendar
{
    if (!_calendar)
    {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _calendar = calendar;
    }
    return _calendar;
}



-(void)loopJob
{
    NSInteger beginYear = 1950;
    NSInteger endYear = 2100;
    NSInteger totalMonth = 12;
    
    NSMutableArray *fuckArr = [@[] mutableCopy];
    for (NSInteger year = beginYear;beginYear<=endYear ; year++)
    {
        //查询具体月份时间
        for (NSInteger month = 1; month<=totalMonth; month++)
        {
            NSInteger totalDayCount = [self numberOfDaysWithDate:[self getMonDateWithYear:year andMonth:month]];
            for (NSInteger day = 1; day<=totalDayCount; day++)
            {
                NSDate *date = [self getDateWithYear:year andMonth:month andDay:day];
                NSString *targetStr = [NSString stringWithFormat:@"%ld-%@-%@",year,[self dayMonth_toStrWithNum:month],[self dayMonth_toStrWithNum:day]];
                if (date) {
                    NSLog(@"%@\t没问题",targetStr);
                }else
                {
                    [fuckArr addObject:targetStr];
                    NSLog(@"%@\t\t日了狗了~~~",targetStr);
                }
                
            }
        }
    }
    
    NSLog(@"发现问题数目:%ld",fuckArr.count);
    for (NSString *item in fuckArr)
    {
        NSLog(item,nil);
    }
    
}

-(NSDate *)getMonDateWithYear:(NSInteger)year andMonth:(NSInteger)month
{
    //由于有年月日,所以可以获取到date
    
    NSString *dateString=[NSString stringWithFormat:@"%ld-%@",year,[self dayMonth_toStrWithNum:month]];
    
    
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setLocale:[NSLocale systemLocale]];
    [dateFormat setDateFormat:@"yyyy-MM"];
    
    NSDate *targetDate = [dateFormat dateFromString:dateString];
    return targetDate;
}

-(NSString *)dayMonth_toStrWithNum:(NSInteger)num
{
    if (num/10)
    {
        return [NSString stringWithFormat:@"%ld",num];
    }else
        return [NSString stringWithFormat:@"0%ld",num];
}


-(NSDate *)getDateWithYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day
{
    //由于有年月日,所以可以获取到date
    NSString *dateString = [NSString stringWithFormat:@"%ld-%@-%@",year,[self dayMonth_toStrWithNum:month],[self dayMonth_toStrWithNum:day]];

    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setLocale:[NSLocale systemLocale]];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *targetDate = [dateFormat dateFromString:dateString];
    return targetDate;
}


- (NSInteger)numberOfDaysWithDate:(NSDate *)targetDate
{
    // 初始化日历
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取系统当前日期
    NSDate *currentDate = targetDate;
    //当前日期中当前月中天的范围
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:currentDate];
    // 得到当前月中总共有多少天（即范围的长度）
    NSInteger numberOfDaysInCurrentMonth = range.length;
    return numberOfDaysInCurrentMonth;
}




@end
