;; straight.el自身のインストールと初期設定を行ってくれる
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" "~/.emacs.d/"))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; use-packageをインストールする
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(setq package-aarchives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(setq search_default-regexp-mode nil); 251
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(global-font-lock-mode 1)

;; init-loader
(use-package init-loader)
(init-loader-load "~/.emacs.d/inits")
