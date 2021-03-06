;;デフォルトで設定しある部分を発見、消して支障なければさようなら
;;(add-hook 'c-mode-common-hook
;;    (function
;;        (lambda()
;;            (setq truncate-lines t)
;;            (setq tab-width 4))))
;==================================
;; 編集中のファイルを開き直す
;===================================
;; - yes/no の確認が不要;;   - revert-buffer は yes/no の確認がうるさい
;; - 「しまった! 」というときにアンドゥで元のバッファの状態に戻れる
;;   - find-alternate-file は開き直したら元のバッファの状態に戻れない
;;
(defun reopen-file ()
  (interactive)
  (let ((file-name (buffer-file-name))
        (old-supersession-threat
         (symbol-function 'ask-user-about-supersession-threat))
        (point (point)))
    (when file-name
      (fset 'ask-user-about-supersession-threat (lambda (fn)))
      (unwind-protect
          (progn
            (erase-buffer)
            (insert-file file-name)
            (set-visited-file-modtime)
            (goto-char point))
        (fset 'ask-user-about-supersession-threat
              old-supersession-threat)))))
(define-key ctl-x-map "rr"  'reopen-file)
