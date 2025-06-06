--
-- ██╗  ██╗███████╗██╗   ██╗███╗   ███╗ █████╗ ██████╗ ███████╗
-- ██║ ██╔╝██╔════╝╚██╗ ██╔╝████╗ ████║██╔══██╗██╔══██╗██╔════╝
-- █████╔╝ █████╗   ╚████╔╝ ██╔████╔██║███████║██████╔╝███████╗
-- ██╔═██╗ ██╔══╝    ╚██╔╝  ██║╚██╔╝██║██╔══██║██╔═══╝ ╚════██║
-- ██║  ██╗███████╗   ██║   ██║ ╚═╝ ██║██║  ██║██║     ███████║
-- ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝
--

local map = vim.keymap.set

-- default keymaps override
map("n", "n", "nzz", { desc = "next search result" })
map("n", "N", "Nzz", { desc = "previous search result" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "quit" })
vim.api.nvim_del_keymap("n", "<leader>qq")

-- Insert movement
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up", remap = true })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })

-- lazyvim picker override
map("n", "<leader>ff", LazyVim.pick("files", { root = false }), { desc = "Find Files (cwd)" })
map("n", "<leader>fF", LazyVim.pick("files"), { desc = "Find Files (Root Dir)" })
map("n", "<leader>sg", LazyVim.pick("live_grep", { root = false }), { desc = "Grep (cwd)" })
map("n", "<leader>sG", LazyVim.pick("live_grep"), { desc = "Grep (Root Dir)" })
map({ "n", "x" }, "<leader>sw", LazyVim.pick("grep_word"), { desc = "Visual selection or word (cwd)" })
map({ "n", "x" }, "<leader>sW", LazyVim.pick("grep_word"), { desc = "Visual selection or word (Root Dir)" })

-- floating terminal
-- stylua: ignore
map({"n","t"}, "<C-'>", "<cmd>ToggleTerm direction=float<Cr>", { desc = "toggle floating terminal" })
-- stylua: ignore
map("n", "<c-/>", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
map("t", "<c-x>", "<c-\\><c-n>", {})

-- tab management
map("n", "<leader>to", "<cmd>tabnew<Cr>", { desc = "open new tab" }) -- open new tab
map("n", "<leader>tx", "<cmd>tabclose<Cr>", { desc = "close current tab" }) -- close current tab
map("n", "<leader>tn", "<cmd>tabn<Cr>", { desc = "go to next tab" }) --  go to next tab
map("n", "<leader>tp", "<cmd>tabp<Cr>", { desc = "go to previous tab" }) --  go to previous tab

-- diagnostics
map("n", "xn", "]d", { desc = "Next Diagnostic", remap = true })
map("n", "xp", "[d", { desc = "Prev Diagnostic", remap = true })

-- Commenting
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- yank to the system clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "yank to the system clipboard" })
map("n", "<leader>Y", '"+y$', { desc = "yank eol to the system clipboard" })
map("n", "<C-c>", "<cmd>%y+<cr>", { desc = "yank eol to the system clipboard" })

-- vim-visual-multi
vim.g.VM_maps = {
  ["Remove Region"] = "<C-p>",
  ["Select Cursor Up"] = "<C-k>",
  ["Select Cursor Down"] = "<C-j>",
}
vim.g.VM_theme = "paper"

-- snappify.com
map("n", "<leader>ci", function()
  local function url_encode(str)
    if not str then
      return ""
    end

    return str:gsub("([^%w%.%- ])", function(c)
      return string.format("%%%02X", string.byte(c))
    end)
  end

  local function get_file_name()
    return vim.fn.expand("%:t") -- Get just the filename
  end

  local function get_file_language()
    return vim.bo.filetype -- Get the file type (language)
  end

  local function get_file_text()
    local buf = vim.api.nvim_get_current_buf() -- Get the current buffer
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false) -- Get all lines from the buffer
    return table.concat(lines, "\n") -- Join the lines with newline characters
  end

  local file_name = get_file_name()
  local file_language = get_file_language()
  local current_file_text = get_file_text()

  -- Construct the URL
  local url = "https://snappify.com/new?p=1"
    .. "&f="
    .. url_encode(file_name)
    .. "&l="
    .. url_encode(file_language)
    .. "&c="
    .. url_encode(current_file_text)

  -- Open the URL in the default browser
  vim.fn.system('xdg-open "' .. url .. '" &')
end, { desc = "open current file in snappify" })
