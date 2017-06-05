# headerAnimation

##### 滚动或拖动结束后的位置
<pre>
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

    isScroll = YES;
    newOrigin = self.bottomView.frame.origin.y;
    
    NSLog(@"new---%ld,old--%ld",(long)newOrigin,(long)oldOrigin);
    
    if (newOrigin  <  300) {
        if (oldOrigin - newOrigin > 0) {
            if (oldOrigin == 60) {
                [UIView animateWithDuration:0.5 animations:^{
                    self.topView.frame = CGRectMake(0, 0,GlobleWidth, 0);
                    self.bottomView.frame = CGRectMake(0, 0,GlobleWidth,GlobleHeight);
                }];
            }else
            [UIView animateWithDuration:0.5 animations:^{
                self.topView.frame = CGRectMake(0, 0,GlobleWidth, 60);
                self.bottomView.frame = CGRectMake(0, 60,GlobleWidth,GlobleHeight);
                self.centerBtn.hidden = NO;
                self.leftBtn.hidden = YES;
            }];
        }else{
            if (oldOrigin == 0) {
                [UIView animateWithDuration:0.5 animations:^{
                    
                    self.topView.frame = CGRectMake(0, 0,GlobleWidth, 60);
                    self.bottomView.frame = CGRectMake(0, 60,GlobleWidth,GlobleHeight);
                    
                }];
            }else
            [UIView animateWithDuration:0.5 animations:^{
                self.centerBtn.hidden = YES;
                self.leftBtn.hidden = NO;
                self.topView.frame = CGRectMake(0, 0,GlobleWidth, 300);
                self.bottomView.frame = CGRectMake(0, 300,GlobleWidth,GlobleHeight);
                
            }];
        }
    }

}

</pre>

#### 滚动过程中frame和origin的改变，isScroll防止弹性
<pre>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    currentOrigin = self.bottomView.frame.origin.y;
    NSLog(@"---%ld",currentOrigin);
    if (oldOrigin == 300 && scrollView.contentOffset.y < 0) {
        
    }else if (oldOrigin == 60){
        
            if (isScroll == NO) {
                self.topView.frame = CGRectMake(0, 0, GlobleWidth, headerHeight + currentOrigin);
                
                CGRect frames = self.bottomView.frame;
                frames.origin.y  -= scrollView.contentOffset.y;
                self.bottomView.frame = frames;
        }
    
    }
    else{
        if (isScroll == NO) {
            self.topView.frame = CGRectMake(0, 0, GlobleWidth, headerHeight - scrollView.contentOffset.y);
            
            CGRect frames = self.bottomView.frame;
            frames.origin.y  -= scrollView.contentOffset.y;
            self.bottomView.frame = frames;

        }
    }
}

</pre>
#### 改动后马上保存NSUserDefaults
<pre>

-(void)deleteCellButton:(id)sender{
    CollectionViewCell * cell = (CollectionViewCell *)[[sender superview] superview];
    NSIndexPath * indexpath = [self.collectionView indexPathForCell:cell];
    if (indexpath.section ==0) {
        [self.oneArray removeObjectAtIndex:indexpath.row];
    }else{
        [self.twoArray removeObjectAtIndex:indexpath.row];
    }
    [self.collectionView reloadData];
    [[NSUserDefaults standardUserDefaults]setObject:self.oneArray forKey:@"one"];
    [[NSUserDefaults standardUserDefaults]setObject:self.twoArray forKey:@"two"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

</pre>