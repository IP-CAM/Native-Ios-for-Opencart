//
//  OCDataManager.m
//  OpencartKit
//
//  Created by icoco7 on 6/21/15.
//  Copyright (c) 2015 i2Cart. All rights reserved.
//

#import "OCDataManager.h"
#import <AFNetworking/AFURLRequestSerialization.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "OCWebService.h"
#import "AppResource.h"



NSString *const kOCAuthorizedToekn =@"OCAuthorizedToekn";

@interface OCDataManager (){
    
    AFHTTPSessionManager * _sessionManager;
    
    NSString* _token;
}
@end

@implementation OCDataManager

+ (instancetype)sharedInstance {
    static OCDataManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] init];
        
        [_instance setupWorkspace];

    });
    
    return _instance;
}

- (AFHTTPSessionManager*) getRequestOperator{
    if (nil == _sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    return _sessionManager;
}

- (void)setupJsonMode:(AFHTTPSessionManager*) operator{
    operator.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    operator.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operator.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    
    [operator.requestSerializer setValue:@"04exmjdONzS1VkxjZK16mtU8TXJ0dnNM" forHTTPHeaderField:@"X-Oc-Merchant-Id"];
    
    [operator.requestSerializer setValue:@"application/json; charset=utf-8"forHTTPHeaderField:@"Content-Type"];
   // [Resource :[result objectForKey:@"session"]];

    [operator.requestSerializer setValue:     (NSString*)AppResourceGet(@"App.UserAccount.Session", nil)
 forHTTPHeaderField:@"X-Oc-Session"];

}

- (void)setupWorkspace{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [self setupJsonMode:[self getRequestOperator]];
}


- (void)setHeader:(AFHTTPSessionManager*)operator header:(NSDictionary*)header{
    if (nil == header) {
        return;
    }
    [header enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [operator.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
}

+ (void)handleSucessResponse:(AFHTTPSessionManager *)operation response:(id) response success:(OCInvokeSuccessBlock)success successFilter:(OCFilterBlock)successFilter failure:(OCInvokeFailureBlock)failure{
    NSLog(@"handleSucessResponse->operation:[%@],\n JSON:[%@]", operation, response);
    NSException* exception = nil;// [OCWebService dataExceptionWithResponse:response];
    
    if (nil != exception) {
        //@step
        response = exception;
    }
    
    if (successFilter) {
        NSLog(@"successFilter->before JSON: %@", response);
        response = successFilter(response);
        NSLog(@"successFilter->done JSON: %@", response);
    }
    
    success(response);
}

+ (void)handleFailureResponse:(AFHTTPSessionManager *)operation error:(NSError *)error failure:(OCInvokeFailureBlock)failure{
   
  //  NSString *buf = [[NSString alloc] initWithData:operation.responseSerializer  encoding:NSUTF8StringEncoding];
    NSLog(@"handleFailureResponse->operation:[%@],\nreponse:[],\n error:[%@]", operation, error);
    
    failure( error);
}


- (void)POST:(NSString*)url  params:(NSDictionary*)params  success:(OCInvokeSuccessBlock)success successFilter:(OCFilterBlock)successFilter failure:(OCInvokeFailureBlock)failure {
    
    // change for body
   /*
    [_operator POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSMutableDictionary *mutableHeaders = [NSMutableDictionary dictionary];
        [mutableHeaders setValue:[NSString stringWithFormat:@"application/json"] forKey:@"Content-Type"];
        [formData appendPartWithHeaders:mutableHeaders body:[NSKeyedArchiver archivedDataWithRootObject:params]];

    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [OCDataManager handleSucessResponse:operation response:responseObject success:success successFilter:successFilter failure:failure];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [OCDataManager handleFailureResponse:operation error:error failure:failure];
        
    }];*/
   // [_sessionManager.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];  // Convert your parameter to NSDATA
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];  // Convert data into string using NSUTF8StringEncoding

    
  //  AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]]; //Intialialize AFURLSessionManager
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];  // make NSMutableURL req
    
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue]; // add paramerets to NSMutableURLRequest
    [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Accept"];
    
    [req setValue:@"04exmjdONzS1VkxjZK16mtU8TXJ0dnNM" forHTTPHeaderField:@"X-Oc-Merchant-Id"];
    
    [req setValue:@"application/json; charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    // [Resource :[result objectForKey:@"session"]];
    
    [req setValue:     (NSString*)AppResourceGet(@"App.UserAccount.Session", nil)
                      forHTTPHeaderField:@"X-Oc-Session"];

    
    
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [[_sessionManager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSLog(@"Reply JSON: %@", responseObject);
            
            [OCDataManager handleSucessResponse:self->_sessionManager response:responseObject success:success successFilter:successFilter failure:failure];

            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                
                NSLog(@"Response == %@",responseObject);
                
            }
        } else {
            NSLog(@"Error1234: %@, %@, %@", error, response, responseObject);
            [OCDataManager handleFailureResponse:_sessionManager error:error failure:failure];

        }
        
    }]resume];
    
    
    
