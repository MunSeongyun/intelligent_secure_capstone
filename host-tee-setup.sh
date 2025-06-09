#!/bin/bash

# 🎯 AI 분석기 컨테이너가 있는 브리지 네트워크의 고정 IP
AI_IP="172.19.0.3"

# 🎯 복사 대상 포트 (HTTP 기본 80)
PORT=80

echo "[*] TEE 설정을 위한 커널 모듈 로딩 시도..."
sudo modprobe xt_TEE 2>/dev/null
if [ $? -ne 0 ]; then
    echo "[!] 커널 모듈 'xt_TEE' 로딩 실패 또는 이미 로드됨 (무시 가능)"
fi

echo "[*] 기존 TEE 규칙 존재 여부 확인 중..."
sudo iptables -t mangle -C PREROUTING -p tcp --dport $PORT -j TEE --gateway $AI_IP 2>/dev/null

if [ $? -ne 0 ]; then
    echo "[+] 기존 규칙 없음. 새로운 TEE 규칙 추가 중..."
    sudo iptables -t mangle -A PREROUTING -p tcp --dport $PORT -j TEE --gateway $AI_IP
    echo "[✓] 트래픽 복사 완료: port $PORT → $AI_IP"
else
    echo "[i] 기존 TEE 규칙이 이미 존재함. 추가하지 않음."
fi
