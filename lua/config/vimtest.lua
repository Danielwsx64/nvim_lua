local Self = {}

function Self.setup()
	vim.g["test#strategy"] = "vtr"
end

function Self.change()
	if vim.g["test#strategy"] == "vtr" then
		vim.g["test#strategy"] = "toggleterm"
	else
		vim.g["test#strategy"] = "vtr"
	end
end

return Self
