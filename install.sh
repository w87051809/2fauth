#!/usr/bin/env sh
set -eu

IMAGE_NAME="${IMAGE_NAME:-2fauth-account-login:5.4.3}"
CONTAINER_NAME="${CONTAINER_NAME:-2fauth}"
HOST_PORT="${HOST_PORT:-8002}"
DATA_DIR="${DATA_DIR:-/DATA/AppData/2fauth}"

if [ -z "${APP_URL:-}" ]; then
  SERVER_IP="$(hostname -I 2>/dev/null | awk '{print $1}')"
  if [ -z "$SERVER_IP" ]; then
    SERVER_IP="127.0.0.1"
  fi
  APP_URL="http://$SERVER_IP:$HOST_PORT"
fi

ASSET_URL="${ASSET_URL:-$APP_URL}"
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SETTINGS_ENV="${SETTINGS_ENV:-$SCRIPT_DIR/settings.env}"

if ! command -v docker >/dev/null 2>&1; then
  echo "没有检测到 Docker，请先安装 Docker。"
  exit 1
fi

mkdir -p "$DATA_DIR"

if [ ! -f "$SETTINGS_ENV" ]; then
  if command -v openssl >/dev/null 2>&1; then
    APP_KEY_VALUE="base64:$(openssl rand -base64 32)"
  elif [ -r /dev/urandom ] && command -v base64 >/dev/null 2>&1; then
    APP_KEY_VALUE="base64:$(head -c 32 /dev/urandom | base64)"
  else
    echo "无法生成 APP_KEY，请先安装 openssl 或 base64。"
    exit 1
  fi

  cat > "$SETTINGS_ENV" <<EOF
APP_NAME=2FAuth
APP_ENV=production
APP_DEBUG=false
APP_KEY=$APP_KEY_VALUE
APP_TIMEZONE=Asia/Shanghai
LOG_CHANNEL=daily
DB_CONNECTION=sqlite
DB_DATABASE=/srv/database/database.sqlite
CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_CONNECTION=sync
MAIL_MAILER=log
EOF
  echo "已生成 settings.env。"
else
  echo "检测到已有 settings.env，保留原配置。"
fi

echo "开始构建镜像：$IMAGE_NAME"
docker build -t "$IMAGE_NAME" "$SCRIPT_DIR"

if docker ps -a --format '{{.Names}}' | grep -Fx "$CONTAINER_NAME" >/dev/null 2>&1; then
  echo "检测到旧容器，正在重建：$CONTAINER_NAME"
  docker stop "$CONTAINER_NAME" >/dev/null 2>&1 || true
  docker rm "$CONTAINER_NAME" >/dev/null 2>&1 || true
fi

docker run -d \
  --name "$CONTAINER_NAME" \
  --restart always \
  -p "$HOST_PORT:8000" \
  --env-file "$SETTINGS_ENV" \
  -e APP_URL="$APP_URL" \
  -e ASSET_URL="$ASSET_URL" \
  -e TRUSTED_PROXIES="*" \
  -e DB_CONNECTION="sqlite" \
  -e DB_DATABASE="/srv/database/database.sqlite" \
  -v "$DATA_DIR:/2fauth" \
  "$IMAGE_NAME" >/dev/null

echo "安装完成。"
echo "访问地址：$APP_URL"
echo "容器名称：$CONTAINER_NAME"
echo "数据目录：$DATA_DIR"
