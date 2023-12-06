#!/bin/bash
#
# Copyright (c) 2019-2023 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Custom for REDMI AX6000
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
# sed -i 's/ntp.aliyun.com/0.openwrt.pool.ntp.org/g' package/base-files/files/bin/config_generate
# sed -i 's/time1.cloud.tencent.com/1.openwrt.pool.ntp.org/g' package/base-files/files/bin/config_generate
# sed -i 's/time.ustc.edu.cn/2.openwrt.pool.ntp.org/g' package/base-files/files/bin/config_generate
# sed -i 's/cn.pool.ntp.org/3.openwrt.pool.ntp.org/g' package/base-files/files/bin/config_generate
# sed -i 's/zh_cn/auto/g' feeds/luci/modules/luci-base/root/etc/uci-defaults/luci-base 
# sed -i '/AUTOLOAD:=$(call AutoProbe,mt7915e)/a \  MODPARAMS.mt7915e:=wed_enable=Y' package/kernel/mt76/Makefile
# cp $GITHUB_WORKSPACE/lean/Redmi-AX6000/data/ddns.config feeds/packages/net/ddns-scripts/files/
# cp $GITHUB_WORKSPACE/lean/Redmi-AX6000/data/etc/banner package/base-files/files/etc/
# cp $GITHUB_WORKSPACE/lean/Redmi-AX6000/data/etc/mtd-rw package/base-files/files/etc/init.d/
# chmod 0755 package/base-files/files/etc/init.d/mtd-rw
# cp $GITHUB_WORKSPACE/lean/Redmi-AX6000/data/default-settings/zzz-default-settings package/lean/default-settings/files/
# cp $GITHUB_WORKSPACE/lean/Redmi-AX6000/data/default-settings/Makefile package/lean/default-settings/
# cp $GITHUB_WORKSPACE/lean/Redmi-AX6000/data/autocore/index.htm package/lean/autocore/files/arm/
# cp $GITHUB_WORKSPACE/lean/Redmi-AX6000/data/zones.lua feeds/luci/applications/luci-app-firewall/luasrc/model/cbi/firewall/
# cp $GITHUB_WORKSPACE/lean/Redmi-AX6000/data/mt7986a-xiaomi-redmi-router-ax6000.dts target/linux/mediatek/dts/
# cp $GITHUB_WORKSPACE/lean/Redmi-AX6000/data/leds-ws2812b.c package/kernel/leds-ws2812b/src/

# 更新当前软件包
# ilxp/luci-app-ikoolproxy ax6000_lede clash
# rm -rf package/feeds/helloworld/luci-app-ikoolproxy
# git clone https://github.com/ilxp/luci-app-ikoolproxy.git package/feeds/helloworld/luci-app-ikoolproxy

# gfwlist并不完善，总有漏网之鱼，导致了DNS被污染，基于chinadns的工作原理，简单来说就是国内DNS回应的污染IP一定是国外IP，根据这个规律，一旦国内DNS回应了国外IP那就等待可信DNS回应正确的国外IP
# 打开DHCP/DNS设置，设置DNS转发127.0.0.1#5353，启动项添加并ssh运行uci set dhcp.@dnsmasq[0].noresolv="1"; uci commit dhcp; /etc/init.d/dnsmasq restartissue，若使用dnsforwarder并且未配置addr命令这一步可以省略
rm -rf package/feeds/helloworld/chinadns-ng
git clone -b master https://github.com/w311ang/openwrt-chinadns-ng.git package/feeds/helloworld/chinadns-ng
rm -rf package/feeds/helloworld/luci-app-chinadns-ng
git clone -b luci   https://github.com/w311ang/openwrt-chinadns-ng.git package/feeds/helloworld/luci-app-chinadns-ng
