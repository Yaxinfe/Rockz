//
//  Httpclient.m
//  Rockz
//
//  Created by Admin on 09/11/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "Httpclient.h"

@implementation Httpclient

@synthesize transformWay;
@synthesize address;
@synthesize parameter;

-(void) setServerAddress:(NSString *)strAddress{
    address = strAddress;
}

-(void) setGetway{
    transformWay = @"GET";
}

-(void) setPostway{
    transformWay = @"POST";
}

-(void) setParameter:(NSString *)param{
    
    parameter = param;
}

-(void) start{
    
    NSString *urlAsString = address;
    if (parameter != nil) {
        urlAsString = [urlAsString stringByAppendingString:parameter];
    }
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:transformWay];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue
                           completionHandler:^(NSURLResponse *response,NSData *data,NSError *error) {
                               if ([data length] >0 && error == nil){
                                   NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments  error:&error];
                                   if (jsonObject != nil && error == nil){
                                       NSLog(@"Successfully deserialized...");
                                       if ([jsonObject isKindOfClass:[NSDictionary class]]){
                                           NSDictionary *deserializedDictionary = jsonObject;
                                           NSLog(@"Deserialized JSON Dictionary = %@",deserializedDictionary);
                                       }
                                       else if ([jsonObject isKindOfClass:[NSArray class]]){
                                           NSArray *deserializedArray = (NSArray *)jsonObject;
                                           NSLog(@"Deserialized JSON Array = %@", deserializedArray);
                                       }
                                       else {
                                           /* Some other object was returned. We don't know how to
                                            deal with this situation as the deserializer only
                                            returns dictionaries or arrays */
                                       }
                                       [self.controller performSelector:@selector(requestSuccess:) withObject:jsonObject ];
                                       NSLog(@"HTML = %@", html);
                                   }
                                   else if ([data length] == 0 && error == nil){
                                       [self.controller performSelector:@selector(requestSuccessWithEmptyData)];
                                       NSLog(@"Nothing was downloaded.");
                                   }
                                   else if (error != nil){
                                       [self.controller performSelector:@selector(requestError:) withObject:error];
                                       NSLog(@"Error happened = %@", error);
                                   }
                               }
    }];
}
@end
