//
//  CommentViewController.m
//  MeetMeUp
//
//  Created by Don Wettasinghe on 1/21/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *comments;
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Comments";
  
    NSString *cID = [self.comment objectForKey:@"id"];

    
    NSString *urlString = [NSString stringWithFormat:@"https://api.meetup.com/2/event_comments.json?event_id=%@&key=7c1d3d6555736235752b5e166d802a6c", cID];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         // put results in a dictionary
         NSDictionary *commentDict = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:NSJSONReadingAllowFragments
                                                                       error:&connectionError];
         NSLog(@"%@", commentDict);
         self.comments = [commentDict objectForKey:@"results"];
         [self.tableView reloadData];
     }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.comments count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
   
    NSDictionary *comment = [self.comments objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [comment objectForKey:@"comment"];
//    cell.memberLabel.text = [comment objectForKey:@"member_name"];
//    NSString *timeString = [NSString stringWithFormat:@"%@", [comment objectForKey:@"time"]];
//    timeString = [timeString substringToIndex:[timeString length] - 3];
//    //NSLog(@"timestring: %@", timeString);
//    NSTimeInterval interval = [timeString doubleValue];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
//    NSString *dateString = [NSString stringWithFormat:@"%@", date];
//    dateString = [dateString substringToIndex:[dateString length] - 6];
//    //NSLog(@"%@", date);
//    cell.timeLabel.text = dateString;
    
    return cell;
}




@end
