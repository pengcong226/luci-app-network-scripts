m = Map("network_scripts", translate("Campus Network Authentication"))

s = m:section(TypedSection, "global", translate("Settings"))
s.anonymous = true

s:option(Value, "auth_url", translate("Auth URL"))
s:option(Value, "username", translate("Username"))
s:option(Value, "password", translate("Password")).password = true

return m
