;;; candy-script-mode.el --- Major Mode for Candy Script

;; Copyright (C) 2013  Zeno Zeng

;; Author: Zeno Zeng <zenoofzeng@gmail.com>
;; Keywords: CandyScript

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Ref -- http://ergoemacs.org/emacs/elisp_syntax_coloring.html

;;; Code:


(setq myKeywords
 '(("Sin\\|Cos\\|Sum" . font-lock-function-name-face)
   ("Pi\\|Infinity" . font-lock-constant-face)
   ("def\\|if\\|else\\|series\\|then\\|parallel\\|->" . font-lock-keyword-face)
   ("^\t\t" . whitespace-indentation)
   ("^\t" . whitespace-tab)
  )
)

(define-derived-mode candy-script-mode fundamental-mode
  (setq font-lock-defaults '(myKeywords))
  (setq mode-name "Candy-Script")
  (set (make-local-variable 'indent-tabs-mode) t)
  (set (make-local-variable 'tab-width) 8)
)


(provide 'candy-script-mode)
;;; candy-mode.el ends here
