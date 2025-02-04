echo "hshe于2025年2月3日"
pkg install wget -y
# 配置参数（根据实际情况调整）
USE_MIRROR="ghfast.top/https://raw.githubusercontent.com"    # 首选镜像
#FALLBACK_MIRROR="github.com" # 备用镜像
FORCE_SSL_INSECURE="true"    # 强制跳过SSL验证
USER_AGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36" # 模拟浏览器

# 目标包信息
DEB_PATH="/hlh2518/deepseek-r1-termux-localinstall/main/deepseek-installer.sh"
DEB_FILE=$(basename "$DEB_PATH")

# 生成镜像URL
build_url() {
   echo "https://$1$DEB_PATH"
    # echo "$1$DEB_PATH"
}

# 智能下载
smart_download() {
    local url=$1
    local wget_opts=(
        -t 3               # 重试3次
        -T 10        # 超时15秒
        -U "$USER_AGENT"   # 模拟浏览器
        --content-disposition
    )
    
    [ "$FORCE_SSL_INSECURE" = "true" ] && wget_opts+=(--no-check-certificate)
    
echo "下载正常启动时用的deepseek.sh脚本"
sleep 10
wget "${wget_opts[@]}" "https://ghfast.top/https://raw.githubusercontent.com/hlh2518/deepseek-r1-termux-localinstall/main/deepseek-installer.sh"

chmod +x deepseek-installer.sh
./deepseek-installer.sh
}

# 执行主程序
main