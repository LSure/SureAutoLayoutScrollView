######前言
在iOS开发中，随着iOS设备的屏幕尺寸不断更新，对于控件约束的添加极为重要。一些常用控件的约束添加在这里不在赘述，本文主要详细讲解UIScrollView的约束添加。在本文中将以两种方式进行实现，一种为系统的AutoLayout，另一种为借助Masonry库文件。

首先我们在storyboard或xib文件中拖入一个ScrollView，为其添加距边缘均为0的约束，即使其充满屏幕。
![屏幕快照 2017-07-17 上午9.51.45.png](http://upload-images.jianshu.io/upload_images/1767950-3e75492d4f0c9615.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

对于ScrollView的使用，我们可知的是需要为其设置两大重要属性，一为frame二为contentSize。frame用于确定其坐标位置，contentSize用于确定其可滚动的区域。

上一步我们已经为ScrollView确定好了其坐标位置即frame，接下来我们设置其可滚动的区域。但ScrollView在storyboard或xib中并不可以设置其contentSize，因此我们继续拖入一个View作为ScrollView的子视图，大家可认为此View为ScrollView的contentView，使用其来控制ScrollView的滚动区域
![屏幕快照 2017-07-17 上午9.52.57.png](http://upload-images.jianshu.io/upload_images/1767950-a76894d5ae0ce813.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

contentView作为ScrollView的子视图，设置其约束为距ScrollView边缘为0，约束添加好后发现出现了约束报错，下步我们加以解决。
![屏幕快照 2017-07-17 上午9.53.11.png](http://upload-images.jianshu.io/upload_images/1767950-7082827a6f089d26.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在解决约束报错之前我们需要考虑当前ScrollView的滚动方式
若希望ScrollView横向滚动，我们勾线如图Vertically in Container选项，即竖直居中；若希望竖向滚动，我们勾选如图Horizontally in Container选项；若希望ScrollView横向竖向均可滚动，则无需勾选任何选项，跳过此部即可。
![屏幕快照 2017-07-17 上午9.53.59.png](http://upload-images.jianshu.io/upload_images/1767950-19f4cc735b9f365a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

以横向滚动为例，高度无须操作，需要限制contentView的宽度，例如将其设置为当前屏幕宽的两倍
![屏幕快照 2017-07-17 上午9.57.39.png](http://upload-images.jianshu.io/upload_images/1767950-cc4ba42ce2217edc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

简单为contentView设置个颜色，运行项目，我们即可发现我们生成了一个可滚动的ScrollView，其frame为（0，0，self.view.bounds.size.width，self.view.bounds.size.height），contentSize为（self.view.bounds.size.width*2，self.view.bounds.size.height）

![滚动.gif](http://upload-images.jianshu.io/upload_images/1767950-95dde36e9f046944.gif?imageMogr2/auto-orient/strip)

对于contentSize我们也可以手动设置，可将contentView的宽度约束拖入代码进行更改

![约束拖动.gif](http://upload-images.jianshu.io/upload_images/1767950-fe51c410dbcb632c.gif?imageMogr2/auto-orient/strip)

例如我们在代码中重新设置其约束
```
_widthLayout.constant = [UIScreen mainScreen].bounds.size.width * 5;
```
当前ScrollView可滚动区域横向即变成了5倍屏幕的大小。

接下来我们为ScrollView设置子视图。

为了显示效果较好，我们设置UIImageView作为ScrollView子视图，首先放置第一个ImageView，设置约束为左上下边缘约束均为0。
![屏幕快照 2017-07-17 下午12.53.13.png](http://upload-images.jianshu.io/upload_images/1767950-ca6d46db46b82f8c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

继续放置第二个ImageView，这只约束为上下左右约束均为0
![屏幕快照 2017-07-17 下午12.57.58.png](http://upload-images.jianshu.io/upload_images/1767950-6a5a9d2d81d40b45.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

最后我们选中两个ImageView，设置其等宽等高。
![屏幕快照 2017-07-17 下午12.58.18.png](http://upload-images.jianshu.io/upload_images/1767950-ff2bb0eb38e8e4e7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

运行当前项目，即可实现如下效果

![效果图.gif](http://upload-images.jianshu.io/upload_images/1767950-24f67fae3188c6a0.gif?imageMogr2/auto-orient/strip)

最后放下层级关系方便大家理解

![屏幕快照 2017-07-17 下午1.22.25.png](http://upload-images.jianshu.io/upload_images/1767950-b3c9fe8a739ab900.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

使用系统的AutoLayout为UIScrollView添加约束就告一段落，在真实的开发中，使用ScrollView通常是制作广告展示位。而广告位的图片个数是动态不固定的，因此通过storyboard或xib无法实现需求中的动态添加。我们通常是For循环创建指定数量的图片（子视图），这就需要我们通过代码手动为子视图添加约束。

具体实现原理与AutoLayout的约束添加一致，详细见代码，这里使用Masonry库文件添加约束，摘取部分约束代码如下：
```
[_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(self);
}];
[_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(_scrollView);
    make.centerY.equalTo(_scrollView.mas_centerY).offset(0);
    make.width.equalTo(@(self.bounds.size.width * _imageArr.count));
}];

CGFloat space = 0;
//用于接收上一控件
UIImageView *lastImageView;
for (NSInteger i = 0; i < _imageArr.count; i++) {
    UIImageView *imageView = [self viewWithTag:1000 + i];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_top).offset(space);
        make.bottom.equalTo(_contentView.mas_bottom).offset(space);
        if (lastImageView) {
            //如果存在上一控件，设置与上一控件右边缘约束，设置等宽
            make.left.equalTo(lastImageView.mas_right).offset(space);
            make.width.equalTo(lastImageView.mas_width);
        } else {
            //不存在上一控件，设置与父视图左边缘约束，设置宽度为当前视图宽度
            make.left.equalTo(_contentView.mas_left).offset(space);
            make.width.equalTo(@(self.bounds.size.width));
        }
        if (i == _imageArr.count - 1) {
            //若为最后一个控件，设置与父视图右边缘约束
            make.right.equalTo(_contentView.mas_right).offset(space);
        }
    }];
    //接收上一控件
    lastImageView = imageView;
}

```
具体逻辑已注释标明，完整代码已上传GitHub
