//
//  TWAlbumTableVC.h
//  ThousandWords
//
//  Created by Dustin M on 10/5/15.
//  Copyright © 2015 Vento. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWAlbumTableVC : UITableViewController

@property (strong, nonatomic) NSMutableArray *albums;

- (IBAction)addAlbumBarButtonItemPressed:(UIBarButtonItem *)sender;


@end
