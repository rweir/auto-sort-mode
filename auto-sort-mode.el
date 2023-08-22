;;; auto-sort-mode.el --- Automatically sort lines between two delimiters -*- lexical-binding: t; -*-
;; Copyright 2023 Rob Weir

;; Author: Rob Weir <rweir@ertius.org>
;; URL: https://github.com/rweir/auto-sort-mode
;; Version: 0.1
;; Keywords: sorting, sort, matching, tools
;; Package-Requires: ((emacs "24.1"))

;;; Commentary:
;; Sort lines between two delimiters.
;; example:
;; <!-- { sort-start } -->
;; A
;; B
;; C
;; <!--{ sort-end } -->
;; /example
;;
;; Note, the delimiters don't have to be the only thing on the line,
;; or at the beginning, so can be probably commented out for the
;; purposes of the language it's embedded in.

;;; Code:

(defun auto-sort-between-delimiters ()
  "Sort the lines between two markers.

Specifically, the bits between '<!-- { sort-start } -->' and
'<!--{ sort-end } -->' (no quotes).  Intended to be compatible with https://marketplace.visualstudio.com/items?itemName=karizma.scoped-sort ."
  (interactive)
  (let (start end)
    (save-excursion
      (goto-char (point-min))
      ;; Search for the starting marker
      (when (search-forward "<!-- { sort-start } -->" nil t)
        (setq start (line-beginning-position 2)) ; line after
        ;; Search for the ending marker
        (when (search-forward "<!--{ sort-end } -->" nil t)
          (setq end (line-beginning-position 0)) ; line before
          ;; Sort the lines between the start and end markers
          (sort-lines nil start end))))))

;;;; Commands

;;;###autoload
(define-minor-mode auto-sort-mode
  "Automatically apply `sort-between-delimiters` to this file on save."
  :lighter " AS"
  (add-hook 'write-contents-functions
      (lambda()
        (save-excursion
          (auto-sort-between-delimiters)))))

;;;; Footer

;;;###autoload
(provide 'auto-sort-mode)
;;; auto-sort-mode.el ends here
