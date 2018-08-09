//
//  searchPage.m
//  NST
//
//  Created by nst on 2017/11/10.
//  Copyright © 2017年 owner. All rights reserved.
//

#import "searchPage.h"

#import "JYEqualCellSpaceFlowLayout.h"
#import "HistorySearchModel.h"
#import "HistorySearchCell.h"
@interface searchPage ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *BaseTableView;
@property (weak, nonatomic) IBOutlet UILabel *historyLable;
@property (weak, nonatomic) IBOutlet UILabel *searchLable;

@property (weak, nonatomic) IBOutlet UITextField *inputUITextField;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

//一个用来归档，一个用来显示
@property (strong,nonatomic) NSMutableArray <HistorySearchModel *>* historySearchArr;
@property (strong,nonatomic) NSMutableArray <HistorySearchModel *>* historyShowSearchArr;
@property (weak, nonatomic) IBOutlet UITableView *historySearchTableVIew;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchTableViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (assign,nonatomic) CGFloat searchCellHeight;
@property (assign,nonatomic) CGFloat thinkCellHeight;
//标志是否thinktable是否加载
@property (assign,nonatomic) BOOL loadThinkTable;
@end

@implementation searchPage

-(NSMutableArray<HistorySearchModel *> *)historySearchArr
{
    if (!_historySearchArr) {
        _historySearchArr = [NSMutableArray array];

    }
    return _historySearchArr;
}
-(NSMutableArray<HistorySearchModel *> *)historyShowSearchArr
{
    if (!_historyShowSearchArr) {
        _historyShowSearchArr = [NSMutableArray array];
        
    }
    return _historyShowSearchArr;
}

    

- (IBAction)clearHistory:(id)sender {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:@"确定清空历史记录吗?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              [self.historySearchArr removeAllObjects];
                                                              [self.historyShowSearchArr removeAllObjects];
                                                              [self saveHistorySearch];
                                                              [self.historySearchTableVIew reloadData];
                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             
                                                         }];
    
    
    [alert addAction:cancelAction];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchCellHeight = 40;
    
    [self.clearBtn setTitle:@"清除搜索记录" forState:UIControlStateNormal];
    self.clearBtn .titleLabel.font = Font_System_Regular(16);
    [self.clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
    [self.searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];

    

    [self.historySearchTableVIew registerNib:[UINib nibWithNibName:HistorySearchCellID bundle:nil] forCellReuseIdentifier:HistorySearchCellID];

    self.historySearchTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)search{
    if ([_inputUITextField.text isValid]) {
        NSLog(@"搜索了%@",_inputUITextField.text);
        self.searchLable.text = _inputUITextField.text;
        [self addHistoryModelWithText:_inputUITextField.text andType:HistorySearchSuplly];
        [self saveHistorySearch];
    }
    
}


-(void)viewDidAppear:(BOOL)animated
{ 
    [super viewDidAppear:animated];
    [self reloadSearch:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_inputUITextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//历史搜索归档
-(void)saveHistorySearch{
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [Path stringByAppendingPathComponent:@"historySearch.data"]; //注：保存文件的扩展名可以任意取，不影响。
    NSLog(@"%@", filePath);
    for (HistorySearchModel *model in self.historySearchArr ) {
        NSLog(@"----%@////",model.title);
    }
    for (HistorySearchModel *model in self.historyShowSearchArr ) {
        NSLog(@"----%@-----",model.title);
    }
    //归档
    [NSKeyedArchiver archiveRootObject:self.historySearchArr toFile:filePath];
}
- (IBAction)reloadSearch:(id)sender {
    
    [self.historyShowSearchArr removeAllObjects];
    [self readHistorySearch];
    if (self.searchCellHeight * self.historyShowSearchArr.count+250>self.BaseTableView.bottom-50) {
        self.searchTableViewHeight.constant = self.BaseTableView.height-110;
    }else{
        self.searchTableViewHeight.constant = self.searchCellHeight * self.historyShowSearchArr.count;
    }
    [self.historySearchTableVIew reloadData];
    
}
//历史搜索解档
-(void)readHistorySearch{
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [Path stringByAppendingPathComponent:@"historySearch.data"];
    //解档
    NSMutableArray<HistorySearchModel *> *personArr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//       self.historySearchArr =(NSMutableArray *) [[self.historySearchArr reverseObjectEnumerator]allObjects];
    for (HistorySearchModel *model in self.historySearchArr ) {
        NSLog(@"----%@////",model.title);
    }
    self.historySearchArr = [NSMutableArray arrayWithArray:personArr];
    self.historyShowSearchArr =[NSMutableArray arrayWithArray:(NSMutableArray *) [[self.historySearchArr reverseObjectEnumerator]allObjects]];
    for (HistorySearchModel *model in self.historySearchArr ) {
        NSLog(@"----%@////",model.title);
    }
    for (HistorySearchModel *model in self.historyShowSearchArr ) {
        NSLog(@"----%@-----",model.title);
    }
    [self.historySearchTableVIew reloadData];
}
//判断搜索记录是否重复后添加
-(void)addHistoryModelWithText:(NSString *)text andType:(HistorySearchType)type{
    //    重复的标志
    NSArray * array = [NSArray arrayWithArray: self.historySearchArr];
    BOOL isRepet = NO;
    for (HistorySearchModel *model in array) {
        if (model.type == HistorySearchSuplly &&  [model.title isEqualToString:text]) {
            [self.historySearchArr removeObject:model];
            [self.historySearchArr addObject:[HistorySearchModel initWithTitle:text andType:type]];
            isRepet = YES;
        }
    }
    if (!isRepet) {
        [self.historySearchArr addObject:[HistorySearchModel initWithTitle:text andType:type]];
    }
    NSLog(@"%@",self.historySearchArr);
    for (HistorySearchModel *model in self.historySearchArr ) {
         NSLog(@"----%@-----",model.title);
    }
//   self.historySearchArr =(NSMutableArray *) [[self.historySearchArr reverseObjectEnumerator]allObjects];
    
}


#pragma mark --tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        if (self.historyShowSearchArr.count==0) {
            [self.clearBtn setHidden:YES];
            self.historyLable.hidden = YES;
        }else{
            [self.clearBtn setHidden:NO];
            self.historyLable.hidden = NO;
        }
        return self.historyShowSearchArr.count;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return self.searchCellHeight;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        HistorySearchCell *cell = [tableView dequeueReusableCellWithIdentifier:HistorySearchCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.historyShowSearchArr[indexPath.row]];
        return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
