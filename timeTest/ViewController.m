//
//  ViewController.m
//  timeTest
//
//  Created by hun on 2018/7/27.
//  Copyright © 2018年 hun. All rights reserved.
//

#import "ViewController.h"
#import "CalenderTool.h"
@interface ViewController ()

@property(nonatomic,strong)CalenderTool *cartool ;//

@property(nonatomic,strong)NSArray *questionDates ;//

@end

@implementation ViewController
-(NSArray *)questionDates
{
    if (!_questionDates) {
        _questionDates = @[
                           @"1986-05-04",
                           @"1987-04-12",
                           @"1988-04-10",
                           @"1989-04-16",
                           @"1990-04-15",
                           @"1991-04-14",
                           ];
    }
    return _questionDates;
}


-(CalenderTool *)cartool
{
    if (!_cartool) {
        _cartool = [CalenderTool new];
    }
    return _cartool;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)testTouch:(id)sender
{
    [self.cartool loopJob];
}

- (IBAction)for_18ages:(id)sender {
    
    for (NSString *date in self.questionDates)
    {
        if ([CalenderTool isElderThan18WithDate:date])
        {
            NSLog(@"%@大于18岁",date);
        }else
            NSLog(@"%@ 不大于,又日了狗了",date);
    }
    
}


@end
