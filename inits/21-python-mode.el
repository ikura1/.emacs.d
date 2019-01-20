;==============================
;;; python-mode
;==============================
(use-package python-mode)

(autoload 'python-mode "python-mode" "Python editing mode." t)
(add-to-list 'auto-mode-alist '("\\.pyt\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python3" . python-mode))

;==============================
;;; python formatter C-c t
;==============================
