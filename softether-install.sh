source ./logger.sh

# install SoftEtherVPN
# see https://github.com/SoftEtherVPN/SoftEtherVPN
log_i 正在安装依赖
sudo apt -y install cmake gcc g++ libncurses5-dev libreadline-dev libssl-dev make zlib1g-dev
path=/home/SoftEtherVPN

log_i 正在clone源码到$path
git clone https://github.com/SoftEtherVPN/SoftEtherVPN.git $path

log_i 正在初始化仓库
cd $path
git submodule init && git submodule update
./configure

log_i 正在编译
make -C tmp

log_i 正在安装
make -C tmp install

cd /etc/init.d
file=vpnserver.sh

log_i 正在添加开机启动项/etc/init.d/$file
rm $file
echo "#!/bin/bash" >> $file
echo "vpnserver start" >> $file
echo "exit 0" >> $file
sudo chmod +x $file
sudo update-rc.d -f $file defaults

log_i 正在启动vpnserver
vpnserver start

log_i web管理平台https://<vpn_server_hostname>:5555/admin/
log_i 完成
# sudo update-rc.d -f $file remove
