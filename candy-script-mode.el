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

;; ("^\\(#+\\)\\(.*\\)$" . ((1 font-lock-function-name-face)  (2 font-lock-constant-face)))

(defface font-lock-type-face-no-bold
  '((t :inherit font-lock-type-face :weight normal))
  "Non-bolded version of font-lock-type-face"
  :group 'font-lock-faces)

(setq myKeywords
      '(
        ;;   ("\".*" . font-lock-string-face)
        ;; ("^# .*$" . info-title-1)
        ;; ("^## .*$" . info-title-2)
        ;; ("^### .*$" . info-title-3)
        ;; ("^#### .*$" . info-title-4)
        ("^.*--\\(.*\\)$" . font-lock-comment-face)
        ;;   ("^#\\{2\\} .*$" . info-title-2)
        ("^#.*$" . font-lock-variable-name-face)
        ("def\\|if\\|else\\|series\\|then\\|parallel\\|->\\|include\\|require\\|λ" . font-lock-keyword-face)
        ("\t" . whitespace-tab)
        )
      )



(defun candy-script-mode-highlight-comments(&optional begReg endReg length) ; args for after-change-functions
  (interactive)
  (candy-script-mode-highlight-comments-remove)
  (setq points nil)
  (save-excursion
    (goto-char (point-min))
    (while
        (search-forward-regexp "\n\n\n" nil t)
      (setq points (cons (point) points))))
  (setq isBeg t)
  (if (= (% (length points) 2) 1)
      (setq points (cons (point-max) points)))
  (setq points (reverse points))
  (while (car points)
    (setq pos (car points))
    (setq points (cdr points))
    (if isBeg
        (setq beg pos)
      (setq end pos))
    (when (not isBeg)
      (candy-script-mode-highlight-comments-region beg end))
    (setq isBeg (not isBeg))))

(defun candy-script-mode-highlight-comments-region(beg end)
  (setq new-overlay (make-overlay beg end))
  (message "%S" new-overlay)
  (overlay-put new-overlay 'face 'font-lock-comment-face)
  (overlay-put new-overlay 'category "candy-script-mode-comment"))


(defun candy-script-mode-highlight-comments-remove()
  (let ((overlays (overlays-in (point-min) (point-max)))
	(overlay))
    (while (car overlays)
      (setq overlay (pop overlays))
      (if (member "candy-script-mode-comment" (overlay-properties overlay))
	  (delete-overlay overlay)))))

(define-derived-mode candy-script-mode fundamental-mode
  (setq font-lock-defaults '(myKeywords))
  (setq mode-name "Candy-Script")
  (set (make-local-variable 'indent-tabs-mode) nil)
  (make-local-variable 'font-lock-extend-region-functions)
  (candy-script-mode-highlight-comments)
  (make-local-variable 'after-change-functions)
  (add-hook 'after-change-functions 'candy-script-mode-highlight-comments))


(provide 'candy-script-mode)
;;; candy-mode.el ends here
