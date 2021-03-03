#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: eSirPlayground
# Youtube Channel: https://goo.gl/fvkdwm 
#=================================================
#1. Modify default IP
sed -i 's/192.168.1.1/192.168.123.1/g' openwrt/package/base-files/files/bin/config_generate
#2.luci settings
cd openwrt
#sed -i '/wrt350nv2-builder upslug2/a\tools-y += ucl upx' tools/Makefile
git clone https://github.com/garypang13/openwrt-packages.git package/openwrt-packages
rm -Rf package/openwrt-packages/default-settings
rm -Rf package/openwrt-packages/luci-app-adguardhome
rm -Rf package/openwrt-packages/luci-app-openclash
rm -Rf package/openwrt-packages/compressed-memory
rm -Rf package/openwrt-packages/luci-app-compressed-memory
rm -Rf package/openwrt-packages/luci-app-qosv4
rm -Rf package/openwrt-packages/rtl88x2bu
rm -Rf feeds/packages/net/kcptun
git clone https://github.com/eysp/default-settings package/default-settings
git clone https://github.com/lloyd18/luci-app-npc package/openwrt-packages/luci-app-npc
git clone https://github.com/rufengsuixing/luci-app-adguardhome package/openwrt-packages/luci-app-adguardhome
svn co https://github.com/liuran001/openwrt-packages/trunk/wrtbwmon package/openwrt-packages/wrtbwmon

./scripts/feeds update -a && ./scripts/feeds install -a

svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/openwrt-packages/luci-app-openclash
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-19.07/package/lean/ipv6-helper package/ipv6-helper
#svn co https://github.com/garypang13/openwrt-packages/trunk/luci-app-turboacc package/ysp/luci-app-turboacc
svn co https://github.com/immortalwrt/packages/trunk/lang/python/Flask-RESTful feeds/packages/lang/python/Flask-RESTful
svn co https://github.com/immortalwrt/packages/trunk/lang/node-yarn feeds/packages/lang/node-yarn
svn co https://github.com/immortalwrt/packages/trunk/net/kcptun feeds/packages/net/kcptun
svn co https://github.com/immortalwrt/packages/trunk/utils/cgroupfs-mount feeds/packages/utils/cgroupfs-mount
svn co https://github.com/immortalwrt/packages/trunk/utils/containerd feeds/packages/utils/containerd
svn co https://github.com/immortalwrt/packages/trunk/utils/docker feeds/packages/utils/docker
svn co https://github.com/immortalwrt/packages/trunk/utils/dockerd feeds/packages/utils/dockerd
svn co https://github.com/immortalwrt/packages/trunk/utils/libnetwork feeds/packages/utils/libnetwork
svn co https://github.com/immortalwrt/packages/trunk/utils/runc feeds/packages/utils/runc
svn co https://github.com/immortalwrt/packages/trunk/utils/tini feeds/packages/utils/tini
svn co https://github.com/lienol/openwrt/trunk/tools/upx tools/upx
svn co https://github.com/lienol/openwrt/trunk/tools/ucl tools/ucl
#rm -Rf tools/upx && svn co https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
#rm -Rf tools/ucl && svn co https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
#sed -i 's?zstd$?zstd ucl upx\n$(curdir)/upx/compile := $(curdir)/ucl/compile?g' tools/Makefile
rm tools/Makefile && wget -P tools https://raw.githubusercontent.com/eysp/AutoBuild-OpenWrt/master/patches/Makefile

# find target/linux/x86 -name "config*" -exec bash -c 'cat kernel.conf >> "{}"' \;

sed -i 's/max_requests 3/max_requests 20/g' package/network/services/uhttpd/files/uhttpd.config
rm -rf ./feeds/packages/lang/golang
svn co https://github.com/immortalwrt/packages/trunk/lang/golang feeds/packages/lang/golang
./scripts/feeds update -a && ./scripts/feeds install -a
cd ../
