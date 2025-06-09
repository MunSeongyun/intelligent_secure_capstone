1. sudo dnf -y update
2. sudo dnf -y install git iptables iproute tcpdump wget vim curl

  
4. Docker 설치
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf -y install docker-ce docker-ce-cli containerd.io

# Docker 실행 및 자동 시작 설정
sudo systemctl enable --now docker

# Docker Compose (v2) 설치
sudo curl -L "https://github.com/docker/compose/releases/download/v2.23.3/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


4. git clone https://github.com/MunSeongyun/intelligent_secure_capstone.git
5. cd intelligent_secure_capstone
6. chmod +x host-tee-setup.sh
7. sudo ./host-tee-setup.sh

8. docker compose up -d --build
9. docker exec -it kali bash
10. hping3 -S -p 80 -i u1000 <VM_IP>

11. 룰 수동 재적용: docker exec -it ips python3 /updater/ips_updater.py
