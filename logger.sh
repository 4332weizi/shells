#!/bin/bash
## 写日志
## 参数1：字符串
## 参数2：颜色 (红色：失败报错，绿色：成功，黄色：警告)

function log()
{
    var_str=$1
    var_color=$2
    var_curr_timestamp=`date "+%Y-%m-%d %H:%M:%S"`

    ## 判断参数1 是否是空字符串
    if [ "x${var_str}" == "x" ];then
        var_str=""
    else
        var_str="${var_curr_timestamp} ${var_str}"
    fi

    ## 判断颜色
    if [ "${var_color}" == "green" ];then
        var_str="\n\033[32m${var_str}\033[0m"
    elif [ "${var_color}" == "yellow" ];then
        var_str="\033[33m${var_str}\033[0m"
    elif [ "${var_color}" == "red" ];then
        var_str="\033[1;41;33m${var_str}\033[0m"
    else
        var_str="\033[37m${var_str}\033[0m"
    fi

    ## 打印输出
    echo -e "${var_str}"
    ## 写入日志文件
    #echo -e "${var_str}" >> ${var_path}/test_${var_curr_timestamp}.log 2>&1
}

function log_e(){
    log $1 red
}

function log_w(){
    log $1 yellow
}

function log_i(){
    log $1 green
}
