(autoload 'markdown-mode "markdown-mode"
"Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.txt\\'". markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'". markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'". markdown-mode))

(setq markdown-command "perl ~/.emacs.d/scripts/Markdown.pl")
