//
//  APIMaster.m
//  Rockz
//
//  Created by Admin on 1/9/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "APIMaster.h"

@implementation APIMaster

static APIMaster* singleton = nil;

+(APIMaster*)singleton
{
    if(singleton == nil)
        singleton = [[self alloc] init];
    
    return singleton;
}

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}


#pragma mark - login

-(void)loginWithInfo:(NSString*)username Password:(NSString*)password SucceedHandler:(APICompletionHandler)succeedHandler ErrorHandler:(APIErrorHandler)errorHandler;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@", ROCKZ_SERVICE_URL,API_LOGIN];
    NSDictionary *paramDict = [[NSDictionary alloc] initWithObjects:@[username,password] forKeys:@[@"username", @"password"]];
    [self executeHTTPRequest:urlStr parameters:paramDict CompletionHandler:succeedHandler ErrorHandler:errorHandler];
}


#pragma mark - loginwithfacebook

- (void)loginWithFacebook:(NSString *)facebookID firstname:(NSString *)firstname lastname:(NSString *)lastname email:(NSString *)email deviceToken:(NSString *)token photo:(UIImage *)img SucceedHandler:(APICompletionHandler)succeedHandler ErrorHandler:(APIErrorHandler)errorHandler {
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@", ROCKZ_SERVICE_URL,API_FACEBOOK_LOGIN];
    
    // For test
    //token = @"sddsdssdsddssd";
    
    NSDictionary *paramDic = [[NSDictionary alloc] initWithObjects:@[facebookID, firstname, lastname, email, token, @"0"] forKeys:@[@"facebookid", @"firstname", @"lastname", @"email", @"devicetoken", @"devicetype"]];
    
    NSData *imageData = [self UIImageData:img];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    manager.responseSerializer = responseSerializer;
    
    [manager POST:urlStr parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        [formData appendPartWithFileData:imageData  name:@"photo" fileName:@"photo.png" mimeType:@"image/png"];
    }success:^(NSURLSessionDataTask *task, id responseObject){
        NSLog(@"JSON: %@", responseObject);
        succeedHandler(responseObject);
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        NSLog(@"Error: %@", error);
        errorHandler(error);
    }];
    
}

#pragma mark - register

-(void)signup:(NSString *)firstname lastname:(NSString *)lastname username:(NSString *)username email:(NSString *)email password:(NSString *)password devicetoken:(NSString *)deviceToken  photo:(UIImage *)photo coverphoto:(UIImage *)coverphoto succeedhandler:(APICompletionHandler)succeedHandler errorhandler:(APIErrorHandler)errorHandler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@", ROCKZ_SERVICE_URL, API_REGISTER];
    // For test
    //deviceToken = @"sddsdssdsddssd";
    
    NSDictionary *paramDic = [[NSDictionary alloc] initWithObjects:@[firstname, lastname, username, email, password, deviceToken, @"0"] forKeys:@[@"firstname", @"lastname", @"username", @"email", @"password", @"devicetoken", @"devicetype"]];
    
    
    
    NSData *photoImg = [self UIImageData:photo];
    NSData *coverphotoImg = [self UIImageData:coverphoto];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
       
    [manager POST:urlStr parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        [formData appendPartWithFileData:photoImg name:@"photo" fileName:@"photo.png" mimeType:@"image/png"];
        [formData appendPartWithFileData:coverphotoImg name:@"coverphoto" fileName:@"coverphoto.png" mimeType:@"image/png"];
        
    }success:^(NSURLSessionDataTask *task, id responseObject){
        NSLog(@"JSON: %@", responseObject);
        succeedHandler(responseObject);
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        NSLog(@"Error: %@", error);
        errorHandler(error);
    }];
    
}

#pragma mark - change profile

-(void) changeProfile:(NSString *)userID firstname:(NSString *)firstname lastname:(NSString *)lastname email:(NSString *)email newPassword:(NSString *)newPassword photo:(UIImage *)photo coverphoto:(UIImage *)coverphoto succedHandler:(APICompletionHandler)succeedHandler errorHandler:(APIErrorHandler)errorHandler
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@", ROCKZ_SERVICE_URL, API_CHANGE_PROFILE];
    NSDictionary *paramDic = [[NSDictionary alloc] initWithObjects:@[userID, firstname, lastname, email, newPassword] forKeys:@[@"userid", @"firstname", @"lastname", @"email", @"password"]];
    NSData *photoImg = UIImagePNGRepresentation(photo);
    NSData *coverphotoImg = UIImagePNGRepresentation(coverphoto);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [manager POST:urlStr parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        [formData appendPartWithFileData:photoImg name:@"photo" fileName:@"photo.png" mimeType:@"image/png"];
        [formData appendPartWithFileData:coverphotoImg name:@"coverphoto" fileName:@"coverphoto.png" mimeType:@"image/png"];
        
    }success:^(NSURLSessionDataTask *task, id responseObject){
        NSLog(@"JSON: %@", responseObject);
        succeedHandler(responseObject);
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        NSLog(@"Error: %@", error);
        errorHandler(error);
    }];

}

#pragma mark - create party

- (void) createPartyByUserID:(NSString *)userID partyName:(NSString *)partyName address:(NSString *)address longitude:(NSString *)longitude latitude:(NSString *)latitude date:(NSString *)date starttime:(NSString *)starttime endtime:(NSString *)endtime hosts:(NSString *)hosts type:(NSString *)type status:(NSString *)status roll:(NSString *)roll fee:(NSString *)fee partyImage:(UIImage *)partyImage succeedHandler:(APICompletionHandler)succeedHandler errorHandler:(APIErrorHandler)errorHandler{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@", ROCKZ_SERVICE_URL, API_CREATE_PARTY];
    NSDictionary *paramDic = [[NSDictionary alloc]initWithObjects:@[userID, partyName, address, longitude, latitude, date, starttime, endtime, hosts, type, status, roll, fee]  forKeys:@[@"userid", @"name", @"address", @"longitude", @"latitude", @"date", @"starttime", @"endtime", @"host", @"type", @"status", @"roll", @"fee"]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    NSData *img = [self UIImageData:partyImage];
    
    [manager POST:urlStr parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        [formData appendPartWithFileData:img name:@"partyimage" fileName:@"partyimage.png" mimeType:@"image/png"];
        
    }success:^(NSURLSessionDataTask *task, id responseObject){
        NSLog(@"JSON: %@", responseObject);
        succeedHandler(responseObject);
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        NSLog(@"Error: %@", error);
        errorHandler(error);
    }];
    
    
}

- (void) executeHTTPRequest:(NSString *)url parameters:(NSDictionary *) dictionary CompletionHandler:(APICompletionHandler)succeedHandler ErrorHandler:(APIErrorHandler)errorHandler
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    NSLog(@"URL -- %@",url);
    [manager GET:url parameters:dictionary progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        succeedHandler(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        errorHandler(error);
    }];
}

-(UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


-(NSData *)UIImageData:(UIImage*)Image{
    NSData *newImageData;
    NSData *oldImageData= UIImagePNGRepresentation(Image);
    
    if(oldImageData.length>100000){
        CGFloat scale=(CGFloat)sqrt(100000/(double)oldImageData.length);
        CGSize newSize=CGSizeMake(Image.size.width*scale, Image.size.height*scale);
        
        newImageData=UIImagePNGRepresentation([self imageWithImage:Image scaledToSize:newSize]);
        
    }else{
        newImageData=oldImageData;
    }
    
    NSLog(@"SIZE OF IMAGE: %lu ", (unsigned long)newImageData.length);
    
    return newImageData;
}

@end
