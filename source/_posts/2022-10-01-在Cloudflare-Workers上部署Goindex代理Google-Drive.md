---
title:  在Cloudflare Workers上部署Goindex代理Google Drive
slug:  在Cloudflare Workers上部署Goindex代理Google Drive
categories: 
- Codes
tags:  
author:  Joker
date:  2022-09-30 01:42:00
timezone: UTC+8
---

最近在Google drive上转存了李志的音乐合集，想做一个网页提供在线试听，但因为众所周知的原因，Google drive在墙内无法正常访问，于是就通过CloudFlare Workers部署goindex来代理Google drive。

## 一、创建 Google 项目

跳转[创建项目](https://console.cloud.google.com/projectcreate?previousPage=/projectselector2/apis/credentials/consent?supportedpurview=project&supportedpurview=project)页面，输入`项目名`之后确认`创建`

![/posts/cloudflareworkers_googledrive/pic01.png](https://blog.cetacean.top/posts/cloudflareworkers_googledrive/pic01.png)

接着会跳转到`OAuth 同意屏幕`，`User Type`选择`外部`

![/posts/cloudflareworkers_googledrive/pic02.png](https://blog.cetacean.top/posts/cloudflareworkers_googledrive/pic02.png)

修改应用注册，必填项为`应用名称`、`用户支持电子邮件`以及底下的`开发者联系信息`，其他可不填，保存即可

![/posts/cloudflareworkers_googledrive/pic03.png](https://blog.cetacean.top/posts/cloudflareworkers_googledrive/pic03.png)

![/posts/cloudflareworkers_googledrive/pic04.png](https://blog.cetacean.top/posts/cloudflareworkers_googledrive/pic04.png)

接下来的`测试用户`添加自己的邮箱即可

![/posts/cloudflareworkers_googledrive/pic05.png](https://blog.cetacean.top/posts/cloudflareworkers_googledrive/pic05.png)

## 二、开启 Google Drive API

跳转[开启 Google Drive API](https://console.developers.google.com/apis/api/drive.googleapis.com/overview)页面，开启该功能

![/posts/cloudflareworkers_googledrive/pic06.png](https://blog.cetacean.top/posts/cloudflareworkers_googledrive/pic06.png)

开启成功后如下

![/posts/cloudflareworkers_googledrive/pic07.png](https://blog.cetacean.top/posts/cloudflareworkers_googledrive/pic07.png)

## 三、创建 OAuth client ID

跳转[创建 OAuth client ID](https://console.developers.google.com/apis/credentials/oauthclient)页面，`应用类型`选择`桌面应用`，`名称`随意，完成后点击`创建`

![/posts/cloudflareworkers_googledrive/pic08.png](https://blog.cetacean.top/posts/cloudflareworkers_googledrive/pic08.png)

创建成功会返回`客户端 ID`和`客户端密钥`，**自行保存，后面需要用到**

![/posts/cloudflareworkers_googledrive/pic09.png](https://blog.cetacean.top/posts/cloudflareworkers_googledrive/pic09.png)

## 四、安装 Rclone

[下载地址](https://rclone.org/downloads/)，根据自己的系统版本选择下载之后解压

## 五、CMD 运行 Rclone

有两种方法，就Win10系统举例

1. 在`Rclone`解压的目录的地址栏输入`cmd`，打开当前路径的命令行终端
2. 在系统环境变量`Path`添加`Rclone`的路径

> 在之后获取Google Drive的refresh token时需要访问到Google的服务，所以必不可免的需要用到代理，但CMD默认是不走代理的，可自行设置临时代理。
>

## 六、设置CMD临时代理

以v2ray为例，打开设置-参数设置查看本地监听端口和协议。

在windows的cmd终端中，执行下面命令：

```
set http_proxy=socks5://127.0.0.1:10808
set https_proxy=socks5://127.0.0.1:10808
```

## 七、使用 Rclone 获取 refresh_token

在终端上执行`rclone config`，选择`n`新建，名字随意

![img](https://img-blog.csdnimg.cn/527e14910f9d47cb898d82f1be8ba8b5.png)

选择`18`即`Google Drive`

![img](https://img-blog.csdnimg.cn/ca1d917b0e474556ac2c423ad5031ae1.png)

之后填写先前获取的`client id`和`client secret`，`scope`权限选择`1`，即所有权限

![img](https://img-blog.csdnimg.cn/ab7ef00a336142b2b6f1971b7801f52e.png)

`service_account_file`回车不填即可

`Edit advanced config`也是回车默认`No`

`Use auto config`选择`n`

![img](https://img-blog.csdnimg.cn/93f1474988e34f079677a95f8dd7eb90.png)

之后就会提示输入验证码，复制`rclone authorize "drive" "xxx"`

![img](https://img-blog.csdnimg.cn/9e743564e4a44b349a50c89aeee00a14.png)

开启另外一个终端执行复制的命令，**这里需要给cmd终端设置临时代理**

之后会跳转到浏览器，登录并授权

![/posts/cloudflareworkers_googledrive/pic10.png](https://blog.cetacean.top/posts/cloudflareworkers_googledrive/pic10.png)

显示如下即代表成功获取

![/posts/cloudflareworkers_googledrive/pic11.png](https://blog.cetacean.top/posts/cloudflareworkers_googledrive/pic11.png)

回到终端复制返回的验证码，并在第一个终端输入

根据自己的盘是不是`Team Drive`选择，得到的`token`里就有我们需要的`refresh_token`

![img](https://img-blog.csdnimg.cn/d33df58eb8e44b2888e43ac4d8d9a30d.png)

## 八、部署到 Goindex到CloudFlare Workers

前往[CloudFlare](https://www.cloudflare.com/zh-cn/)，到`Workers`页面下，创建服务

![/posts/cloudflareworkers_googledrive/pic12.png](https://blog.cetacean.top/posts/cloudflareworkers_googledrive/pic12.png)

![/posts/cloudflareworkers_googledrive/pic13.png](https://blog.cetacean.top/posts/cloudflareworkers_googledrive/pic13.png)

![/posts/cloudflareworkers_googledrive/pic14.png](https://blog.cetacean.top/posts/cloudflareworkers_googledrive/pic14.png)

点击`快速编辑`，填入Goindex的源码并将`client_id` `client_secret` `refresh_token` 内容替换为自己的，保存并部署。

## 九、设置反代

因为CloudFlare的`workers.dev`域名被墙，可以添加自己的域名来访问，但需要先把域名托管到CloudFlare，也可以设置反向代理来访问`workers.dev`域名。这里通过vercel一键部署反向代理。

项目地址：[利用Vercel做反向代理,访问GitHub网站.](https://github.com/XiaoXinYo/Vercel_Reverse_Proxy)

修改[vercel.json](https://github.com/XiaoXinYo/Vercel_Reverse_Proxy/blob/main/vercel.json)中Github地址为自己的CloudFlare Workers项目地址，一键部署即可。