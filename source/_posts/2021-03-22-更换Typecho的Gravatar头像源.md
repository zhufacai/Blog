---
layout:  post
id:  1844
title:  更换Typecho的Gravatar头像源
slug:  1844
categories: 
- Codes
tags:  
author:  Joker
date:  2021-03-22 12:22:00
timezone: UTC+8
---



打开var/Typecho/Common.php，找到下面的代码，大概在934行。


    $url = $isSecure ? 'https://secure.gravatar.com' : 'http://www.gravatar.com';
    $url .= '/avatar/';
     
    if (!empty($mail)) {
        $url .= md5(strtolower(trim($mail)));
    }
     
    $url .= '?s=' . $size;
    $url .= '&amp;r=' . $rating;
    $url .= '&amp;d=' . $default;
     
    return $url;


替换为：


    $url = $isSecure ? 'https://cdn.v2ex.com/gravatar/' : 'http://gravatar.duoshuo.com/avatar/';
     
    if (!empty($mail)) {
        $url .= md5(strtolower(trim($mail)));
    }
     
    $url .= '?s=' . $size;
    $url .= '&amp;r=' . $rating;
    $url .= '&amp;d=' . $default;
     
    return $url;
