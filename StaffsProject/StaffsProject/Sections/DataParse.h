//
//  DataParse.h
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-7.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//  pod 'SDWebImage', '~> 3.7.1'

#import <Foundation/Foundation.h>

typedef void (^BlockReload)(id object);

@interface DataParse : NSObject

@property (nonatomic, copy) BlockReload getAndReload;

- (void)parseDataWithAPI:(NSString *)API;
- (void)parseDataWithRequest:(NSURLRequest *)request;

- (void)setBlock:(BlockReload)aBlock;

@end
