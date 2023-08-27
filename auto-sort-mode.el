;;; auto-sort-mode.el --- Automatically sort lines between two delimiters -*- lexical-binding: t; -*-
;; Copyright 2023 Rob Weir
;; SPDX-License-Identifier: MIT

;; Author: Rob Weir <rweir@ertius.org>
;; URL: https://github.com/rweir/auto-sort-mode
;; Version: 0.1
;; Keywords: sorting, sort, matching, tools
;; Package-Requires: ((emacs "24.1"))

;;; Commentary:
;; Sort lines between two delimiters.
;; example:
;; <!-- { auto-sort-mode.el start } -->
;; A
;; B
;; C
;; <!-- { auto-sort-mode.el end } -->
;; /example
;;
;; Note, the delimiters don't have to be the only thing on the line,
;; or at the beginning, so can be probably commented out for the
;; purposes of the language it's embedded in.

;;; Code:

(defgroup auto-sort nil "Automatically sort lines between two delimiters."
  :group 'text
  :prefix "auto-sort-mode-")

(defcustom auto-sort-mode-start-delimiter (concat "<!-- { auto-sort-mode.el start } " "-->")
  "Start delimiter for `auto-sort-mode`."
  :type '(string))

(defcustom auto-sort-mode-end-delimiter (concat "<!-- { auto-sort-mode.el end } " "-->")
  "End delimiter for `auto-sort-mode`."
  :type '(string))

;;;###autoload
(defun auto-sort-between-delimiters ()
  "Sort the lines between two markers.

Specifically, the bits between '<!-- { auto-sort-mode.el start } -->' and
'<!-- { auto-sort-mode.el end } -->' (no quotes).  Inspired by <https://marketplace.visualstudio.com/items?itemName=karizma.scoped-sort>."
  (interactive)
  (let (start end)
    (save-excursion
      (goto-char (point-min))
      ;; Search for the starting marker
      (when (search-forward auto-sort-mode-start-delimiter nil t)
        (setq start (line-beginning-position 2)) ; line after
        ;; Search for the ending marker
        (when (search-forward auto-sort-mode-end-delimiter nil t)
          (setq end (line-beginning-position)) ; this line
          ;; Sort the lines between the start and end markers
          (sort-lines nil start end))))))

;;;; Commands

;;;###autoload
(define-minor-mode auto-sort-mode
  "Automatically apply `sort-between-delimiters` to this file on save."
  :lighter " AS"
  (if (eq auto-sort-mode t)
      (add-hook 'write-contents-functions
                #'auto-sort-between-delimiters)
    (remove-hook 'write-contents-functions
                 #'auto-sort-between-delimiters)))

;;;; Footer

;;;###autoload
(provide 'auto-sort-mode)
;;; auto-sort-mode.el ends here
