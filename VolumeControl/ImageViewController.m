//
//  ImageViewController.m
//  VolumeControl
//
//  Created by Pradeep on 25/07/17.
//  Copyright © 2017 Pradeep. All rights reserved.
//

#import "ImageViewController.h"
#import "FoldersTableViewController.h"

@interface ImageViewController ()
{
    UIImage *img;
}
@end

@implementation ImageViewController

@synthesize imageName = _imageName;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showShareMenu:)];
    if(img == nil)
        img = [[UIImage alloc] init];
    
    img = [self getImageFrom:self.imageName];
    self.selectedImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.selectedImage setImage:img];
    // Do any additional setup after loading the view.
}

- (UIImage *)getImageFrom:(NSString *)imgStr
{
    NSString *imgPath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/MyFolder/%@", imgStr]];
    NSData *d = [[NSFileManager defaultManager] contentsAtPath:imgPath];
    
    UIImage *img1 = [UIImage imageWithData:d];
    return img1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)showShareMenu:(id)sender
{
    NSMutableArray *activityItem = [NSMutableArray arrayWithObjects:img, nil];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItem applicationActivities:nil];
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    activityVC.excludedActivityTypes = excludeActivities;
    [self presentViewController:activityVC animated:YES completion:nil];
}


@end
