---
layout:  post
id:  1911
title:  MySQL动态修改数据库varchar长度的方法
slug:  1911
categories: 
- Codes
tags:  
author:  Joker
date:  2022-04-20 16:37:00
timezone: UTC+8
---



最近在博客添加了一个笔记模板，所有的笔记都以文章标题的形式输出，但是发现有些笔记字数过多，标题不能完整显示，查看数据库发现title字段的类型是varchar(200)，200决定了文章标题的长度，超出部分则不显示，只需要修改varchar的值即可，方法如下：

    alter table 表名 modify column 字段名 varchar(数量);

在typecho数据库中执行`alter table typecho_contents modify column title varchar(10000);`就可以了。