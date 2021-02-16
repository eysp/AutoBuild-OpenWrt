#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: eSirPlayground
# Youtube Channel: https://goo.gl/fvkdwm 
#=================================================
#1. Modify default IP
cd openwrt
git clone https://github.com/garypang13/openwrt-packages.git package/openwrt-packages
rm -Rf packages/openwrt-packages/default-settings
rm -Rf packages/openwrt-packages/luci-app-adguardhome
rm -Rf packages/openwrt-packages/luci-app-openclash
git clone https://github.com/eysp/default-settings package/default-settings
git clone https://github.com/lloyd18/luci-app-npc packages/openwrt-packages/luci-app-npc
git clone https://github.com/rufengsuixing/luci-app-adguardhome packages/openwrt-packages/luci-app-adguardhome

./scripts/feeds update -a && ./scripts/feeds install -a

svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash packages/openwrt-packages/luci-app-openclash
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
#rm -Rf tools/upx && svn co https://github.com/Lienol/openwrt/trunk/tools/upx tools/upx
#rm -Rf tools/ucl && svn co https://github.com/Lienol/openwrt/trunk/tools/ucl tools/ucl
rm -Rf tools/upx && svn co https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
rm -Rf tools/ucl && svn co https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
#sed -i 's?zstd$?zstd ucl upx\n$(curdir)/upx/compile := $(curdir)/ucl/compile?g' tools/Makefile
sed -i '/dosfstools libressl/a\tools-y += ucl upx' tools/Makefil

# find target/linux/x86 -name "config*" -exec bash -c 'cat kernel.conf >> "{}"' \;

sed -i 's/max_requests 3/max_requests 20/g' package/network/services/uhttpd/files/uhttpd.config
rm -rf ./feeds/packages/lang/golang
svn co https://github.com/immortalwrt/packages/trunk/lang/golang feeds/packages/lang/golang

./scripts/feeds update -a && ./scripts/feeds install -a
cd ../
