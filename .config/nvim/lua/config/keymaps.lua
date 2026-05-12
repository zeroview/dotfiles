-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set

set("n", "<C-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
set("n", "<C-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
set("n", "<C-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
set("n", "<C-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
set("n", "<S-h>", "0", { desc = "Go to start of line" })
set("n", "<S-l>", "$", { desc = "Go to end of line" })
set("n", "<S-Left>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
set("n", "<S-Right>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

set("n", "<leader><space>", LazyVim.pick("files", { root = false }), { desc = "Find Files (cwd)" })
set("n", "<leader>t", function()
  Snacks.terminal(nil, { cwd = vim.uv.cwd() })
end, { desc = "Terminal" })
set("n", "<leader>T", function()
  Snacks.terminal(nil, { cwd = vim.uv.cwd(), count = 2 })
end, { desc = "Terminal 2" })

local mc = require("multicursor-nvim")
-- Add or skip cursor above/below the main cursor.
set({ "n", "x" }, "<c-up>", function()
  mc.lineAddCursor(-1)
end)
set({ "n", "x" }, "<c-down>", function()
  mc.lineAddCursor(1)
end)
set({ "n", "x" }, "<c-s-up>", function()
  mc.lineSkipCursor(-1)
end)
set({ "n", "x" }, "<c-s-down>", function()
  mc.lineSkipCursor(1)
end)

-- Add or skip adding a new cursor by matching word/selection
set({ "n", "x" }, "<c-n>", function()
  mc.matchAddCursor(1)
end)
set({ "n", "x" }, "<c-m>", function()
  mc.matchSkipCursor(1)
end)
set({ "n", "x" }, "<c-a-n>", function()
  mc.matchAddCursor(-1)
end)
set({ "n", "x" }, "<c-a-m>", function()
  mc.matchSkipCursor(-1)
end)

-- Add and remove cursors with control + left click.
set("n", "<c-leftmouse>", mc.handleMouse)
set("n", "<c-leftdrag>", mc.handleMouseDrag)
set("n", "<c-leftrelease>", mc.handleMouseRelease)

-- Mappings defined in a keymap layer only apply when there are
-- multiple cursors. This lets you have overlapping mappings.
mc.addKeymapLayer(function(layerSet)
  -- Select a different cursor as the main one.
  layerSet({ "n", "x" }, "<left>", mc.prevCursor)
  layerSet({ "n", "x" }, "<right>", mc.nextCursor)

  -- Delete the main cursor.
  layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

  -- Enable and clear cursors using escape.
  layerSet("n", "<esc>", function()
    if not mc.cursorsEnabled() then
      mc.enableCursors()
    else
      mc.clearCursors()
    end
  end)
end)
