//
//  TeachingVideoCollectionVC.m
//  Aladdin
//
//  Created by luo on 2017/4/9.
//  Copyright © 2017年 wenqi. All rights reserved.
//

#import "TeachingVideoCollectionVC.h"
#import "TeachingVideoCollectionViewCell.h"
@interface TeachingVideoCollectionVC ()

@end

@implementation TeachingVideoCollectionVC

static NSString * const reuseIdentifier = @"TeachingVideoCollectionViewCell";

- (instancetype)init {
    // layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.itemSize = CGSizeMake(Main_Screen_Width / 2, 165 * kScreenWidthRatio);
    
    return [super initWithCollectionViewLayout:flowLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"TeachingVideoCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    // Do any additional setup after loading the view.
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TeachingVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    
    return cell;
}

@end
