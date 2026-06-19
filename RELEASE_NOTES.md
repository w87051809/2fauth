# v5.4.3-login-3

## 本次更新

- 修复上一版替换前端入口后，登录或刷新可能白屏的问题。
- 现在只覆盖登录页 chunk，不再替换整个前端入口。
- 登录页支持账号和邮箱自动识别。
- 输入账号时显示 `账号登录`。
- 输入邮箱时显示 `邮箱登录`。
- 后端登录会自动判断账号或邮箱。
- 一键安装脚本改回正常中文输出。

## 登录方式

- 账号登录：直接输入账号，例如 `demo_user`。
- 邮箱登录：输入邮箱，例如 `user@example.com`。
- 注册仍然填写账号、邮箱、密码。

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
