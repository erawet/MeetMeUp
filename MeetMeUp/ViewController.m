//
//  ViewController.m
//  MeetMeUp
//
//  Created by Don Wettasinghe on 1/20/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *metupEvents;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSURL *url=[NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=7c1d3d6555736235752b5e166d802a6c"];
//    NSURLRequest *request=[NSURLRequest requestWithURL:url];
//    
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//       
//                      NSDictionary *allEvents=[NSJSONSerialization JSONObjectWithData:data
//                                                                             options:NSJSONReadingAllowFragments
//                                                                               error:&connectionError];
//                             //  NSLog(@"%@",self.meetMeUp);
// 
//                               self.metupEvents=[allEvents valueForKey:@"results"];
//                               [self.tableView reloadData];
//        
//    }];
    [self getSubjectwithEvents:@"Mobile"];
    
}

-(void)getSubjectwithEvents:(NSString *)subject {
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=19104&text=%@&time=,1w&key=7c1d3d6555736235752b5e166d802a6c", subject];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
        
         NSDictionary *allEvents = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&connectionError];
         
        
         self.metupEvents = [allEvents objectForKey:@"results"];
         
         [self.tableView reloadData];
     }];
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
   
    [self.searchBar resignFirstResponder];
    [self getSubjectwithEvents:self.searchBar.text];
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSDictionary *dict=[self.metupEvents objectAtIndex:indexPath.row];
    cell.textLabel.text=[dict objectForKey:@"name"];

    cell.detailTextLabel.text=[[dict objectForKey:@"venue"] objectForKey:@"address_1"];;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
       return self.metupEvents.count;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    DetailViewController *dVC=[segue destinationViewController];
    NSDictionary *dict=[self.metupEvents objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    
    dVC.dataDict=dict;
}

@end
