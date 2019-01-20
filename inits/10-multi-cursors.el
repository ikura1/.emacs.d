(use-package multiple-cursors)
(use-package smartrep)
(declare-function smartrep-define-key "smartrep")
(global-set-key (kbd "C-M-c") 'mc/edit-lines)
(global-set-key (kbd "C-*")   'mc/mark-all-like-this)
(global-unset-key "\C-t")
(smartrep-define-key global-map "C-t"
  '(("C-p"      . 'mc/mark-previous-like-this)
    ("C-n"      . 'mc/mark-next-like-this)
    ("u" . mc/unmark-next-like-this)
    ("U" . mc/unmark-previous-like-this)
    ("s" . mc/skip-to-next-like-this)
    ("S" . mc/skip-to-previous-like-this)
    ("*"        . 'mc/mark-all-like-this)))
