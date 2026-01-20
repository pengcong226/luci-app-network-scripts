# Network Authentication Scripts (v3.0 Pro)

> **校园网认证、断网自动重连、多拨保活一站式解决方案**

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![Version](https://img.shields.io/badge/version-3.0%20Pro-blue)

## 🌟 简介

这是专为复杂网络环境（如校园网、企业内网）设计的自动化脚本集合。它不仅仅是一个简单的认证脚本，更是一个完整的网络保活系统。

## 🔥 核心功能

1.  **多模式认证支持**：支持 GET/POST 请求，支持 Header/Cookie 自定义，适配 99% 的校园网认证系统。
2.  **智能保活 (Keepalive)**：
    *   **0点断网死锁解决**：自动检测 WAN 口状态与认证服务器连通性。当 WAN 口物理掉线但需要发送认证包时，自动添加静态路由，确保认证请求能发出。
    *   **双重检测机制**：同时监测 ICMP (Ping) 和 HTTP 状态码。
3.  **多拨兼容**：支持为 macvlan 多拨虚拟接口独立运行认证进程。

## 📂 目录结构

*   `/usr/bin/campus_auth.sh`: 核心认证逻辑脚本
*   `/etc/config/network_scripts`: 配置文件
*   `/etc/init.d/network_scripts`: 服务启动脚本

## 🚀 快速部署

下载 Release 中的 `.ipk` 文件安装即可。

```bash
opkg install luci-app-network-scripts_3.0-Pro_all.ipk
```
