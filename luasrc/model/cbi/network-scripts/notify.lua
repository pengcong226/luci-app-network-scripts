local m, s, o
m = Map("network_scripts", translate("Notification Settings"))
s = m:section(NamedSection, "notification", "notify", translate("DingTalk Bot Settings"))
s.anonymous = false
s:tab("basic", translate("Basic Settings"))
s:tab("trigger", translate("Trigger Conditions"))
o = s:taboption("basic", Flag, "enabled", translate("Enable Notification")); o.default = "0"
o = s:taboption("basic", Value, "dingtalk_webhook", translate("Webhook URL"))
o = s:taboption("basic", Value, "dingtalk_secret", translate("Sign Secret")); o.password = true
o = s:taboption("trigger", Flag, "notify_auth_fail", translate("Notify on Auth Failure")); o.default = "1"
o = s:taboption("trigger", Flag, "notify_switch", translate("Notify on Line Switch")); o.default = "0"
o = s:taboption("trigger", Flag, "notify_offline", translate("Notify on Network Offline")); o.default = "1"
return m