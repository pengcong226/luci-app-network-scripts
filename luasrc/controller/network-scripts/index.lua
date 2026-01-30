module("luci.controller.network-scripts.index", package.seeall)

function index()
    entry({"admin", "services", "network-scripts"}, firstchild(), _("Network Scripts"), 60).dependent = false
    entry({"admin", "services", "network-scripts", "status"}, call("action_status"), _("Status"), 10)
    entry({"admin", "services", "network-scripts", "config"}, cbi("network-scripts/config"), _("Configuration"), 20)
    entry({"admin", "services", "network-scripts", "schedule"}, cbi("network-scripts/schedule"), _("Schedule"), 25)
    entry({"admin", "services", "network-scripts", "notify"}, cbi("network-scripts/notify"), _("Notification"), 28)
    entry({"admin", "services", "network-scripts", "logs"}, call("action_logs"), _("Logs"), 30)
    entry({"admin", "services", "network-scripts", "history"}, call("action_history"), _("Statistics"), 35)
    entry({"admin", "services", "network-scripts", "control"}, call("action_control"), _("Manual Control"), 40)
    
    entry({"admin", "services", "network-scripts", "api", "status"}, call("api_status")).leaf = true
    entry({"admin", "services", "network-scripts", "api", "lock"}, call("api_lock")).leaf = true
    entry({"admin", "services", "network-scripts", "api", "run"}, call("api_run")).leaf = true
    entry({"admin", "services", "network-scripts", "api", "quality"}, call("api_quality")).leaf = true
    entry({"admin", "services", "network-scripts", "api", "history"}, call("api_history")).leaf = true
end

function action_status() luci.template.render("network-scripts/status") end
function action_history() luci.template.render("network-scripts/history") end
function action_control() luci.template.render("network-scripts/control") end

function action_logs()
    local sys = require "luci.sys"
    local log_file = luci.http.formvalue("file") or "switch"
    local level = luci.http.formvalue("level") or "all"
    local path = "/var/log/network_scripts/network_switch.log"
    if log_file == "auth" then path = "/var/log/network_scripts/campus_auth.log"
    elseif log_file == "history" then path = "/var/log/network_scripts/history.log" end
    
    local function html_escape(s)
        return (string.gsub(s, "[<>&\"']", {
            ["<"] = "&lt;", [">"] = "&gt;", ["&"] = "&amp;", ["\""] = "&quot;", ["'"] = "&#039;"
        }))
    end

    local cmd = "tail -n 200 " .. path
    if level ~= "all" then cmd = "grep -i '\\[" .. level:upper() .. "\\]' " .. path .. " | tail -n 200" end
    
    local raw_log = sys.exec(cmd .. " 2>/dev/null") or "No logs available"
    luci.template.render("network-scripts/logs", { content = html_escape(raw_log), log_file = log_file, level = level })
end

function api_status()
    local sys = require "luci.sys"; local http = require "luci.http"; local fs = require "nixio.fs"
    
    local state_file = "/tmp/network_scripts_state.json"
    local content = fs.readfile(state_file)
    
    if not content or content == "" then
        http.prepare_content("application/json")
        http.write_json({
            gateway="unknown", device="unknown", internet="offline", 
            lock_mode="off", auth_status="unknown", mode="starting..."
        })
    else
        http.prepare_content("application/json")
        http.write(content)
    end
end

function api_quality()
    api_status() 
end

function api_lock()
    local sys = require "luci.sys"; local http = require "luci.http"
    sys.exec("/usr/bin/network_switch.sh lock " .. (http.formvalue("mode") or "off") .. " " .. (http.formvalue("duration") or "0"))
    http.prepare_content("application/json"); http.write_json({success=true})
end

function api_run()
    local sys = require "luci.sys"; local http = require "luci.http"; local action = http.formvalue("action")
    if action == "test" then
        http.prepare_content("text/plain"); http.write(sys.exec("/usr/bin/network_switch.sh test 2>&1"))
    elseif action == "diagnose" then
        http.prepare_content("text/plain"); http.write(sys.exec("/usr/lib/network_scripts/campus_auth.sh diagnose 2>&1"))
    else
        local cmd = "/usr/bin/network_switch.sh"
        if action == "auth" then cmd = "/usr/lib/network_scripts/campus_auth.sh login"; elseif action == "logout" then cmd = "/usr/lib/network_scripts/campus_auth.sh logout" end
        sys.exec(cmd .. " >/dev/null 2>&1 &")
        http.prepare_content("application/json"); http.write_json({success=true})
    end
end

function api_history()
    local sys = require "luci.sys"; local http = require "luci.http"
    local stats = sys.exec(". /usr/lib/network_scripts/common.sh && get_statistics " .. (http.formvalue("period") or "today"))
    local recent = sys.exec("tail -n 50 /var/log/network_scripts/history.log 2>/dev/null")
    http.prepare_content("application/json"); http.write('{"stats":' .. stats .. ',"recent":"' .. recent:gsub("\n", "\\n"):gsub('"', '\\"') .. '"}')
end