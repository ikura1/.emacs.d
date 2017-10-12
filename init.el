(cond ((eq system-type 'gnu/linux)
   ;;;;; Linux上のEmacs固有の設定
       (require 'cask "~/.cask/cask.el"))
      ;; Windows 7
      ((eq system-type 'windows-nt)
  ;;;;;; Windows上のEmacs固有の設定
       (require 'cask "~/.cask/cask.el"))
      ;; Mac
      ((eq system-type 'darwin)
  ;;;;;; Mac上のEmacs固有の設定
       (require 'cask))
      )
(cask-initialize)


(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)


(setq search_default-regexp-mode nil); 251
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(global-font-lock-mode 1)

;;; ディレクトリをサブディレクトリごとload-pathに追加
;(add-to-load-path "elisp")

;el-getにするか悩み中
;(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;(unless (require 'el-get nil 'noerror)
;  (with-current-buffer
;      (url-retrieve-synchronously
;       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;    (let (el-get-master-branch)
;      (goto-char (point-max))
;      (eval-print-last-sexp))))
;(el-get 'sync)
(require 'pallet)

;; init-loader
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-replace-to-string-separator " => ")
 '(anzu-search-threshold 1000)
 '(anzu-use-migemo t)
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(package-selected-packages
   (quote
    (php-mode ddskk python-mode sql-indent helm pylint python-pep8 python-pylint flycheck-pos-tip flymake flymake-easy flymake-python-pyflakes magit cask dash epl f flycheck magit-popup package-build pkg-info s shut-up async git-commit smartrep flymake-cursor with-editor isearch+ prodigy popwin pallet nyan-mode multiple-cursors migemo init-loader idle-highlight-mode htmlize highlight-symbol flycheck-pyflakes flycheck-cask expand-region exec-path-from-shell drag-stuff bind-key auto-highlight-symbol anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
