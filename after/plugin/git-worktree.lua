SafeRequire("git-worktree", function(m)
	-- Creates a worktree.  Requires the path, branch name, and the upstream
	-- Example:
	-- m.create_worktree("feat-69", "master", "origin")

	-- switches to an existing worktree.  Requires the path name
	-- Example:
	-- m.switch_worktree("feat-69")

	-- deletes to an existing worktree.  Requires the path name
	-- Example:
	-- m.delete_worktree("feat-69")
end)
