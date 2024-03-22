local M = {}
local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact"
}

function M.setup()
  local dap = require("dap")
  -- Get the prefix directory where LLVM is installed using `brew --prefix`
  local llvm_prefix = vim.fn.trim(vim.fn.system("brew --prefix llvm")) .. "/bin/lldb-vscode"
  vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

  -- https://davelage.com/posts/nvim-dap-getting-started/
  dap.adapters.lldb = {
    type = "executable",
    command = llvm_prefix, -- adjust as needed
    name = "lldb",
  }

  local lldb = {
    name = "Launch lldb",
    type = "lldb",      -- matches the adapter
    request = "launch", -- could also attach to a currently running process
    program = function()
      return vim.fn.input(
        "Path to executable: ",
        vim.fn.getcwd() .. "/target/debug/",
        "file"
      )
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  }

  dap.configurations.rust = {
    lldb,
    {
      name = "----- ↓ launch.json configs ↓ -----",
      type = "",
      request = "launch",
    },
  }

  -- For js based auto launch
  for _, language in ipairs(js_based_languages) do
    dap.configurations[language] = {
      -- Debug single nodejs files
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        runtimeArgs = { "--inspect-brk" },
        sourceMaps = true,
        skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
      },
      -- Debug nodejs processes (make sure to add --inspect when you run the process)
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        cwd = vim.fn.getcwd(),
        runtimeArgs = { "--inspect-brk" },
        sourceMaps = true,
      },
      -- Debug web applications (client side)
      {
        type = "pwa-chrome",
        request = "launch",
        name = "Launch & Debug Brave",
        url = function()
          local co = coroutine.running()
          return coroutine.create(function()
            vim.ui.input({
              prompt = "Enter URL: ",
            }, function(url)
              if url == nil or url == "" then
                return
              else
                coroutine.resume(co, url)
              end
            end)
          end)
        end,
        webRoot = vim.fn.getcwd(),
        sourceMaps = true,
        runtimeExecutable = "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser",
        protocol = "inspector",
        skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
      },
      -- Divider for the launch.json derived configs
      {
        name = "----- ↓ launch.json configs ↓ -----",
        type = "",
        request = "launch",
      },
    }
  end
end

M.keys = {
  {
    "<leader>di",
    function()
      require("dap").step_into()
    end,
    desc = "Step Into",

  },
  {
    "<leader>dO",
    function()
      require("dap").step_out()
    end,
    desc = "Step Out",
  },
  {
    "<F7>",
    function()
      require("dap").toggle_breakpoint()
    end,
    desc = "Toggle Breakpint",
  },
  {
    "<leader>do",
    function()
      require("dap").step_over()
    end,
    desc = "Step Over",

  },
  {
    "<leader>da",
    function()
      if vim.fn.filereadable(".vscode/launch.json") then
        local dap_vscode = require("dap.ext.vscode")
        dap_vscode.load_launchjs(nil, {
          ["pwa-node"] = js_based_languages,
          ["chrome"] = js_based_languages,
          ["pwa-chrome"] = js_based_languages,
        })
      end
      require("dap").continue()
    end,
    desc = "Run with Args",
  },
}

M.dependencies = {
  { "nvim-neotest/nvim-nio" },
  {
    "microsoft/vscode-js-debug",
    -- After install, build it and rename the dist directory to out
    build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
    version = "1.*",
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("dap-vscode-js").setup({
        -- Path of node executable. Defaults to $NODE_PATH, and then "node"
        -- node_path = "node",

        -- Path to vscode-js-debug installation.
        debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

        -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
        -- debugger_cmd = { "js-debug-adapter" },

        -- which adapters to register in nvim-dap
        adapters = {
          "chrome",
          "pwa-node",
          "pwa-chrome",
          "pwa-msedge",
          "pwa-extensionHost",
          "node-terminal",
        },

        -- Path for file logging
        -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

        -- Logging level for output to file. Set to false to disable logging.
        -- log_file_level = false,

        -- Logging level for output to console. Set to false to disable console output.
        -- log_console_level = vim.log.levels.ERROR,
      })
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
  },
  {
    "rcarriga/nvim-dap-ui",
    keys = {
      { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
    },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  }, {
  "theHamsta/nvim-dap-virtual-text",
  config = function()
    local dapvi = require("nvim-dap-virtual-text")
    local opts = {
      enabled = true
    }
    dapvi.setup(opts)
  end
}
}

return M
