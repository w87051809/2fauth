# v5.4.3-login-2

## 本次更新

- 支持账号和邮箱同时登录。
- 输入账号时，登录框显示 `账号登录`。
- 输入邮箱时，登录框显示 `邮箱登录`。
- 登录输入框改成普通文本框，不再强制邮箱格式。
- 后端会自动判断登录方式，不需要用户手动切换。
- 修复 IP 访问时 JS 被反代替换导致白屏的问题。
- 新增 Docker 一键安装脚本 `install.sh`。
- 新增 Docker Compose 示例。
- 新增 Nginx 反代示例。

## 登录方式

- 账号登录：直接输入账号，例如 `xiaopacai`。
- 邮箱登录：输入邮箱，例如 `user@qq.com`。
- 密码仍然使用原来的用户密码。

## 一键安装

```bash
bash install.sh
```

指定域名：

```bash
APP_URL="https://你的域名" HOST_PORT=8002 bash install.sh
```

指定 IP：

```bash
APP_URL="http://服务器IP:8002" HOST_PORT=8002 bash install.sh
```