//    [_sessionManager POST:url parameters:jsonString success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [OCDataManager handleSucessResponse:self->_sessionManager response:responseObject success:success successFilter:successFilter failure:failure];
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [OCDataManager handleFailureResponse:_sessionManager error:error failure:failure];
//
//    }];
    
    
    
    /*
    
    [_sessionManager POST:url parameters:params success:^(AFHTTPSessionManager *operation, id responseObject) {
        
        [responseObject setHTTPBody:[NSKeyedArchiver archivedDataWithRootObject:params]];
        [OCDataManager handleSucessResponse:operation response:responseObject success:success successFilter:successFilter failure:failure];
        
    } failure:^(AFHTTPSessionManager *operation, NSError *error) {
        [OCDataManager handleFailureResponse:operation error:error failure:failure];
    }];*/
    
    
}

- (void)GET:(NSString*)url params:(NSDictionary*)params  success:(OCInvokeSuccessBlock)success successFilter:(OCFilterBlock)successFilter failure:(OCInvokeFailureBlock)failure {
    
   
    [_sessionManager GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [OCDataManager handleSucessResponse:_sessionManager response:responseObject success:success successFilter:successFilter failure:failure];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [OCDataManager handleFailureResponse:_sessionManager error:error failure:failure];

    }];
    
    
    
    
    
    /*
    
    [_sessionManager GET:url parameters:params success:^(AFHTTPSessionManager *operation, id responseObject) {
        [OCDataManager handleSucessResponse:operation response:responseObject success:success successFilter:successFilter failure:failure];
        
    } failure:^(AFHTTPSessionManager *operation, NSError *error) {
        [OCDataManager handleFailureResponse:operation error:error failure:failure];
    }];*/
}


- (void)request:(NSString*)url method:(NSString*)method params:(NSDictionary*)params  success:(OCInvokeSuccessBlock)success successFilter:(OCFilterBlock)successFilter failure:(OCInvokeFailureBlock)failure {
    
    NSLog(@"url:%@, param:%@",url, params);
    if ([@"POST" isEqualToString:method]) {
        [self POST:url params:params success:success successFilter:successFilter failure:failure];
        return;
    }
    if ([@"GET" isEqualToString:method]) {
        [self GET:url params:params success:success successFilter:successFilter failure:failure];
        return;
    }
    
}

- (void)request:(NSString*)url method:(NSString*)method params:(NSDictionary*)params header:(NSDictionary*)header success:(OCInvokeSuccessBlock)success successFilter:(OCFilterBlock)successFilter failure:(OCInvokeFailureBlock)failure {
    if (nil != header) {
        [self setHeader:_sessionManager header:header];
        NSLog(@"header:[%@]",header);
    }
    //@step
    [self request:url method:method params:params  success:success  successFilter:successFilter failure:failure];
}

#pragma mark
#pragma mark -invokeService
- (void)invokeService:(OCWebService*)service{
    [self invokeService:service success:^(id response) {
        if (service.delegate && [service.delegate respondsToSelector:@selector(onSuccess:response:) ]){
            [service.delegate onSuccess:service response:response];
        }
    } failure:^(NSError *error) {
        if (service.delegate && [service.delegate respondsToSelector:@selector(onFailure:error:) ]){
            [service.delegate onFailure:service error:error];
        }
    }];
}

- (void)invokeService:(OCWebService*)service success:(OCInvokeSuccessBlock)success failure:(OCInvokeFailureBlock)failure {
    
    NSString* url = [service getUrl];
    NSDictionary* params = service.parameters;
    NSDictionary* header = service.header;
    OCFilterBlock successFilter = service.successFilter;
    NSString* method = service.method;
    
    [self request:url method:method params:params header: header success:success successFilter: successFilter failure:failure];
}


#pragma mark
#pragma mark -User Token

- (void)setUserToken:(NSString*)value{
    _token = value;
    AppResourceSet(kOCAuthorizedToekn, _token);
}

- (NSString*)getUserToken{
    if (nil ==_token) {
        _token = (NSString*)AppResourceGet(kOCAuthorizedToekn, _token);
    }
    return _token;
}

@end
