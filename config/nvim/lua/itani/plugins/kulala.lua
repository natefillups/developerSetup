return {
  "mistweaverco/kulala.nvim",
  ft = "http",
  config = function()
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
          local script = os.getenv("HOME") .. "/Developer/ads-domain-object-management-service/scripts/generate-jwt-app2app-token.sh"
          local handle = io.popen("JAVA_HOME=$(/usr/libexec/java_home -v 17) " .. script .. " 2>/dev/null")
          local token = handle:read("*a"):gsub("%s+$", "")
          handle:close()
          return token
        end,
        ["$prodToken"] = function()
          local jar = os.getenv("HOME") .. "/Developer/ads-domain-object-management-service/scripts/libs/generate-app2app-jwt-1.0-SNAPSHOT.jar"
          local secrets = os.getenv("HOME") .. "/.stride-secrets/des/prd/jwtkeys"
          local handle = io.popen("JAVA_HOME=$(/usr/libexec/java_home -v 17) java -jar " .. jar .. " -e 60 -k " .. secrets .. " -n DemandEnrichmentService 2>/dev/null | tail -1")
          local token = handle:read("*a"):gsub("%s+$", "")
          handle:close()
          return token
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
