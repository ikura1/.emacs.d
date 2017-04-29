
;==============================
;;; full path C-c i
;==============================
(defvar mode-line-buffer-fullpath
  (list 'buffer-file-name
        (propertized-buffer-identification "%12f")
        (propertized-buffer-identification "%12b")))

(add-hook 'dired-mode-hook
          (lambda ()
            ;; TODO: handle (DIRECTORY FILE ...) list value for dired-directory
            (setq mode-line-buffer-identification
                  ;; emulate "%17b" (see dired-mode):
                  '(:eval
                    (propertized-buffer-identification
                     (if (< (length default-directory) 17)
                         (concat default-directory
                                 (make-string (- 17 (length default-directory))
                                              ?\s))
                       default-directory))))))

(setq  mode-line-buffer-default mode-line-buffer-identification)

(defun toggle-mode-line-fullpath ()
  (interactive)
  (setq mode-line-buffer-identification
        (if (string= (format "%s" mode-line-buffer-identification)
                     (format "%s" mode-line-buffer-fullpath))
            mode-line-buffer-default
          mode-line-buffer-fullpath))
  ;; (force-mode-line-update)
)
(global-set-key (kbd "C-c i") 'toggle-mode-line-fullpath)

(defun my-copy-buffer-file-name ()
  "copy buffer-file-name to kill-ring."
  (interactive)
  (let ((fn (unwind-protect
                (buffer-file-name)
              nil)))
    (if fn
        (let ((f (abbreviate-file-name (expand-file-name fn))))
          (kill-new f)
          (message "copied: \"%s\"" f))
      (message "no file name"))))
