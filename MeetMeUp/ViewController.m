//
//  ViewController.m
//  MeetMeUp
//
//  Created by Don Wettasinghe on 1/20/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *meetMeUp;
@property NSArray *meet;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url=[NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=7c1d3d6555736235752b5e166d802a6c"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
                               self.meetMeUp=[NSJSONSerialization JSONObjectWithData:data
                                                                             options:NSJSONReadingAllowFragments
                                                                               error:&connectionError];
                             //  NSLog(@"%@",self.meetMeUp);
 
                               
                               [self.tableView reloadData];
        
    }];
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
  
    self.meet=[self.meetMeUp valueForKey:@"results"];
    NSLog(@"%@",self.meet );
    NSDictionary *dict=[self.meet objectAtIndex:indexPath.row];
    
    cell.textLabel.text=[dict objectForKey:@"name"];
    
    
  //  NSArray *venue =[NSArray arrayWithObject:[meetUps objectForKey:@"venue"]];
    
  //  cell.detailTextLabel.text=[venue valueForKey:@"address_1"];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.meetMeUp.count;
}

@end
