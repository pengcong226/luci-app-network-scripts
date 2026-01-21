include $(TOPDIR)/rules.mk

LUCI_TITLE:=Network Scripts - Campus Auth & Multi-WAN Switch
LUCI_DESCRIPTION:=Advanced network switching and authentication system for Campus Network. \
	Includes Quality Check, Dual-WAN Switch, DingTalk Notify and History Stats.
LUCI_DEPENDS:=+curl +openssl-util +ip-full +jsonfilter
LUCI_PKGARCH:=all

PKG_VERSION:=3.0
PKG_RELEASE:=1

PKG_MAINTAINER:=PengCong226
PKG_LICENSE:=MIT

include $(TOPDIR)/feeds/luci/luci.mk

define Package/luci-app-network-scripts/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller/network-scripts
	$(INSTALL_DATA) ./luasrc/controller/network-scripts/index.lua $(1)/usr/lib/lua/luci/controller/network-scripts/index.lua
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/network-scripts
	$(INSTALL_DATA) ./luasrc/model/cbi/network-scripts/*.lua $(1)/usr/lib/lua/luci/model/cbi/network-scripts/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/network-scripts
	$(INSTALL_DATA) ./luasrc/view/network-scripts/*.htm $(1)/usr/lib/lua/luci/view/network-scripts/
	
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./root/etc/config/network_scripts $(1)/etc/config/network_scripts
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./root/etc/init.d/network_scripts $(1)/etc/init.d/network_scripts
	
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./root/usr/bin/network_switch.sh $(1)/usr/bin/network_switch.sh
	
	$(INSTALL_DIR) $(1)/usr/lib/network_scripts
	$(INSTALL_BIN) ./root/usr/lib/network_scripts/*.sh $(1)/usr/lib/network_scripts/
endef

$(eval $(call BuildPackage,luci-app-network-scripts))
