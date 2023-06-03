SafeRequire("filetype", function(ft)
	ft.setup({
		overrides = {
			-- extensions = {
			-- 	-- Set the filetype of *.pn files to potion
			-- 	-- pn = "potion",
			-- },
			-- literal = {
			-- 	-- Set the filetype of files named "MyBackupFile" to lua
			-- 	MyBackupFile = "lua",
			-- },
			complex = {
				-- Set the filetype of any full filename matching the regex to gitconfig
				[".*git/config"] = "gitconfig", -- Included in the plugin
				[".env.*"] = "sh",
				["tsconfig*.json"] = "jsonc",
				["Dockerfile.*"] = "dockerfile",
			},
		},
	})
end)
