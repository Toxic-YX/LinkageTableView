//
//  LFlinkageTableView.m
//  linkageTableView
//
//  Created by YuXiang on 2017/7/28.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import "LFlinkageTableView.h"

#define RGBACOLOR(r,g,b,a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface LFlinkageTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    LFlinkageTableSelectedType *_seletctedType;
    
    //  DATA SOURCE
    NSMutableArray *_leftModelsArr;
    NSMutableArray *_rightModelsArr;
    
    //  CELL IDENTIFIER
    NSString *_leftID;
    NSString *_rightID;
    
    //  CELL CLASS
    NSString *_leftCellClassStr;
    NSString *_rightCellClassStr;
    
    BOOL _isRelate;
}

/** left */
@property (nonatomic, strong) UITableView *leftTableView;
/** right */
@property (nonatomic, strong) UITableView *rightTableView;
/** left width */
@property (nonatomic, assign) CGFloat leftTableVWidth;
/** cell block */
@property (nonatomic, copy) CellConfigureBefore leftCellConfigureBlock;
@property (nonatomic, copy) CellConfigureBefore rightCellConfigureBlock;
/** delegate */
@property (weak, nonatomic) id<LFlinkageTableViewDelegate>deleagte;

@end

@implementation LFlinkageTableView

- (instancetype)initWithFrame:(CGRect)frame
                     delegate:(id<LFlinkageTableViewDelegate>)delegate
           leftTableViewWidth:(CGFloat)width
            configureLeftCell:(CellConfigureBefore)aLeftCellBlock
           configureRightCell:(CellConfigureBefore)aRightCellBlock{
    
    if (self = [super initWithFrame:frame]) {
        
        self.leftTableVWidth = width;
        self.leftCellConfigureBlock = [aLeftCellBlock copy];
        self.rightCellConfigureBlock = [aRightCellBlock copy];
        self.deleagte = delegate;
        
        [self addSubview:self.leftTableView];
        [self addSubview:self.rightTableView];
        
        [self cofing];
    }

    return self;
}

- (void)cofing {
    _isRelate = YES;
}

#pragma mark - public methond

- (void)addLeftModels:(NSArray *)leftModels rightModels:(NSArray *)rightModels {
    
    if (!leftModels || !rightModels) return;
    
    if (!_leftModelsArr) {
        _leftModelsArr = [[NSMutableArray alloc] init];
    }
    [_leftModelsArr addObjectsFromArray:leftModels];
    
    if (!_rightModelsArr) {
        _rightModelsArr = [[NSMutableArray alloc] init];
    }
    [_rightModelsArr addObjectsFromArray:rightModels];
}

#pragma mark - private methond

- (id)leftModelsAtIndexPath:(NSIndexPath *)indexPath{
    return _leftModelsArr.count > indexPath.row ? _leftModelsArr[indexPath.row] : nil;
}

- (id)rightModelsAtIndexPath:(NSIndexPath *)indexPath{
    return _rightModelsArr.count > indexPath.section ? _rightModelsArr[indexPath.section] : nil;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.leftTableView) {
        return 1;
    }else {
        return _leftModelsArr.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView == self.leftTableView) {
        return _leftModelsArr.count;
    }else {
        return [_rightModelsArr[section] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:_leftID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:_leftCellClassStr owner:nil options:nil] lastObject];
        }
        id leftModel = [self leftModelsAtIndexPath:indexPath];
        if (self.leftCellConfigureBlock) {
            self.leftCellConfigureBlock(cell, leftModel, indexPath);
        }
        return cell;
     
    }else if (tableView == self.rightTableView)  {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:_rightID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:_rightCellClassStr owner:nil options:nil] lastObject];
        }
        id leftModel = [self rightModelsAtIndexPath:indexPath];
        if (self.rightCellConfigureBlock) {
            self.rightCellConfigureBlock(cell, leftModel, indexPath);
        }
        return cell;
    }else {
        return nil;
    }

}

#pragma mark - UITableViewDelegate
// row Height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        return 50;
    }else{
        return 80;
    }
}

// head Height
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return 0;
    }else{
        return 30;
    }
}

// foot Height
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return 0;
    }else{
        return CGFLOAT_MIN;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.rightTableView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
        view.backgroundColor = RGBACOLOR(217, 217, 217, 0.7);
        UILabel *label = [[UILabel alloc]initWithFrame:view.bounds];
        label.text = [NSString stringWithFormat:@"第%@组",_leftModelsArr[section]];
        [view addSubview:label];
        return view;
    }else{
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if (_isRelate) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows]firstObject]section];
        
        if (tableView == self.rightTableView) {
            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

-(void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section{
    if (_isRelate) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows]firstObject]section];
        if (tableView == self.rightTableView) {
            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        _isRelate = NO;
        [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        
        [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else{
        [self.rightTableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _isRelate = YES;
}

#pragma mark - Getting And Setting

- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,_leftTableVWidth, self.frame.size.height)];
        _leftTableView.backgroundColor = [UIColor whiteColor];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
   
    }
    return _leftTableView;
}

- (UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(_leftTableVWidth, 0, self.frame.size.width - _leftTableVWidth, self.frame.size.height)];
        _rightTableView.backgroundColor = [UIColor whiteColor];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;

    }
    return _rightTableView;
}

- (void)setLeftCellClassName:(NSString *)leftCellClassName {
    if (!leftCellClassName) {
        return;
    }
    _leftCellClassStr = leftCellClassName;
    _leftID = leftCellClassName;
}

- (void)setRightCellClassName:(NSString *)rightCellClassName {
    if (!rightCellClassName) {
        return;
    }
    _rightCellClassStr = rightCellClassName;
     _rightID = rightCellClassName;
}

@end
