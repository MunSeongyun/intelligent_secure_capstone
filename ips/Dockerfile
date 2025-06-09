FROM rockylinux:9

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /root

# 필수 스크립트 및 설정 복사
COPY ./ips_updater.py /updater/ips_updater.py
COPY ./supervisord.conf /etc/supervisord.conf

# 필수 시스템 패키지 설치
RUN dnf -y install epel-release && \
    dnf config-manager --set-enabled crb && \
    dnf -y install \
    cmake make gcc gcc-c++ git flex bison \
    libpcap-devel pcre-devel \
    procps-ng \
    pcre2-devel libdnet-devel hwloc-devel \
    openssl-devel zlib-devel luajit-devel \
    pkgconf libmnl-devel libunwind-devel \
    libnfnetlink-devel libnetfilter_queue-devel \
    autoconf automake libtool \
    xz-devel libuuid-devel \
    hyperscan hyperscan-devel \
    gperftools-devel \
    wget vim ethtool iproute \
    supervisor && \
    dnf clean all

# Python 설치 및 패키지 설치
RUN dnf -y install python3 python3-pip && \
    pip3 install mysql-connector-python && \
    dnf clean all

# LibDAQ 설치
RUN git clone https://github.com/snort3/libdaq.git && \
    cd libdaq && \
    ./bootstrap && \
    ./configure && \
    make && \
    make install && \
    ln -s /usr/local/lib/libdaq.so.3 /lib/ && \
    ldconfig

# Snort3 설치
RUN git clone https://github.com/snort3/snort3.git && \
    cd snort3 && \
    export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig && \
    ./configure_cmake.sh --prefix=/usr/local/snort --enable-tcmalloc && \
    cd build && \
    make -j$(nproc) && \
    make install

# Supervisor가 Snort를 메인 프로세스로 실행
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
