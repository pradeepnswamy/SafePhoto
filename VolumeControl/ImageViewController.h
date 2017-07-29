//
//  ImageViewController.h
//  VolumeControl
//
//  Created by Pradeep on 25/07/17.
//  Copyright © 2017 Pradeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController

@property (strong, nonatomic) NSString *imageName;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;

- (IBAction)showShareMenu:(id)sender;

@end
