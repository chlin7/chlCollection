# chlCollection
1.跟随教学视频整理的一个项目结构；
2.让自己的项目目录更加合理化；
3.模仿新浪微博的一个界面。

完成项目框架搭建

完成新特性界面

代码自定义一个cell的步骤
1.新建一个集成了UITableViewCell的类

2.重写initWithStyle:reuseIdentifier: 方法
（添加所有的字控件－不需要设置数据和frame，字控件要添加到contentView）
进行子控件一次性的属性设置

3.提供2个模型
数据模型：存放文字数据等
frame模型：数据、所有子控件、frame、cell高度等

4.cell拥有frame（不直接拥有数据）

5.重写frame模型的setter方法：在这方法设置子控件的显示数据和frame