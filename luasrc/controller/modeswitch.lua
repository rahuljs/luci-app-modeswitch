module("luci.controller.modeswitch", package.seeall)

function index()
    entry({"admin", "system", "modeswitch"}, template("modeswitch"), _("Mode Switch"), 65).dependent = true
    entry({"admin", "system", "modeswitch", "status"}, call("action_status")).leaf = true
    entry({"admin", "system", "modeswitch", "set"}, call("action_set")).leaf = true
end

function action_status()
    local sys = require "luci.sys"
    local http = require "luci.http"
    local raw = sys.exec("/usr/sbin/mr3020-switch-handler --status")
    http.prepare_content("application/json")
    http.write(raw or '{"error":"no_output"}')
end

function action_set()
    local sys = require "luci.sys"
    local http = require "luci.http"
    local mode = http.formvalue("mode") or "auto"
    if mode == "auto" or mode == "3g" or mode == "wisp" or mode == "ap" then
        sys.exec("/usr/sbin/mr3020-switch-handler --set " .. mode)
        action_status()
    else
        http.prepare_content("application/json")
        http.write('{"error":"invalid_mode"}')
    end
end
