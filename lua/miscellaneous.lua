local search = vim.fn.search
local setreg = vim.fn.setreg
local expand = vim.fn.expand
local substitute = vim.fn.substitute

local cmd = vim.cmd

local nvim_buf_get_lines = vim.api.nvim_buf_get_lines
local nvim_buf_get_text = vim.api.nvim_buf_get_text
local nvim_buf_get_mark = vim.api.nvim_buf_get_mark
local nvim_get_mode = vim.api.nvim_get_mode

local Self = {}
local custom = {}

local function is_visual_mode()
	-- [t'<C-v>'] = true, -- Visual block does not seem to be supported by vim.region
	local mode = nvim_get_mode().mode

	return mode == "v" or mode == "V"
end

function custom.get_marked_region(mark1, mark2, options)
	local bufnr = 0
	local adjust = options.adjust or function(pos1, pos2)
		return pos1, pos2
	end
	local regtype = options.regtype or vim.fn.visualmode()
	local selection = options.selection or (vim.o.selection ~= "exclusive")

	local pos1 = vim.fn.getpos(mark1)
	local pos2 = vim.fn.getpos(mark2)
	pos1, pos2 = adjust(pos1, pos2)

	local start = { pos1[2] - 1, pos1[3] - 1 + pos1[4] }
	local finish = { pos2[2] - 1, pos2[3] - 1 + pos2[4] }

	-- Return if start or finish are invalid
	if start[2] < 0 or finish[1] < start[1] then
		return
	end

	local region = vim.region(bufnr, start, finish, regtype, selection)
	return region, start, finish
end

function custom.get_visual_selection()
	local bufnr = 0

	-- Return if not in visual mode
	-- I removed this if because its already validated in the interface function
	-- if is_visual_mode() then
	-- 	return
	-- end

	local options = {}
	options.adjust = function(pos1, pos2)
		if vim.fn.visualmode() == "V" then
			pos1[3] = 1
			pos2[3] = 2 ^ 31 - 1
		end

		if pos1[2] > pos2[2] then
			pos2[3], pos1[3] = pos1[3], pos2[3]
			return pos2, pos1
		elseif pos1[2] == pos2[2] and pos1[3] > pos2[3] then
			return pos2, pos1
		else
			return pos1, pos2
		end
	end

	local region, start, finish = custom.get_marked_region("v", ".", options)

	-- Compute the number of chars to get from the first line,
	-- because vim.region returns -1 as the ending col if the
	-- end of the line is included in the selection
	local lines = vim.api.nvim_buf_get_lines(bufnr, start[1], finish[1] + 1, false)
	local line1_end
	if region[start[1]][2] - region[start[1]][1] < 0 then
		line1_end = #lines[1] - region[start[1]][1]
	else
		line1_end = region[start[1]][2] - region[start[1]][1]
	end

	lines[1] = vim.fn.strpart(lines[1], region[start[1]][1], line1_end, true)
	if start[1] ~= finish[1] then
		lines[#lines] = vim.fn.strpart(lines[#lines], region[finish[1]][1], region[finish[1]][2] - region[finish[1]][1])
	end
	return table.concat(lines, "\\n")
end

-- local function get_selected_text()
-- 	local start = nvim_buf_get_mark(0, "<")
-- 	local eend = nvim_buf_get_mark(0, ">")
--
-- 	local content = nvim_buf_get_text(0, start[1] - 1, start[2], eend[1] - 1, eend[2] + 1, {})
-- 	return table.concat(content, "\n")
-- end

local function path_without_extension(mod_line)
	local result = mod_line
		:gsub("defmodule", "")
		:gsub(" do", "")
		:gsub(" ", "")
		:gsub("(%u)(%w*)", function(a, b)
			return string.lower(a) .. b
		end)
		:gsub("(%u)", function(a)
			return "_" .. string.lower(a)
		end)
		:gsub("%.", "/")

	return result
end

local function is_a_test_file(file_path)
	local suffix = "test"

	return string.sub(file_path, -string.len(suffix)) == suffix
end

local function remove_namespace(path)
	local result = path:gsub("^[%w_]+/", "")
	return result
end

local function ripgrep(file_path)
	return io.popen("rg --files | rg  " .. file_path):read("l")
end

function Self.go_to_elixir_test_file()
	local line = search("^.*defmodule", "bcn")

	if line == 0 then
		print("Current file is not a module file")
		return
	end

	local line_content = nvim_buf_get_lines(0, line - 1, -1, false)

	local path = path_without_extension(line_content[1])

	if is_a_test_file(path) then
		print("Current file is a test file")
		return
	end

	local expected_test_path = path .. "_test.exs"
	local attempts = 0

	repeat
		if attempts > 0 then
			expected_test_path = remove_namespace(expected_test_path)
		end

		local test_file = ripgrep(expected_test_path)

		if test_file then
			cmd("edit " .. test_file)
			return
		end

		attempts = attempts + 1
	until expected_test_path:find("/") == nil

	print("Could not find a test file: " .. expected_test_path)
end

function Self.better_search()
	if is_visual_mode() then
		setreg("/", custom.get_visual_selection())
	else
		setreg("/", string.format("\\<%s\\>", expand("<cword>")))
	end

	cmd("set hls")
end

function Self.better_replace() end

return Self
