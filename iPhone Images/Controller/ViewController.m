//
//  ViewController.m
//  iPhone Images
//
//  Created by Jamie on 2018-08-16.
//  Copyright © 2018 Jamie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iPhoneImageView;
@property (nonatomic, strong) NSArray *urlArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.urlArray = @[@"http://imgur.com/bktnImE.png", @"http://imgur.com/zdwdenZ.png", @"http://imgur.com/CoQ8aNl.png", @"http://imgur.com/2vQtZBb.png", @"http://imgur.com/y9MIaCS.png"];
    NSURL *url = [NSURL URLWithString:[self randomizeUrl]];
    //NSURL *url = [NSURL URLWithString:@"http://i.imgur.com/bktnImE.png"]; // 1
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 2
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data]; // 2
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            
            self.iPhoneImageView.image = image; // 4
        }];
        
    }];
        
    
    [downloadTask resume]; // 5

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*) randomizeUrl{
    
    int index = arc4random_uniform(4)-1;
    NSString *string = [self.urlArray objectAtIndex:index];
    return string;
}


@end
