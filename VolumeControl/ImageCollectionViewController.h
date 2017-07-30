//
//  ImageCollectionViewController.h
//  VolumeControl
//
//  Created by Pradeep on 25/07/17.
//  Copyright © 2017 Pradeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
