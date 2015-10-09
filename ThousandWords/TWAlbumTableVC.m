//
//  TWAlbumTableVC.m
//  ThousandWords
//
//  Created by Dustin M on 10/5/15.
//  Copyright © 2015 Vento. All rights reserved.
//

#import "TWAlbumTableVC.h"
#import "Album.h"

@interface TWAlbumTableVC ()

@end

@implementation TWAlbumTableVC

-(NSMutableArray *)albums
{
    if (!_albums) _albums = [[NSMutableArray alloc] init];
    return _albums;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSFetchRequest *fetchReqest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    fetchReqest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];
    
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSError *error = nil;
    NSArray *fetchedAlbums = [context executeFetchRequest:fetchReqest error:&error];
    self.albums = [fetchedAlbums mutableCopy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addAlbumBarButtonItemPressed:(UIBarButtonItem *)sender
{
    UIAlertController *newAlbumAlertView = [UIAlertController alertControllerWithTitle:@"Enter new album name" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {[newAlbumAlertView dismissViewControllerAnimated: YES completion:nil];
        }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [newAlbumAlertView dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [newAlbumAlertView addAction:ok];
    [newAlbumAlertView addAction:cancel];
    
    [self presentViewController:newAlbumAlertView animated:YES completion:nil];
}

#pragma mark - helper methods

- (Album *)albumWithName:(NSString *)name
{
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    Album *album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    
    album.name = name;
    album.date = [NSDate date];
    
    NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"%@", error);
    }
    
    return album;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertController *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1){
        NSString *alertText = [alertView.textFields objectAtIndex:0].text
        [self.albums addObject:[self albumWithName:alertText]];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.albums count] - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.albums count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    Album *selectedAlbum = self.albums[indexPath.row];
    cell.textLabel.text = selectedAlbum.name;
    
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
