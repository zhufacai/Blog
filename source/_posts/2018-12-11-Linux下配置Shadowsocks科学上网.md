---
layout: post
cid: 1048
title: Linux下配置Shadowsocks科学上网
slug: linux下部署科学上网以及实现bbr加速
date: 2018-12-11 01:10:28
timezone: UTC+8
updated: 2020/12/16 20:12:54
status: publish
author: Joker
categories: 
  - Codes
tags: 
---

- 环境：CentOS7X64

## 一、下载脚本

```
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-libev.sh
```

## 二、增加执行权限

```
chmod +x shadowsocks-libev.sh
```

## 三、运行

```
./shadowsocks-libev.sh 2>&1 | tee shadowsocks-libev.log
```

安装过程中会提示配置端口、密码、加密方式。

## 四、卸载

```
./shadowsocks-libev.sh uninstall
```

## 五、控制

启动

```
/etc/init.d/shadowsocks start
```

停止

```
/etc/init.d/shadowsocks stop
```

重启

```
/etc/init.d/shadowsocks restart
```

查看状态

```
/etc/init.d/shadowsocks status
```

