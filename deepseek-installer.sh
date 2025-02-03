#!/bin/bash
pkg install wget -y
echo "hshe于2025年2月3日于下关"
# 配置参数（根据实际情况调整）
USE_MIRROR="kkgithub.com"    # 首选镜像
FALLBACK_MIRROR="github.com" # 备用镜像
FORCE_SSL_INSECURE="true"    # 强制跳过SSL验证
USER_AGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36" # 模拟浏览器

# 目标包信息
DEB_PATH="/hlh2518/deepseek-r1-termux-localinstall/blob/main/ollama_0.5.7_aarch64.deb"
DEB_FILE=$(basename "$DEB_PATH")

# 生成镜像URL
build_url() {
    echo "https://$1$DEB_PATH"
}

# 智能下载
smart_download() {
    local url=$1
    local wget_opts=(
        -t 3               # 重试3次
        -T 15         # 超时15秒
        -U "$USER_AGENT"   # 模拟浏览器
        --content-disposition
    )
    
    [ "$FORCE_SSL_INSECURE" = "true" ] && wget_opts+=(--no-check-certificate)
    
    echo "正在尝试下载: $(basename "$url")"
    if ! wget "${wget_opts[@]}" "$url"; then
        echo "主镜像下载失败，尝试备用镜像..."
        local fallback_url=$(build_url "$FALLBACK_MIRROR")
        wget "${wget_opts[@]}" "$fallback_url"
    fi
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
        echo "1. 网络连接状态"
        echo "2. 手动访问测试: $primary_url"
        echo "3.稍后重试"
        echo "4.科学上网再试"
        exit 1
    fi
    
    # 安装阶段
    echo "正在安装 $DEB_FILE ..."
     dpkg -i "$DEB_FILE" || {
        echo "检测到依赖问题，尝试自动修复..."
        sudo apt install -f -y
        sudo dpkg -i "$DEB_FILE" || {
            echo "最终安装失败，请检查日志"; 
            exit 1
        }
    }
    
    echo "安装成功！验证版本："
    dpkg -s ollama | grep Version
    
    sleep 10
echo "hshe于2025年2月3日于下关"
echo "后台启动ollama serve"
echo "后台启动ollama..."
echo "如果存在 nohup.out 文件则删除文件"
rm -rf nohup.out 
echo  "启动 ollama serve 脚本"
nohup ollama serve &
sleep 10
echo "安装deepseek-r1:1.5b，并启动"
ollama run deepseek-r1:1.5b 
 
 sleep 15
 echo "deepseek-r1:1.5b本地部署成功"
cp ~/storage/downloads/deepseek.sh .  && chmod +x deepseek.sh
sleep 15
 echo "重启zerotermux(termux）后输入命令./deepseek.sh来启动"
 sleep 15
}

# 执行主程序
main