;;migemo
(use-package migemo)
(setq search-default-regexp-mode nil) ;; emacs251
;; Gnu Linux
(cond ((eq system-type 'gnu/linux)
   ;;;;; Linux上のEmacs固有の設定
       (progn (setq migemo-command "cmigemo")
              (setq migemo-dictionary (expand-file-name "/usr/share/cmigemo/utf-8/migemo-dict")))
       )
      ;; Windows 7
      ((eq system-type 'windows-nt)
  ;;;;;; Windows上のEmacs固有の設定
       (progn (setq migemo-command "~/.emacs.d/elpa/migemo/cmigemo.exe")
              (setq migemo-dictionary (expand-file-name "~/.emacs.d/elpa/migemo/dict/migemo-dict")))
       )
      ;; Mac
      ((eq system-type 'darwin)
  ;;;;;; Mac上のEmacs固有の設定
       (progn (setq migemo-command "/usr/local/bin/cmigemo")
              (setq migemo-dictionary (expand-file-name "/usr/local/share/migemo/utf-8/migemo-dict")))
       )
      )

(setq migemo-options '("-q" "--emacs"))
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-use-pattern-alist t)
(setq migemo-use-frequent-pattern-alist t)
(setq migemo-pattern-alist-length 1000)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)
