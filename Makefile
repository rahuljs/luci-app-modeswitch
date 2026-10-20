#
# Copyright (C) 2026 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI support for TP-Link TL-MR3020 3-way Mode Switch
LUCI_DEPENDS:=+kmod-gpio-button-hotplug
LUCI_PKGARCH:=all

PKG_NAME:=luci-app-modeswitch
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_MAINTAINER:=Rahul Sawant
PKG_LICENSE:=GPL-3.0-or-later

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
