//
//  AppKlassenTableViewController.m
//  WhereWillIGoToday
//
//  Created by Thomas Strauß on 24.02.15.
//  Copyright (c) 2015 Thomas Strauß. All rights reserved.
//

#import <WhereWillIGoTodayCore/WhereWillIGoToday_Core.h>
#import "AppKlassenTableViewController.h"
#import "KlasseTableCell.h"
#import "AppVertretungTableViewController.h"

NSAttributedString *sonstiges(NSString *fach);

@interface TableEntry : NSObject
@property(strong, nonatomic) NSString *klasse;
@property(nonatomic) NSUInteger count;
@end

NSAttributedString *sonstiges(NSString *fach) {
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  ", fach]];
    [result addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, fach.length)];
    [result addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, fach.length)];
    return result;
}

NSAttributedString *entfall(NSString *fach) {
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  ", fach]];
    [result addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, fach.length)];
    [result addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, fach.length)];
    return result;
}

NSAttributedString *vertretung(NSString *fach) {
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  ", fach]];
    [result addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, fach.length)];
    [result addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, fach.length)];
    return result;
}

NSAttributedString *vertretung2(NSString *fach, NSString *neuFach) {
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@>%@  ", fach, neuFach]];
    [result addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, fach.length + neuFach.length + 1)];
    [result addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, fach.length + neuFach.length + 1)];
    return result;
}

NSString *circleKey(GT_PlanEntry *entry) {
    return [NSString stringWithFormat:@"%@-%@-%@" , entry.Fach, entry.Stunde, entry.Art ];
}

@interface AppKlassenTableViewController ()

@property(nonatomic, strong) NSArray *klassenliste;
@property(nonatomic, strong) NSDictionary *klassenplan;
@end

@implementation AppKlassenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.navigationItem.title = [NSString stringWithFormat:@"Plan vom %@", self.plan.key];

    [self loadData];
}

- (void)loadData {
    NSMutableDictionary *entries = [NSMutableDictionary dictionaryWithCapacity:self.plan.entries.count];

    NSString *lastkey;
    for (int i = 0; i < self.plan.entries.count; i++) {
        GT_PlanEntry *entry = self.plan.entries[i];
        NSString *key = entry.Klasse;
        if (!entries[key]) {
            entries[key] = [NSMutableArray array];
        }

        [((NSMutableArray *) entries[key]) addObject:entry];
    }

    self.klassenliste = [[NSArray arrayWithArray:entries.allKeys]
            sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1 compare:obj2];
            }];

    self.klassenplan = [NSDictionary dictionaryWithDictionary:entries];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.klassenliste.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KlasseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[KlasseTableCell identifier] forIndexPath:indexPath];

    NSString *klasse;

    klasse = self.klassenliste[indexPath.row];
    NSUInteger count = [self.klassenplan[klasse] count];

    __block NSMutableArray *subjects = [NSMutableArray arrayWithCapacity:count];
    __block NSMutableDictionary *circle = [NSMutableDictionary dictionaryWithCapacity:count];
    NSArray *vertretungen = self.klassenplan[klasse];

    NSMutableAttributedString *strBuf = [[NSMutableAttributedString alloc] init];

    Kurzeintrag *ke;
    for (GT_PlanEntry *kls in vertretungen) {
        NSAttributedString *str;

        NSString *circleStr = circleKey(kls);
        NSString *artStr = [kls.Art uppercaseString];
        
        if (!circle[circleStr]) {
            circle[circleStr] = kls.Fach;

            if ([artStr isEqualToString:@"ENTFALL"]) {
                str = entfall(kls.Fach);
                ke = [Kurzeintrag kurzeintragWithMode:BF_SIGNAL_MODE_AUSFALL andTitle:kls.Fach];
            }
            else if ([artStr isEqualToString:@"VERTRETUNG"]) {
                if ([kls.Fach isEqualToString:kls.NeuFach]) {
                    str = vertretung(kls.Fach);
                    ke = [Kurzeintrag kurzeintragWithMode:BF_SIGNAL_MODE_ERSATZ andTitle:kls.Fach];
                }
                else {
                    str = vertretung2(kls.Fach, kls.NeuFach);
                    ke = [Kurzeintrag kurzeintragWithMode:BF_SIGNAL_MODE_ERSATZ
                                                 andTitle:[NSString stringWithFormat:@"%@ %@", kls.Fach, kls.NeuFach]];
                }
            }
            else if([artStr isEqualToString:@"VERANST."]) {
                str = sonstiges(@"V");
                ke = [Kurzeintrag kurzeintragWithMode:BF_SIGNAL_MODE_MITTEILUNG
                                             andTitle:@"V"];
            }
            else {
                str = sonstiges(kls.Fach);
                ke = [Kurzeintrag kurzeintragWithMode:BF_SIGNAL_MODE_MITTEILUNG
                                             andTitle:kls.Fach];
            }

            [strBuf appendAttributedString:str];
            
            if( ke ) {
                [subjects addObject:ke];
                ke = nil;
            }
        }
    };


    NSMutableParagraphStyle *pStyle = [[NSMutableParagraphStyle alloc] init];
    pStyle.alignment = NSTextAlignmentCenter;

    [strBuf addAttribute:NSParagraphStyleAttributeName value:pStyle range:NSMakeRange(0, strBuf.length)];
    [cell setKlasse:klasse withEntries:count description:strBuf andSubjects:subjects];

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    UINavigationController *navc = [segue destinationViewController];
    AppVertretungTableViewController *target = (AppVertretungTableViewController*)navc;
    NSUInteger row = self.tableView.indexPathForSelectedRow.row;
    id klasseKey = self.klassenliste[row];
    target.vertretungen = self.klassenplan[klasseKey];
}


@end
