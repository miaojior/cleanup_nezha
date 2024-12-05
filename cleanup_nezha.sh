#!/bin/bash                                                                                                                                                                                                                                     # 停止和禁用所有相关服务
for service in $(systemctl list-units --type=service --state=active | grep 'nezha-agent' | awk '{print $1}'); do
    echo "Stopping service $service..."
    sudo systemctl stop "$service"
    echo "Disabling service $service..."
    sudo systemctl disable "$service"
done

# 重新加载 systemd 配置
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# 删除服务文件
for service_file in /etc/systemd/system/nezha-agent*.service; do
    if [ -f "$service_file" ]; then
        echo "Removing service file $service_file..."
        sudo rm "$service_file"
    fi
done

# 删除配置文件
for config_file in /opt/nezha/agent/config*.yml; do
    if [ -f "$config_file" ]; then
        echo "Removing config file $config_file..."
        sudo rm "$config_file"
    fi
done

echo "Cleanup completed."
