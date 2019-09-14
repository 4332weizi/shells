source ./logger.sh

shells_folder=$(dirname $(readlink -f "$0"))

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

log_i 正在清理源码
cd ..
rm -r SoftEtherVPN

service=vpnserver.service
path=/etc/systemd/system/$service

log_i 正在添加开机启动服务$service
if [ -d $path ]; then
  rm $path
fi
cd $shells_folder
cp softether-vpnserver.service $path
sudo chmod +x $path
sudo systemctl daemon-reload

log_i 正在启用服务
sudo systemctl enable $service

log_i 正在启动服务
sudo systemctl start $service

log_i 检查服务状态
sudo systemctl status $service

log_i web管理平台https://\<vpn_server_hostname\>:5555/admin/
log_i 完成
