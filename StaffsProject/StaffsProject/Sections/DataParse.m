//
//  DataParse.m
//  LOLBoxProject
//
//  Created by Ray.M on 15-3-7.
//  Copyright (c) 2015年 Ray.M. All rights reserved.
//

#import "DataParse.h"
#import "AFNetworking.h"
@implementation DataParse

- (void)parseDataWithRequest:(NSURLRequest *)request
{
    //创建AFNetworking的请求操作
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //设置AFNetworking返回的数据 自动进行json解析
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    //设置内容类型
    //    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //完成请求进入blocks
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求成功,打印返回数据
        //        NSLog(@"%@", responseObject);
        _getAndReload(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败,打印错误
        NSLog(@"Error: %@", error.localizedDescription);
        //        NSLog(@"%@", res)
    }];
    
    //开始请求
    [operation start];

}

- (void)parseDataWithAPI:(NSString *)API
{
    //创建网络请求
    NSURL* URL = [NSURL URLWithString:API];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval = 30;
    
    //创建AFNetworking的请求操作
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //设置AFNetworking返回的数据 自动进行json解析
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    //设置内容类型
//    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //完成请求进入blocks
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求成功,打印返回数据
        //        NSLog(@"%@", responseObject);
        _getAndReload(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败,打印错误
        NSLog(@"Error: %@", error.localizedDescription);
        //        NSLog(@"%@", res)
    }];
    
    //开始请求
    [operation start];
}

- (void)setBlock:(BlockReload)aBlock
{
    self.getAndReload = aBlock;
}



@end
