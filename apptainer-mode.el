;;; apptainer-mode.el ---   -*- lexical-binding: t; no-compile: t -*-

;; Author: Angel Mancebo
;; Maintainer: Angel Mancebo
;; Version: version
;; Package-Requires:
;; Homepage:
;; Keywords:


;; This file is not part of GNU Emacs

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.


;;; Commentary:

;; commentary

;;; Code:

(defconst apptainer-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?# "<" st)
    (modify-syntax-entry ?\n ">" st)
    (modify-syntax-entry ?% "'" st)
    (modify-syntax-entry ?: "w" st)
    st))

;; TODO: Document these variables
(defvar apptainer-font-lock-preamble nil "")
(defvar apptainer-font-lock-sections nil "")
(defvar apptainer-font-lock-keywords nil "")

(setq apptainer-font-lock-preamble
  '("Bootstrap"
    "From"
    "Stage"
    "Fingerprints"
    "OSVersion"
    "MirrorURL"
    "Include"))

(setq apptainer-font-lock-sections
  '("arguments"
    "setup"
    "files"
    "environment"
    "post"
    "runscript"
    "startscript"
    "test"
    "labels"
    "help"))

(setq apptainer-font-lock-keywords
      `((,(concat "\\_<" (regexp-opt apptainer-font-lock-preamble) "\\_>:")
         (0 font-lock-keyword-face t))
        (,(concat "\\_<%" (regexp-opt apptainer-font-lock-sections) "\\_>")
         (0 font-lock-variable-name-face t))
        ("#.*" (0 font-lock-comment-face t))))

;;;###autoload
(define-derived-mode apptainer-mode prog-mode "Apptainer"
  ""
  (set (make-local-variable 'comment-start) "# ")
  (set (make-local-variable 'comment-end) "")
  (set (make-local-variable 'comment-start-skip) "\\(^\\|[[:space:]]*\\)#")
  (set (make-local-variable 'font-lock-defaults) '(apptainer-font-lock-keywords))
  (set (make-local-variable 'indent-width) 4)
  (set (make-local-variable 'tab-width) 4))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.def?\\'" . apptainer-mode))

(provide 'apptainer-mode)
