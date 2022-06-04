local Self = {}

function Self.elixir_module_name()
	local file = vim.fn.expand("%")

	if file and file ~= "" then
		local cut_at = string.find(file, "/lib/")
			or string.find(file, "test/")
			or string.find(file, "[%a_-]+.?e?x?s?$") - 5

		local mod_name = file
			:sub(cut_at + 5)
			:gsub(".ex$", "")
			:gsub(".exs$", "")
			:gsub("/", ".")
			:gsub("(%l)(%w*)", function(a, b)
				return string.upper(a) .. b
			end)
			:gsub("_", "")

		return mod_name
	end

	return "Module"
end

return Self
