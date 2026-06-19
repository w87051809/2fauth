# 2FAuth 账号邮箱登录版

这是基于 `2fauth/2fauth:5.4.3` 的轻量定制版。

本版本只改登录相关逻辑：

- 注册仍然填写：账号、邮箱、密码。
- 登录可以输入账号。
- 登录也可以输入邮箱。
- 输入框会自动显示 `账号登录` 或 `邮箱登录`。
- 普通账号不会再被浏览器提示必须包含 `@`。
- 账户列表、验证码管理、导入导出等功能保持原版逻辑。

## 一键安装

服务器已经安装 Docker 的情况下，直接执行：

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

注意：不要对 JavaScript 文件做 `sub_filter`。只处理 HTML 就行。  
如果把 JS 文件内容替换坏，登录后可能白屏。

## 目录说明

```text
patches/app/Http/Controllers/Auth/LoginController.php   后端登录判断
patches/app/Http/Requests/LoginRequest.php              登录校验规则
patches/public/build/assets/Login-5FbYhqqZ.js           登录页输入框补丁
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
