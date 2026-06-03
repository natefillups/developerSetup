return {
  "mistweaverco/kulala.nvim",
  ft = "http",
  config = function()
    -- Run a token-generating command and return ONLY a well-formed JWT.
    -- stderr is captured (not discarded) so failures surface a real error
    -- instead of silently sending an empty/garbage token -> server
    -- "Invalid App2App token: invalid format".
    local function gen_token(label, cmd)
      local handle = io.popen(cmd .. " 2>&1")
      local out = handle:read("*a") or ""
      handle:close()
      -- Pick the first line that looks like a JWT (header.payload.signature).
      local jwt = out:match("(eyJ[%w_%-]+%.[%w_%-]+%.[%w_%-]+)")
      if not jwt then
        vim.notify(
          ("kulala %s: no JWT produced.\nOutput was:\n%s"):format(label, out:gsub("%s+$", "")),
          vim.log.levels.ERROR,
          { title = "App2App token generation failed" }
        )
        return ""
      end
      return jwt
    end

    local HOME = os.getenv("HOME")
    local JH = "JAVA_HOME=$(/usr/libexec/java_home -v 17) "

    require("kulala").setup({
      ui = {
        display_mode = "float",
        winbar = true,
        win_opts = {
          wo = {
            foldenable = false,
          },
        },
      },
      custom_dynamic_variables = {
        ["$nonprodToken"] = function()
          local script = HOME .. "/Developer/ads-domain-object-management-service/scripts/generate-jwt-app2app-token.sh"
          return gen_token("$nonprodToken", JH .. script)
        end,
        ["$prodToken"] = function()
          local jar = HOME .. "/Developer/ads-domain-object-management-service/scripts/libs/generate-app2app-jwt-1.0-SNAPSHOT.jar"
          local secrets = HOME .. "/.stride-secrets/des/prd/jwtkeys"
          return gen_token("$prodToken", JH .. "java -jar " .. jar .. " -e 60 -k " .. secrets .. " -n DemandEnrichmentService")
        end,
      },
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>rr", function() require("kulala").run() end, { desc = "Run HTTP request under cursor" })
    keymap.set("n", "<leader>rl", function() require("kulala").replay() end, { desc = "Replay last HTTP request" })
    keymap.set("n", "<leader>ri", function() require("kulala").inspect() end, { desc = "Inspect current request" })
    keymap.set("n", "<leader>rt", function() require("kulala").toggle_view() end, { desc = "Toggle body/headers view" })
    keymap.set("n", "<leader>rc", function() require("kulala").copy() end, { desc = "Copy request as cURL" })
    keymap.set("n", "[r", function() require("kulala").jump_prev() end, { desc = "Jump to previous request" })
    keymap.set("n", "]r", function() require("kulala").jump_next() end, { desc = "Jump to next request" })
  end,
}
