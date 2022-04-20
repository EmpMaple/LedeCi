#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 删除自定义源默认的 argon 主题
rm -rf package/lean/luci-theme-argon

# 拉取 argon 原作者的源码
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon

# 替换默认主题为 luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/' feeds/luci/collections/luci/Makefile



# Modify default IP
sed -i 's/192.168.1.1/18.8.8.1/g' package/base-files/files/bin/config_generate


# 根据编译环境生成默认配置
make defconfig
#mkdir bin
# 对比默认配置的差异部分生成配置文件（可以理解为增量）
./scripts/diffconfig.sh > seed.config
