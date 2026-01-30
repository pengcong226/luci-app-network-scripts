local m, s, o

m = Map("network_scripts", translate("Basic Configuration"), translate("Configure campus network authentication and switching parameters"))

s = m:section(NamedSection, "network_switch", "switch", translate("System Settings"))
s.anonymous = false
s.addremove = false

s:tab("general", translate("Interface Settings"))
s:tab("time", translate("Default Policy"))
s:tab("advanced", translate("Advanced Settings"))

o = s:taboption("general", Value, "broadband_interface", translate("Broadband Interface"))
o.default = "wan"; o.rmempty = false
o = s:taboption("general", Value, "broadband_device", translate("Broadband Device"))
o.default = "wan"
o = s:taboption("general", Value, "broadband_gateway", translate("Broadband Gateway IP"))
o.datatype = "ip4addr"; o.default = "172.17.21.1"
o = s:taboption("general", Value, "cpe_interface", translate("CPE Interface"))
o.default = "lan1"; o.rmempty = false
o = s:taboption("general", Value, "cpe_device", translate("CPE Device"))
o.default = "lan1"
o = s:taboption("general", Value, "cpe_gateway", translate("CPE Gateway IP"))
o.default = "192.168.8.1"; o.datatype = "ip4addr"

o = s:taboption("time", Value, "broadband_start", translate("Broadband Start Hour")); o.default = "6"; o.datatype = "range(0,23)"
o = s:taboption("time", Value, "broadband_end", translate("Broadband End Hour")); o.default = "24"; o.datatype = "range(1,24)"

o = s:taboption("advanced", Flag, "quality_check", translate("Enable Quality Check")); o.default = "1"
o = s:taboption("advanced", Value, "max_latency", translate("Max Latency (ms)")); o:depends("quality_check", "1"); o.default = "200"
o = s:taboption("advanced", Value, "max_packet_loss", translate("Max Packet Loss (%)")); o:depends("quality_check", "1"); o.default = "20"
o = s:taboption("advanced", Value, "boot_delay", translate("Boot Delay (s)")); o.default = "30"
o = s:taboption("advanced", ListValue, "log_level", translate("Log Level"))
o:value("debug"); o:value("info"); o:value("warn"); o:value("error"); o.default = "info"

s2 = m:section(NamedSection, "campus_auth", "auth", translate("Authentication Account"))
s2.anonymous = false
s2:tab("account", translate("Account Settings"))
s2:tab("server", translate("Server Settings"))

o = s2:taboption("account", Value, "username", translate("Primary Username")); o.rmempty = false
o = s2:taboption("account", Value, "password", translate("Primary Password")); o.password = true
o = s2:taboption("account", Value, "username2", translate("Backup Username"))
o = s2:taboption("account", Value, "password2", translate("Backup Password")); o.password = true

o = s2:taboption("server", Value, "wlanacip", translate("AC IP (Hijack Gateway)"))
o.default = "172.16.1.82"; o.description = translate("Used for building authentication packets")
o = s2:taboption("server", Value, "wlanacname", translate("AC Name"))
o.default = "GXSTNU-BRAS"
o = s2:taboption("server", Value, "school_dns", translate("School DNS Server"))
o.default = "172.20.0.203"; o.description = translate("Used for resolving real authentication server IP")
o = s2:taboption("server", Value, "auth_domain", translate("Auth Domain"))
o.default = "auth.gxstnu.edu.cn"

return m