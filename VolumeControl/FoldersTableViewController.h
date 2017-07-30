//
//  FoldersTableViewController.h
//  VolumeControl
//
//  Created by Pradeep on 28/07/17.
//  Copyright © 2017 Pradeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoldersTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString *documentPath;
@property (weak, nonatomic) IBOutlet UITableView *folderListTable;

@end
