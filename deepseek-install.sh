echo "hshe于2025年2月3日"
pkg install wget -y

echo "下载正常启动时用的deepseek-installer.sh脚本"
sleep 10

wget  https://ghfast.top/https://raw.githubusercontent.com/hlh2518/deepseek-r1-termux-localinstall/main/deepseek-installler.sh

chmod +x deepseek-installer.sh

./deepseek-installer.sh
 
