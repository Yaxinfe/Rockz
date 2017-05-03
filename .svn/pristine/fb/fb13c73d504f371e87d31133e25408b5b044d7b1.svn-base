//
//  UploadFunction.m
//  Rockz
//
//  Created by Admin on 10/11/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "UploadFunction.h"
#import "Constants.h"
#import "Party.h"

@implementation UploadImage

+ (BOOL) upload:(NSString *)uploadFileName url:(NSString *)photoURL sourceimage:(UIImage *)image{
    
    if(image == nil){
        return FALSE;
    }
    NSString *urlAsString = [NSString stringWithFormat:@"%@",photoURL];
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.timeoutInterval = 20.0;
    [request setURL:[NSURL URLWithString:urlAsString]];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/536.26.14 (KHTML, like Gecko) Version/6.0.1 Safari/536.26.14" forHTTPHeaderField:@"User-Agent"];
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@.png\"\r\n", uploadFileName] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData: UIImagePNGRepresentation(image)]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    [request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)[body length]] forHTTPHeaderField:@"Content-Length"];
    // for test
    //[request addValue:@"I am jason" forHTTPHeaderField:@"jason"];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    // Loads the data for a URL request and executes a handler block on an operation queue when the request completes or fails.
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: queue
                           completionHandler: ^(NSURLResponse *urlResponse, NSData *data, NSError *error){
                               NSLog(@"Completed %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                               
                               [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
                               if (error) {
                                   NSLog(@"error:%@", error.localizedDescription); } }];
    
    return TRUE;
}



@end
