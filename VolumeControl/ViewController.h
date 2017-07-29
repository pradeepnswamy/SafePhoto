//
//  ViewController.h
//  VolumeControl
//
//  Created by Pradeep on 22/07/17.
//  Copyright © 2017 Pradeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *selectedImg;
@property (strong, nonatomic) UIImagePickerController *imgpic;

@end

