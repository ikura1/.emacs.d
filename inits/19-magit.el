;;magit.el
(use-package magit)
(use-package magit-popup)
;;(setq magit-last-seen-setup-instructions "1.4.0")
(global-set-key (kbd "C-x g") 'magit-status)

;; windows用
(if (eq system-type 'windows-nt)
   (progn
(setq magit-git-executable "C:/Program Files/Git/bin/git.exe")
(add-to-list 'exec-path "C:/Program Files/Git/bin")
))

;; 文字色変更
(set-face-foreground 'magit-diff-added "#00FF00") ; 追加行
(set-face-foreground 'magit-diff-removed "#FF0000") ; 削除行
(set-face-foreground 'magit-diff-file-heading "#00FFFF") ; Diffのファイル名部分
(set-face-foreground 'magit-diff-hunk-heading "#00AADD") ; Diffのhunk部分
(set-face-foreground 'magit-section-heading "#FF00FF") ; 見出し部分

;; 背景色変更
(set-face-background 'magit-section-highlight "#282822") ; 選択行
(set-face-background 'magit-diff-added "#282822") ; 追加行
(set-face-background 'magit-diff-removed "#282822") ; 削除行
(set-face-background 'magit-diff-file-heading "#282822") ; Diffのファイル名部分
(set-face-background 'magit-diff-hunk-heading "#282822") ; Diffのhunk部分
(set-face-background 'magit-section-heading "#282822") ; 見出し部分
