// Copyright (C) 2019 Beijing Bytedance Network Technology Co., Ltd.

#import "BEModernFilterPickerView.h"
#import "BEModernFilterCollectionViewCell.h"
#import "BEEffectResponseModel.h"
#import <Masonry/Masonry.h>
#import "BEModernEffectPickerControlFactory.h"

@interface BEModernFilterPickerView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray <BEEffect *>*filters;
@property (nonatomic, weak) NSIndexPath* currentSelectedCellIndexPath;
@end

@implementation BEModernFilterPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).with.offset(15);
            make.leading.bottom.trailing.equalTo(self);
        }];
    }
    return self;
}

#pragma mark - public
- (void)refreshWithFilters:(NSArray<BEEffect *> *)filters {
    self.filters = filters;
    
    [self.collectionView reloadData];
}

- (void)setAllCellsUnSelected{
    if (_currentSelectedCellIndexPath){
        [self.collectionView deselectItemAtIndexPath:_currentSelectedCellIndexPath animated:false];
        _currentSelectedCellIndexPath = nil;
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.filters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BEModernFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[BEModernFilterCollectionViewCell be_identifier] forIndexPath:indexPath];
    [cell configureWithFilter:self.filters[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _currentSelectedCellIndexPath = indexPath;
    
    if ([self.delegate respondsToSelector:@selector(filterPicker:didSelectFilterPath:)]) {
        [self.delegate filterPicker:self didSelectFilterPath:self.filters[indexPath.row].filePath];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(56, 80);
}


#pragma mark - getter && setter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 21;
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 20, 5, 20);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[BEModernFilterCollectionViewCell class] forCellWithReuseIdentifier:[BEModernFilterCollectionViewCell be_identifier]];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}


@end
