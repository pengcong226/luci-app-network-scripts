local m, s, o
m = Map("network_scripts", translate("Schedule Policy"))
s = m:section(TypedSection, "schedule", translate("Custom Time Periods"))
s.anonymous = false
s.addremove = true
s.template = "cbi/tblsection"
o = s:option(Flag, "enabled", translate("Enable")); o.default = "0"; o.width="10%"
o = s:option(Value, "start", translate("Start")); o.datatype="range(0,23)"; o.width="20%"
o = s:option(Value, "end", translate("End")); o.datatype="range(0,24)"; o.width="20%"
o = s:option(ListValue, "use", translate("Line")); o:value("broadband"); o:value("cpe"); o.width="20%"
return m