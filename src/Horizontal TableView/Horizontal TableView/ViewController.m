//
//  ViewController.m
//  Horizontal TableView
//
//  Created by Vasiliy Kozlov on 23.12.15.
//  Copyright © 2015. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalTableViewCell.h"

typedef enum : int{
    From = 0,
    To,
    Time,
    
    SizeOfEnumParam
} Param;

#define FAKE_ITEMS_AMOUNT 1000

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *tableHolder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHolderHeight;
@property (strong, nonatomic) UITableView *horizontalTableView;

@property (strong, nonatomic) NSIndexPath *selectedParamIndexPath;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews
{
    [self.horizontalTableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.tableHolder.bounds.size.height)];
}

-(void)setupTableView {
    CGRect bounds = [self cellBounds:@"HorizontalTableViewCell"];
    self.tableHolderHeight.constant = CGRectGetHeight(bounds);
    [self.tableHolder layoutIfNeeded];
    
    self.horizontalTableView = [[UITableView alloc] initWithFrame:self.tableHolder.bounds];
    self.horizontalTableView.showsVerticalScrollIndicator = NO;
    self.horizontalTableView.showsHorizontalScrollIndicator = NO;
    self.horizontalTableView.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
    [self.horizontalTableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.tableHolder.bounds.size.height)];
    
    self.horizontalTableView.rowHeight =  self.tableHolder.bounds.size.height;
    self.horizontalTableView.backgroundColor = [UIColor clearColor];
    
    self.horizontalTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.horizontalTableView.separatorColor = [UIColor clearColor];
    
    self.horizontalTableView.dataSource = self;
    self.horizontalTableView.delegate = self;
    [self.tableHolder addSubview:self.horizontalTableView];
    
    [self.horizontalTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:SizeOfEnumParam * FAKE_ITEMS_AMOUNT / 2 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    NSIndexPath *indexPath = [self.horizontalTableView indexPathForSelectedRow];
    HorizontalTableViewCell *cell = [self.horizontalTableView cellForRowAtIndexPath:indexPath];
    cell.paramImage.image = [cell cellImageSelected:YES];
    self.selectedParamIndexPath = indexPath;
}

-(CGRect)cellBounds:(NSString *)name {
    
    NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:name owner:self options:nil];
    
    HorizontalTableViewCell *cell =  [nibArray objectAtIndex:0];
    
    return cell.bounds;
    
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return SizeOfEnumParam * FAKE_ITEMS_AMOUNT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"HorizontalTableViewCell";
    
    HorizontalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (nil == cell)
    {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"HorizontalTableViewCell" owner:self options:nil];
        
        cell = [nibArray objectAtIndex:0];
    }
    
    
    
    if ([indexPath compare:self.selectedParamIndexPath] == NSOrderedSame) {
        cell.paramImage.image = [cell cellImageSelected:YES];
    }
    else {
        cell.paramImage.image = [cell cellImageSelected:NO];
    }
    
    return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
    self.selectedParamIndexPath = indexPath;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // if decelerating, let scrollViewDidEndDecelerating: handle it
    if (decelerate == NO) {
        [self centerTable: (UITableView *)scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self centerTable:(UITableView *)scrollView];
}

- (void)centerTable:(UITableView *)tableView {
    NSIndexPath *pathForCenterCell = [tableView indexPathForRowAtPoint:CGPointMake(CGRectGetMidX(tableView.bounds), CGRectGetMidY(tableView.bounds))];
    
    [tableView scrollToRowAtIndexPath:pathForCenterCell atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    [tableView selectRowAtIndexPath:pathForCenterCell animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    self.selectedParamIndexPath = pathForCenterCell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UITableView *tableView = (UITableView *)scrollView;
    UIImage *s = [UIImage imageNamed:@"from-whence-grey"];
    UIImage *b = [UIImage imageNamed:@"from-whence-blue"];
    CGFloat min = s.size.height;
    CGFloat max = b.size.height;
    CGFloat center = tableView.frame.size.width/2.0f;
    NSArray *paths = [tableView indexPathsForVisibleRows];
    for (NSIndexPath *path in paths) {
        CGRect cellRect = [tableView rectForRowAtIndexPath:path];
        cellRect = CGRectOffset(cellRect, -tableView.contentOffset.x, -tableView.contentOffset.y);
        
        HorizontalTableViewCell *cell = [tableView cellForRowAtIndexPath:path];
        CGFloat x = CGRectGetMidY(cellRect);
        CGFloat width = CGRectGetWidth(cellRect);
        
        if (x > center - (width) && x < center) {
            cell.paramImage.image = [cell cellImageSelected:NO];
            cell.imageHeight.constant = x / center * max;
        }
        else if (x > center && x < center + (width)) {
            cell.paramImage.image = [cell cellImageSelected:NO];
            cell.imageHeight.constant =  center / x * max;
        }
        else if (x == center) {
            cell.imageHeight.constant = max;
            cell.paramImage.image = [cell cellImageSelected:YES];
        }
        else {
            cell.imageHeight.constant = min;
            cell.paramImage.image = [cell cellImageSelected:NO];
        }
        
        [cell layoutIfNeeded];
    }
    
}


@end
