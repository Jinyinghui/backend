#!/bin/sh

# 在后台启动 frpc (注意新版 frp 使用 .toml 配置文件)
./frpc -c ./frpc.toml &

# 在前台启动 sing-box，阻塞主进程以保持容器运行
./sing-box run -c config.json
