//
//  ImageCollectionViewController.m
//  VolumeControl
//
//  Created by Pradeep on 25/07/17.
//  Copyright © 2017 Pradeep. All rights reserved.
//

#import "ImageCollectionViewController.h"
#import "FoldersTableViewController.h"
#import "ImageViewController.h"
#import "GlobalSelector.h"

@interface ImageCollectionViewController ()
{
    NSMutableArray *imageArray;
    NSString *selectedFolder;
    NSString *documentPath;
}
@end

@implementation ImageCollectionViewController

@synthesize collectionView = _collectionView;

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;

    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    selectedFolder = [[GlobalSelector sharedInstance] selectedFolder];
    
    NSString* path = [[GlobalSelector sharedInstance] documentPath];
    documentPath = [path stringByAppendingPathComponent:selectedFolder];
    
    NSArray *imgList = [self getAllImages];
    imageArray = [[NSMutableArray alloc] initWithArray:imgList];
    [self.collectionView reloadData];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (NSArray *) getAllImages
{
    NSError *error;
    NSArray *dirContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentPath error:&error];
    return dirContent;
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.tag = 200;
    UIImage *img = [self getImageFrom:[imageArray objectAtIndex:indexPath.row]];
    [imageview setImage:img];
    
    [cell.contentView addSubview:imageview];
    
    return cell;
}

- (UIImage *)getImageFrom:(NSString *)imgStr
{
    NSString *imgPath = [documentPath stringByAppendingPathComponent:imgStr];
    NSData *d = [[NSFileManager defaultManager] contentsAtPath:imgPath];
    
    UIImage *img = [UIImage imageWithData:d];
    return [self imageWithImage:img scaleToSize:CGSizeMake(150, 150)];
}

- (UIImage *)imageWithImage:(UIImage*)img scaleToSize:(CGSize)size
{
    CGFloat scale = MAX(size.width/img.size.width, size.height/img.size.height);
    CGFloat width = img.size.width * scale;
    CGFloat height = img.size.height * scale;
    CGRect imgRect = CGRectMake((size.width - width)/2.0, (size.height - height)/2.0, width, height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [img drawInRect:imgRect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (IBAction)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ImageViewController *imgaveiwController = [storyBoard instantiateViewControllerWithIdentifier:@"ImageViewController"];
    imgaveiwController.imageName = [imageArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:imgaveiwController animated:YES];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
