FROM alpine:latest

RUN apk add --no-cache wget tar

WORKDIR /app

# 下载 sing-box 官方程序

RUN wget https://github.com/SagerNet/sing-box/releases/download/v1.10.1/sing-box-1.10.1-linux-amd64.tar.gz && \

tar -zxvf sing-box-1.10.1-linux-amd64.tar.gz && \

mv sing-box-1.10.1-linux-amd64/sing-box . && \

rm -rf sing-box-1.10.1-linux-amd64*


# 2. 下载并安装 frpc
RUN wget https://github.com/fatedier/frp/releases/download/v0.58.1/frp_0.58.1_linux_amd64.tar.gz && \
    tar -zxvf frp_0.58.1_linux_amd64.tar.gz && \
    mv frp_0.58.1_linux_amd64/frpc . && \
    rm -rf frp_0.58.1_linux_amd64*

# 3. 复制配置文件和启动脚本
COPY config.json .
COPY frpc.toml .
COPY start.sh .
# 赋予脚本执行权限
RUN chmod +x start.sh

EXPOSE 8080

CMD ["./sing-box", "run", "-c", "config.json", "./start.sh"]
