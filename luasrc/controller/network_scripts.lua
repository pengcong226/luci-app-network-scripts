module("luci.controller.network_scripts", package.seeall)

function index()
	entry({"admin", "services", "network_scripts"}, cbi("network_scripts"), _("Campus Auth"), 100).dependent = true
end
