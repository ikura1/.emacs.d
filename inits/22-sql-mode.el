;==============================
;;; sql-mode sql-indend
;==============================
(eval-after-load "sql"
  '(load-library "sql-indent"))
; db-name
;(sql-set-product "postgres") ; mysql, postgres, oracle, sqlite...
(setq indent-tabs-mode nil)
; db setting
(setq sql-postgres-login-params
      '((user :default "postgres")
        (database :default "postgres")
        (server :default "localhost")
        (port :default 5432)))
