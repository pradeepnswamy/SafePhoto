//
//  ViewController.m
//  VolumeControl
//
//  Created by Pradeep on 22/07/17.
//  Copyright © 2017 Pradeep. All rights reserved.
//

#import <LocalAuthentication/LocalAuthentication.h>

#import "ViewController.h"
#import "ImageCollectionViewController.h"
#import "ImageViewController.h"
#import "FoldersTableViewController.h"

@interface ViewController ()
{
    UIStoryboard * storyBoard;
}
@end

@implementation ViewController

@synthesize imgpic;

- (void)viewDidLoad {
    [super viewDidLoad];
        
    storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    self.imgpic = [[UIImagePickerController alloc] init];
    self.imgpic.delegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showFolders:(id)sender
{
    FoldersTableViewController *ftvc = [storyBoard instantiateViewControllerWithIdentifier:@"FoldersTableViewController"];
    [self.navigationController pushViewController:ftvc animated:YES];
}

- (IBAction)openGallery:(id)sender
{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        self.imgpic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    self.imgpic.allowsEditing = NO;
    [self presentViewController:self.imgpic animated:YES completion:nil];
}

- (NSString*)generateUniqueName
{
    NSDate *date = [NSDate date];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    NSString *uniqueName = [NSString stringWithFormat:@"IMG%f.png", timeInterval];
    return uniqueName;
}

- (IBAction)saveToLocal:(id)sender
{
    UIImage *img = self.selectedImg.image;
    
    if(img)
    {
        NSData *imgData = UIImagePNGRepresentation(img);
        NSString *imgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/MyFolder"];
        
        NSError *error;
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:imgPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:imgPath withIntermediateDirectories:NO attributes:nil error:&error];
        
        if(error)
            NSLog(@"error : %@", [error localizedDescription]);
        
        NSString *pathComponenet = [NSString stringWithFormat:@"Documents/MyFolder/%@", [self generateUniqueName]];
        imgPath = [NSHomeDirectory() stringByAppendingPathComponent:pathComponenet];
        [imgData writeToFile:imgPath atomically:YES];
        [imgData writeToFile:imgPath options:NSDataWritingAtomic error:&error];
        
        if(!error)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Image Saved" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            [self.selectedImg setImage:nil];
        }
        else
            NSLog(@"error : %@", [error localizedDescription]);
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [self.imgpic dismissViewControllerAnimated:YES completion:^{
        [self.selectedImg setImage:img];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imgpic dismissViewControllerAnimated:YES completion:nil];
}

- (void) showSelectedImage
{
    NSString *imgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/MyFolder"];
    NSError *error;
    NSArray *dirContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imgPath error:&error];
    NSLog(@"dirContent : %@", dirContent);
    
    NSString *imgStr = [dirContent objectAtIndex:0];
    NSString *imgPath1 = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/MyFolder/%@", imgStr]];
    NSData *d = [[NSFileManager defaultManager] contentsAtPath:imgPath1];
    
    UIImage *img = [UIImage imageWithData:d];
    
    [self.imgpic dismissViewControllerAnimated:YES completion:^{
        [self.selectedImg setImage:img];
    }];
}

@end
