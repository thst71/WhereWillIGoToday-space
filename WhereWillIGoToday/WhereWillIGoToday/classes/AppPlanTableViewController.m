//
//  AppPlanTableViewController.m
//  WhereWillIGoToday
//
//  Created by Thomas Strauß on 23.02.15.
//  Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import "AppPlanTableViewController.h"
#import <WhereWillIGoTodayCore/WhereWillIGoToday_Core.h>
#import "PlanCell.h"
#import "SectionStatus.h"
#import "AppKlassenTableViewController.h"

@interface AppPlanTableViewController ()

@property(nonatomic, strong) PlanListView *planview;
@end


@implementation AppPlanTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {

    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.planview = [[AppBridge instance] resolveView:[PlanListView class]];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self fetchData];

    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor blueColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadList)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)reloadList {

    bool refreshDate = (self.planview.appService.device.online);

    [self fetchData];

    if (self.refreshControl) {
        NSString *title;
        UIColor *color;
        if( refreshDate ) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd MMM yyyy, HH:mm:ss"];
            title = [NSString stringWithFormat:@"Letztes update: %@", [formatter stringFromDate:[NSDate date]]];
            color = [UIColor blueColor];
        }
        else {
            title = [self.refreshControl.attributedTitle string];
            if( !title ) {
                title = @"OFFLINE";
            }
            else if(![title hasPrefix:@"OFFLINE"]) {
                title = [NSString stringWithFormat:@"OFFLINE %@", title];
            }
            color = [UIColor redColor];
        }
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:color
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;

        [self.refreshControl endRefreshing];
    }

    [[self tableView] reloadData];

}

- (void)fetchData {
//resolveView:<#(Class)clazz#>];
    [self.planview find:^(Result *result) {
                if([result isError]) {
                    self.planlist = @[[GT_Plan planWithKey:@"Fehler beim Datenabruf" andMotd:result.data]];
                }
                else {
                    self.planlist = [NSArray arrayWithArray:(NSArray *) result.data];

                    SectionStatus *states[self.planlist.count];
                    for (int i = 0; i < self.planlist.count; i++) {
                        states[i] = [SectionStatus statusWithOpen:NO];
                    }

                    self.statelist = [NSArray arrayWithObjects:states count:self.planlist.count];
                }
            }
              limit:[Limit limitWithStart:0 size:-1]
    ];

    self.favorites = [self.planview loadFavorites:self.planlist];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = 0;
    if (self.planlist) {
        count += self.planlist.count;
    }

    if( self.favorites ) {
        count += self.favorites.count;
    }

    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.planlist.count > section) {
        if ([self isOpen:section]) {
            GT_Plan *plan = [self.planlist objectAtIndex:section];
            return plan.entries.count;
        }
    }
    return 1;
}

- (BOOL)isOpen:(NSInteger)section {
    SectionStatus *status = self.statelist[section];
    return status.open;
}

- (IBAction)onDisclose:(id)sender {

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    GT_Plan *plan = (GT_Plan *) self.planlist[indexPath.section];
    if (indexPath.item == 0) {
        HeaderCell *cell = [self getHeaderCell:tableView indexPath:indexPath plan:plan];

        return cell;
    }
    else {
        return [self getCell:tableView indexPath:indexPath plan:plan];

    }
}

- (UITableViewCell *)getCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath plan:(GT_Plan *)plan {
//    NSLog(@"Index path length for section cell %@", indexPath);

    PlanCell *cell = [tableView dequeueReusableCellWithIdentifier:[PlanCell identifier] forIndexPath:indexPath];
    cell.title.text = ((GT_PlanEntry *) (plan.entries[indexPath.item])).Klasse;

    return cell;
}

- (HeaderCell *)getHeaderCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath plan:(GT_Plan *)plan {
//    NSLog(@"Index path length for section cell %@", indexPath);

    HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:[HeaderCell identifier] forIndexPath:indexPath];
    
    NSDateFormatter * keyDateFmt = [NSDateFormatter new];
    keyDateFmt.dateFormat = @"dd.MM.yyyy";
    NSString *today = [keyDateFmt stringFromDate:[NSDate date]];

    if([today isEqualToString:plan.key]) {
        cell.title.text = [NSString stringWithFormat:@"%@", plan.key];
        cell.todayMarker.backgroundColor = [UIColor orangeColor];
        // cell.todayMarker.backgroundColor = [UIColor colorWithHue:0.556 saturation:0.408 brightness:0.941 alpha:1];
    }
    else {
        cell.title.text = plan.key;
        cell.todayMarker.backgroundColor = [UIColor whiteColor];
    }
    
    NSString *motd = [self makeMotd:plan];

    cell.motd.text = motd;
    return cell;
}

- (NSString *)makeMotd:(GT_Plan *)plan {
    NSMutableString *motd = [NSMutableString string];
    [plan.motd enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *str = (NSString *) obj;
/*
        int curr = -1;
        while( str.length != curr) {
            curr = str.length;
            str = [str stringByReplacingOccurrencesOfString:@"  " withString:@" "];
        }
        if([str length] > 38) {
            str = [NSString stringWithFormat:@"%@\n%@", [str substringToIndex:38], [str substringFromIndex:38]];
        }
*/
        [motd appendString:[NSString stringWithFormat:@"%@\n", str]];
    }];
    return motd;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 203;
    }
    else {
        return 46;
    }
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    UINavigationController *navc = [segue destinationViewController];

    AppKlassenTableViewController *target = (AppKlassenTableViewController*)navc;

    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
    
    target.plan = (GT_Plan *) self.planlist[indexPath.section];
}

@end
