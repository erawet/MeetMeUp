//
//  DetailViewController.m
//  MeetMeUp
//
//  Created by Don Wettasinghe on 1/20/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import "DetailViewController.h"
#import "CommentViewController.h"
#import "WebViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *eventName;
@property (weak, nonatomic) IBOutlet UILabel *rsvpCount;
@property (weak, nonatomic) IBOutlet UITextView *groupInfo;
@property (weak, nonatomic) IBOutlet UIWebView *eventDetails;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Event Details";
   
    NSString *name = [self.dataDict objectForKey:@"name"];
    if (name.length > 60) {
        [self.eventName setFont:[UIFont systemFontOfSize:13]];
    }
    self.eventName.text = [self.dataDict objectForKey:@"name"];
    self.eventName.editable = NO;
    
    NSString *rsvp = [NSString stringWithFormat:@"RSVP COUNT: %@", [self.dataDict objectForKey:@"yes_rsvp_count"]];
    self.rsvpCount.text = rsvp;
   
    NSString *groupName = [[self.dataDict objectForKey:@"group"] objectForKey:@"name"];
    self.groupInfo.text = [NSString stringWithFormat:@"HOSTED BY: \n %@", groupName];
    self.groupInfo.editable = NO;
    // set description
    NSString *desc = [self.dataDict objectForKey:@"description"];
    NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
                            "<head> \n"
                            "<style type=\"text/css\"> \n"
                            "body {font-family: \"%@\"; font-size: %@;}\n"
                            "</style> \n"
                            "</head> \n"
                            "<body>%@</body> \n"
                            "</html>", @"helvetica-light", [NSNumber numberWithInt:14], desc];
    [self.eventDetails loadHTMLString:htmlString baseURL:nil];
    

    NSLog(@"Pass data: %@",self.dataDict);
}
- (IBAction)onCommentPress:(id)sender {
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   
    if ([segue.identifier isEqualToString:@"goToComment"]) {
        CommentViewController *cVC=[segue destinationViewController];
        cVC.comment=self.dataDict;
    }else if([segue.identifier isEqualToString:@"goToWeb"]){
        WebViewController *wVC=[segue destinationViewController];
        wVC.urlString=[self.dataDict objectForKey:@"event_url"];
    }
    
    
    
}


@end
