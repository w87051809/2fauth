# 2FAuth 账号邮箱登录版

基于 `2fauth/2fauth:5.4.3` 定制，主要解决原版登录框只能按邮箱格式输入的问题。  
本版本支持账号和邮箱同时登录，适合自己部署使用。

## 一键安装

服务器已安装 Docker 的情况下，直接执行：

```bash
git clone https://github.com/w87051809/2fauth.git
cd 2fauth
bash install.sh
```

安装完成后，脚本会显示访问地址。

## 指定域名安装

```bash
git clone https://github.com/w87051809/2fauth.git
cd 2fauth
APP_URL="https://你的域名" HOST_PORT=8002 bash install.sh
```

## 指定 IP 安装

```bash
git clone https://github.com/w87051809/2fauth.git
cd 2fauth
APP_URL="http://服务器IP:8002" HOST_PORT=8002 bash install.sh
```

## 默认配置

| 项目 | 默认值 |
| --- | --- |
| 容器名 | `2fauth` |
| 镜像名 | `2fauth-xiaopacai:5.4.3-login` |
| 数据目录 | `/DATA/AppData/2fauth` |
| 宿主机端口 | `8002` |

## 改了什么

- 支持账号登录。
- 支持邮箱登录。
- 输入账号时显示 `账号登录`。
- 输入邮箱时显示 `邮箱登录`。
- 登录框不再强制邮箱格式。
- 输入普通账号不会再提示必须包含 `@`。
- 后端自动判断登录方式，不需要用户手动切换。
- 注册功能不乱改，仍然是账号、邮箱、密码。
- 修复 IP 访问时反代替换 JS 导致白屏的问题。
- 提供 Docker 一键安装脚本。
- 提供 Docker Compose 和 Nginx / 宝塔反代示例。

## 登录规则

系统会自动判断你输入的是账号还是邮箱：

| 输入内容 | 登录方式 |
| --- | --- |
| `xiaopacai` | 账号登录 |
| `user@qq.com` | 邮箱登录 |

用户不需要手动切换。

## 手动构建

```bash
docker build -t 2fauth-xiaopacai:5.4.3-login .
```

## Docker Compose

可以参考：

```text
docker-compose.yml
deploy/compose/docker-compose.yml
```

启动：

```bash
docker compose up -d
```

## Nginx / 宝塔反代

示例文件：

```text
deploy/nginx/2fauth.example.conf
```

推荐反代到：

```text
http://127.0.0.1:8002
```

注意：如果要用 IP 访问，不要对 JavaScript 文件做 `sub_filter`，只处理 HTML。  
否则前端 JS 可能被替换坏，页面会白屏。

## 目录说明

```text
patches/app/Http/Controllers/Auth/LoginController.php   后端登录判断
patches/app/Http/Requests/LoginRequest.php              登录校验规则
patches/public/build/manifest.json                      前端入口映射
patches/public/build/assets/                            前端登录页补丁
install.sh                                              一键安装脚本
Dockerfile                                              镜像构建文件
docker-compose.yml                                      Compose 示例
deploy/nginx/                                           Nginx 示例
```

## 安全提醒

不要公开这些文件：

- `settings.env`
- `.env`
- `APP_KEY`
- 数据库文件
- token
- 密码
- 私钥
