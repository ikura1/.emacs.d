;==============================
;;; python-mode
;==============================
(autoload 'python-mode "python-mode" "Python editing mode." t)
(add-to-list 'auto-mode-alist '("\\.pyt\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;==============================
;test
;==============================


;==============================
;;; flymake for python
;==============================
(add-hook 'python-mode-hook 'flymake-find-file-hook)
(eval-after-load 'flycheck
  '(custom-set-variables
   '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
(add-hook 'find-file-hook 'flymake-find-file-hook)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (cond ((eq system-type 'gnu/linux)
          ;;;;; Linux上のEmacs固有の設定
            (list "~/.emacs.d/scripts/pycheckers.sh"  (list local-file)))
            ;; Windows 7
            ((eq system-type 'windows-nt)
          ;;;;;; Windows上のEmacs固有の設定
             (list "~/.emacs.d/scripts/pycheckers.bat"  (list local-file)))
      ;; Mac
            ((eq system-type 'darwin)
          ;;;;;; Mac上のEmacs固有の設定
             (list "~/.emacs.d/scripts/pycheckers.sh"  (list local-file))))
      ))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))
(load-library "flymake-cursor")
(global-set-key [f10] 'flymake-goto-prev-error)
(global-set-key [f11] 'flymake-goto-next-error)

;; error avoidance
(defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
  (setq flymake-check-was-interrupted t))
(ad-activate 'flymake-post-syntax-check)

(put 'upcase-region 'disabled nil)

;==============================
;;; pythontidy C-c t
;==============================
(defun pytidy-whole-buffer ()
  (interactive)
  (let ((a (point)))
    (shell-command-on-region (point-min) (point-max) "pythontidy" t)
    (goto-char a)))
(add-hook 'python-mode-hook '(lambda ()
                               (define-key python-mode-map "\C-ct" 'pytidy-whole-buffer)))
;===============================
;;.pyファイルを開いた際に、文字コード指定がなければ文字コード指定文字列を追加
;===============================
(defun my-short-buffer-file-coding-system (&optional default-coding)
  (let ((coding-str (format "%S" buffer-file-coding-system)))
   (cond ((string-match "shift-jis" coding-str) 'shift_jis)
         ((string-match "euc-jp" coding-str) 'euc-jp)
         ((string-match "utf-8" coding-str) 'utf-8)
         (t (or default-coding 'utf-8)))))

(defun my-insert-file-local-coding ()
  "ファイルの先頭に `coding:' を自動挿入する"
  (interactive)
  (save-excursion
    (goto-line 2) (end-of-line) ; ２行目の行末の移動
    (let ((limit (point)))
      (goto-char (point-min))
      (unless (search-forward "coding:" limit t) ; 2行目以内に `coding:'がない
        (goto-char (point-min))
        ;; #!で始まる場合２行目に記述
        (when (and (< (+ 2 (point-min)) (point-max))
                   (string= (buffer-substring (point-min) (+ 2 (point-min))) "#!"))
          (unless (search-forward "\n" nil t) ; `#!'で始まり末尾に改行が無い場合
            (insert "\n")))                   ; 改行を挿入
        (let ((st (point)))
          (insert (format "-*- coding: %S -*-\n" (my-short-buffer-file-coding-system)))
          (comment-region st (point)))))))

(add-hook 'python-mode-hook 'my-insert-file-local-coding)
