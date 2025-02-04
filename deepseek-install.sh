echo "hshe于2025年2月3日"
pkg install wget -y

# 配置参数（根据实际情况调整）
USE_MIRROR="ghfast.top/https://raw.githubusercontent.com"    # 首选镜像
#FALLBACK_MIRROR="github.com" # 备用镜像
FORCE_SSL_INSECURE="true"    # 强制跳过SSL验证
USER_AGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36" # 模拟浏览器

# 目标包信息
SH_PATH="/hlh2518/deepseek-r1-termux-localinstall/main/deepseek-installer.sh"
DEB_FILE=$(basename "$SH_PATH")

# 生成镜像URL
build_url() {
   echo "https://$1$SH_PATH"
    # echo "$1$SH_PATH"
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
    
echo "下载deepseek-installer.sh脚本"
sleep 10
wget "${wget_opts[@]}" "https://ghfast.top/https://raw.githubusercontent.com/hlh2518/deepseek-r1-termux-localinstall/main/deepseek-installer.sh"

chmod +x deepseek-installer.sh && ./deepseek-installer.sh

}

# 主流程
main() {
    # 清理旧文件
    rm -f "$DEB_FILE" 2>/dev/null
    
    # 下载阶段
    local primary_url=$(build_url "$USE_MIRROR")
    smart_download "$primary_url"
    
    # 验证下载
    if [ ! -f "$DEB_FILE" ]; then
        echo "错误：无法下载文件，请检查："
        echo "1.网络连接状态"
        echo "2.手动访问测试: $primary_url"
        echo "3.稍后重试"
        echo "4.科学上网再试"
        exit 1
    fi  

}

# 执行主程序
main