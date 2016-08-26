# LZScrollPageView
可滑动切换页面的的ScrollPageView，利用CollectionView的重用机制。减小内存压力。

## 原理

其实github关于这一类型的开源其实不少，但是很多在当你有多个view，由于没有重用机制，会导致内存同时维护多个view，造成内存压力。如果我们在 scrollView 上来对其进行重用生命周期的管理会显得相对的麻烦。利用 collectionView 的自动重用机制可以较好的解决这一个问题。

## 效果

![](http://zen3-blog.oss-cn-shenzhen.aliyuncs.com/scrollPageView/iu.gif)

## 使用

说明：文件 **LZSegmentStyle.h** 注释中有样式的定义。