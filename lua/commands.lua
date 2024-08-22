local utils = require("utils")
local api = vim.api

-- Show file path in command bar
api.nvim_create_user_command("ShowFilePath", function()
  print(vim.fn.expand("%:p"))
end, { bang = true })

-- Toggle wrap
vim.api.nvim_create_user_command("ToggleWrap", function()
  if vim.wo.wrap then
    vim.wo.wrap = false
    print("Word wrap disabled")
  else
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.breakindent = true
    print("Word wrap enabled")
  end
end, {})

-- Register the command
api.nvim_create_user_command("FindAndReplace", utils.find_and_replace, {})

local telescope = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function telescope_find_and_replace()
  local find_pattern = ""
  local replace_pattern = ""
  -- Prompt for find pattern
  vim.ui.input({ prompt = "Find: " }, function(input)
    find_pattern = input or ""
  end)
  -- Prompt for replace pattern
  vim.ui.input({ prompt = "Replace: " }, function(input)
    replace_pattern = input or ""
  end)
  if find_pattern ~= "" and replace_pattern ~= "" then
    telescope.live_grep({
      default_text = find_pattern,
      only_sort_text = true,
      attach_mappings = function(_, map)
        map("i", "<CR>", function(prompt_bufnr)
          -- Get all matches
          local picker = action_state.get_current_picker(prompt_bufnr)
          local manager = picker.manager

          -- Close the Telescope prompt
          actions.close(prompt_bufnr)

          -- Confirm before proceeding
          local confirm = vim.fn.input("Replace in all files? (y/n): ")
          if confirm:lower() ~= 'y' then
            print("Operation cancelled.")
            return
          end

          -- Process all matches
          for entry in manager:iter() do
            local filename = entry.filename
            local lnum = entry.lnum

            -- Read file contents
            local lines = vim.fn.readfile(filename)

            -- Perform replacement
            lines[lnum] = lines[lnum]:gsub(find_pattern, replace_pattern)

            -- Write changes back to file
            vim.fn.writefile(lines, filename)
          end

          print("Replacement complete across all matching files.")
        end)
        return true
      end,
    })
  end
end

-- Register the command
vim.api.nvim_create_user_command("TelescopeFindAndReplace", telescope_find_and_replace, {})
