echo "hshe于2025年2月3日"
echo "后台启动ollama serve"
echo "后台启动ollama..."
echo "如果存在 nohup.out 文件则删除文件"
rm -rf nohup.out 
echo  "启动 ollama serve 脚本"
nohup ollama serve &
sleep 10
echo "启动deepseek-r1:1.5b"
ollama run deepseek-r1:1.5b 
 
 
 
