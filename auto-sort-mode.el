;;; auto-sort-mode --- Summary
;;; Commentary:
;; Sort lines between two delimiters.

;;; Code:
(defun sort-between-delimiters ()
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

(define-minor-mode auto-sort-mode
  "Automatically apply `sort-between-delimiters` to this file on save."
  :lighter " AS"
  (add-hook 'write-contents-functions
      (lambda()
        (save-excursion
          (sort-between-delimiters)))))

(provide 'auto-sort--mode)
;;; auto-sort-mode.el ends here
