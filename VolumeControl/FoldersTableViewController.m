//
//  FoldersTableViewController.m
//  VolumeControl
//
//  Created by Pradeep on 28/07/17.
//  Copyright © 2017 Pradeep. All rights reserved.
//

#import "FoldersTableViewController.h"

@interface FoldersTableViewController ()
{
    NSMutableArray *folderListArray;
}
@end

@implementation FoldersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
    if(folderListArray == nil)
        folderListArray = [[NSMutableArray alloc] initWithArray:[self getAllFolders]];
    
    if([folderListArray containsObject:@".DS_Store"])
        [folderListArray removeObject:@".DS_Store"];
    
    [self.folderListTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFolder:)];

    self.navigationController.navigationBar.hidden = NO;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.folderListTable.tableFooterView = footerView;
    
    [self.folderListTable reloadData];
}

- (void) addFolder: (id) sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New Folder" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor blueColor];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = @"New Folder";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray *textfields = alert.textFields;
        UITextField *name = [textfields objectAtIndex:0];
        if(name.text.length > 0){
            if([self createNewFolderWithName:name.text])
                [self updateFolderListArrayWithName:name.text];
        }
        else
            [alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL) createNewFolderWithName:(NSString*)folderName
{
    
    NSString *path = [NSString stringWithFormat:@"Documents/%@", folderName];
    NSString *folderPath = [NSHomeDirectory() stringByAppendingPathComponent:path];
    
    NSError *error;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    if(error){
        NSLog(@"error : %@", [error localizedDescription]);
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error!!" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    return true;
}

- (void) updateFolderListArrayWithName:(NSString*)folderName
{
    [folderListArray addObject:folderName];
    [self.folderListTable reloadData];
}

- (NSArray *) getAllFolders
{
    NSString *imgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSError *error;
    NSArray *dirContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imgPath error:&error];
    NSLog(@"dirContent : %@", dirContent);
    return dirContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return folderListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [folderListArray objectAtIndex:indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
