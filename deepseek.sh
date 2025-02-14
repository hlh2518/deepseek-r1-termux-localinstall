#!/bin/bash
set -x
echo "hshe于2025年2月10日"
echo "后台启动ollama serve"
#echo "后台启动ollama..."
#echo "如果存在 nohup.out 文件则删除文件"
rm -rf nohup.out
echo  "启动 ollama serve 脚本"
export OLLAMA_HOST=0.0.0.0:63124
export OLLAMA_ORIGINS=*
export OLLAMA_AUTHTOKEN="sk_631242691"
nohup ollama serve &
sleep 5
#echo "启动deepseek-r1:1.5b"
#ollama run deepseek-r1:1.5b
#echo "用户:"$(whoami)
#debian