-- telescope heading picker
vim.keymap.set("n", "toc", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local headings = {}
  for i, line in ipairs(lines) do
    local hashes, text = line:match("^(#+)%s+(.*)")
    if hashes then
      local indent = string.rep("  ", #hashes - 1)
      table.insert(headings, { display = indent .. text, lnum = i })
    end
  end
  require("telescope.pickers").new({ layout_config = { prompt_position = "top" } }, {
    prompt_title = "Headings",
    sorting_strategy = "ascending",
    finder = require("telescope.finders").new_table({
      results = headings,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.display,
          ordinal = entry.display,
          lnum = entry.lnum,
          filename = vim.api.nvim_buf_get_name(0),
        }
      end,
    }),
    previewer = require("telescope.config").values.grep_previewer({}),
    sorter = require("telescope.config").values.generic_sorter({}),
    attach_mappings = function(buf, map)
      require("telescope.actions").select_default:replace(function()
        require("telescope.actions").close(buf)
        vim.api.nvim_win_set_cursor(0, { require("telescope.actions.state").get_selected_entry().lnum, 0 })
      end)
      return true
    end,
  }):find()
end, { buffer = 0 })

-- number all headings (0-indexed, hierarchical)
vim.keymap.set("n", "hn", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local counter = { -1, -1, -1, -1, -1, -1 }
  for i, line in ipairs(lines) do
    local hashes, text = line:match("^(#+)%s+(.*)")
    if hashes then
      local depth = #hashes
      counter[depth] = counter[depth] + 1

      for k = 1, depth do
        if counter[k] == -1 then
          counter[k] = 0
        end
      end
      for k = depth + 1, 6 do
        counter[k] = -1
      end
      local number = table.concat(counter, ".", 1, depth)
      local clean = text:gsub("^[%d%.]+%.?%s*", "")
      local out = table.concat({ hashes, number, clean }, " ")
      vim.api.nvim_buf_set_lines(0, i - 1, i, false, { out })
    end
  end
end, { buffer = 0 })

-- remove all heading numbers
vim.keymap.set("n", "hr", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for i, line in ipairs(lines) do
    local hashes, text = line:match("^(#+)%s+(.*)")
    if hashes then
      local clean = text:gsub("^[%d%.]+%.?%s*", "")
      vim.api.nvim_buf_set_lines(0, i - 1, i, false, { hashes .. " " .. clean })
    end
  end
end, { buffer = 0 })
