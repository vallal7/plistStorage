//
//  ViewController.m
//  pListStorage
//
//  Created by Ganesh, Ashwin on 2/4/16.
//  Copyright © 2016 Ashwin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *bugs, *animals, *scientificBugs, *scientificAnimals, *retrievedArray;
    NSString *plistPath;
}
@property (strong, nonatomic) NSArray *animalArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    animals = @[@"Cat",@"Dog",@"Bigfoot"];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma TableView Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [retrievedArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [retrievedArray objectAtIndex:indexPath.row];
    return cell;
}
- (IBAction)saveData:(id)sender {
    //Load Dictionary with your data
    plistPath = [[NSBundle mainBundle] pathForResource:@"storageList" ofType:@"plist"];
    
    NSDictionary *plistDict = [[NSDictionary alloc] initWithObjects: [NSArray arrayWithObjects: animals, nil] forKeys:[NSArray arrayWithObjects: @"Animals", nil]];
    
    NSError *error = nil;
    NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:plistDict format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    
    if(plistData)
    {
        [plistData writeToFile:plistPath atomically:YES];
    }
    else
    {
        NSLog(@"Data save error");
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Data Error"
                                      message:@"Data save error"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [self dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }

}

- (IBAction)retrieveData:(id)sender {

    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        plistPath = [[NSBundle mainBundle] pathForResource:@"storageList" ofType:@"plist"];
    }
    else
    {
        NSLog(@"No Data exists");
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"No Data"
                                      message:@"No Data exists, save data before retrieving"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [self dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    retrievedArray = [dict valueForKey:@"Animals"];
    [self.tableView reloadData];
}
@end
