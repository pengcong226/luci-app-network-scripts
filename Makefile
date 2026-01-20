include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-network-scripts
PKG_VERSION:=3.0
PKG_RELEASE:=Pro

PKG_MAINTAINER:=PengCong226
PKG_LICENSE:=MIT

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-network-scripts
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=Network Authentication & Keepalive Scripts
  DEPENDS:=+luci-base +curl +wget
  PKGARCH:=all
endef

define Package/luci-app-network-scripts/description
  Advanced network authentication scripts with keepalive functionality.
  Supports Campus Network authentication, multi-wan scenarios, and automatic reconnection.
endef

define Build/Compile
endef

define Package/luci-app-network-scripts/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./root/usr/bin/campus_auth.sh $(1)/usr/bin/campus_auth.sh
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./root/etc/init.d/network_scripts $(1)/etc/init.d/network_scripts
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./luasrc/controller/network_scripts.lua $(1)/usr/lib/lua/luci/controller/network_scripts.lua
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./luasrc/model/cbi/network_scripts.lua $(1)/usr/lib/lua/luci/model/cbi/network_scripts.lua
endef

$(eval $(call BuildPackage,luci-app-network-scripts))
