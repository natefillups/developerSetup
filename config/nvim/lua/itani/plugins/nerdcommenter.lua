return {
    {
        'scrooloose/nerdcommenter',
        config = function()
            -- NERD settings
            vim.g["NERDSpaceDelims"] = 1
            vim.g["NERDDefaultAlign"] = 'left'
            vim.g["NERDCommentEmptyLines"] = 1
            vim.g["NERDTrimTrailingWhitespace"] = 1
            vim.g["NERDToggleCheckAllLines"] = 1
        end,
    }
}

