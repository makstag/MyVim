--[[local async_formatting = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    vim.lsp.buf_request(
        bufnr,
        "textDocument/formatting",
        vim.lsp.util.make_formatting_params({}),
        function(err, res, ctx)
            if err then
                local err_msg = type(err) == "string" and err or err.message
                -- you can modify the log message / level (or ignore it completely)
                vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
                return
            end

            -- don't apply results if buffer is unloaded or has been modified
            if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
                return
            end

            if res then
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
                vim.api.nvim_buf_call(bufnr, function()
                    vim.cmd("silent noautocmd update")
                end)
            end
        end
    )
end

local null_ls = require("null-ls")

null_ls.setup({
    -- add your sources / config options here
    sources = {
	-- null_ls.builtins.completion.luasnip,
	-- null_ls.builtins.diagnostics.cppcheck,
	null_ls.builtins.formatting.autopep8,
	null_ls.builtins.formatting.stylua.with({
            extra_args = { "--config-path", vim.fn.expand("~/.config/stylua.toml") },
        }),
         null_ls.builtins.formatting.prettier.with({
            filetypes = { "html", "json", "yaml", "markdown", "cpp", "python" },
        }),
        null_ls.builtins.formatting.shfmt.with({
            extra_args = { "-i", "2", "-ci" },
        }),
	null_ls.builtins.diagnostics.write_good.with({
            diagnostics_postprocess = function(diagnostic)
                diagnostic.severity = diagnostic.message:find("really") and vim.diagnostic.severity["ERROR"]
                    or vim.diagnostic.severity["WARN"]
            end,
        }),
	null_ls.builtins.diagnostics.shellcheck.with({
            diagnostic_config = {
                -- see :help vim.diagnostic.config()
                underline = true,
                virtual_text = false,
                signs = true,
                update_in_insert = false,
                severity_sort = true,
            },
        }),
    },
    debug = false,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePost", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    async_formatting(bufnr)
                end,
            })
        end
    end,
})]]
local null_ls = require "null-ls"
null_ls.setup {
	sources = {
		null_ls.builtins.formatting.autopep8,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.stylua,
	},
}