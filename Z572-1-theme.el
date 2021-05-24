;; Z572-1-theme.el --- Z572's emacs theme -*- lexical-binding: t; -*-

;;; Copyright © 2021 Zheng Junjie <873216071@qq.com>

;; Author: Zheng Junjie <873216071@qq.com>
;; Maintainer: Zheng Junjie <873216071@qq.com>
;; URL: https://github.com/Z572/Z572-1-theme.el
;; Keywords: faces, theme
;; Version: 0.0

;; This file is not part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

(deftheme Z572-1
  "Z572-1 theme")

(defcustom Z572-1-white "#fff"
  ""
  :group 'Z572-1
  :type 'color)
(defcustom Z572-1-envrc
  '(envrc--status (:eval
                   (if (equal envrc--status 'on)
                       (propertize " env" 'face 'envrc-mode-line-on-face))))
  ""
  :group 'Z572-1
  :type 'list)
(put 'Z572-1-envrc 'risky-local-variable t)

(defcustom Z572-1-modeline-left
  '((winum-mode (" " (:eval (winum-get-number-string)) " "))
    (:propertize "%n" face Z572-1-mode-name)
    (:propertize mode-name face Z572-1-mode-name)
    ":" mode-line-percent-position " (%l %c)"
    Z572-1-envrc
    mode-line-front-space current-input-method-title "%Z" mode-line-client
    ("%1*" "%1+")
    mode-line-remote
    mode-line-frame-identification
    (eldoc-mode-line-string eldoc-mode-line-string))
  ""
  :group 'Z572-1
  :type 'list)
(put 'Z572-1-modeline-left 'risky-local-variable t)

(defcustom Z572-1-modeline-center
  '(buffer-file-name "%f" "%b")
  ""
  :group 'Z572-1
  :type 'list)
(put 'Z572-1-modeline-center 'risky-local-variable t)

(defcustom Z572-1-modeline-right
  '("%M" mode-line-end-spaces ((vc-mode vc-mode) " ")
    mode-line-process)
  ""
  :group 'Z572-1
  :type 'list)
(put 'Z572-1-modeline-right 'risky-local-variable t)

(defface Z572-1-mode-name
  '((((class color) (background dark))
     :overline t
     :foreground "#f66"
     :weight bold)
    (((class color) (background light))
     :overline t
     :foreground "#f22"
     :weight bold))
  ""
  :group 'Z572-1)

(defface Z572-1-mode-line-over
  '((((class color) (background dark))
     :overline nil
     :foreground "#222"
     :inherit (mode-line))
    (((class color) (background light))
     :overline nil
     :foreground "#fff"
     :inherit (mode-line)))
  ""
  :group 'Z572-1)

(defun Z572-1-eldoc-message (format-string &rest args)
  (run-with-timer 2 nil (lambda () (setq eldoc-mode-line-string nil)))
  (if (minibufferp)
      (let ((minibuffer-message-timeout nil))
        (when (stringp format-string)
          (minibuffer-message
           "%s" (apply #'format-message format-string args))))
    (setq eldoc-mode-line-string
          (when (stringp format-string)
            (apply #'format-message format-string args)))))

(custom-theme-set-variables
 'Z572-1
 '(window-divider-default-right-width 1)
 '(window-divider-default-bottom-width 1)
 '(ansi-color-names-vector
   ["#222" "#f44" "green3" "DarkGoldenrod2"
    "RoyalBlue" "MediumOrchid" "SkyBlue2" "#eee"])
 '(mode-line-percent-position '(-7 "%q"))
 '(mode-line-default-help-echo nil)
 '(mode-line-format
   '((:propertize " " display ((when (<= (/ (display-pixel-width) 1.5)
                                         (window-pixel-width))
                                 space :align-to left))
                  face (:overline nil))
     "%e"
     Z572-1-modeline-left
     (:eval
      (let ((a (format-mode-line
                Z572-1-modeline-center 'mode-line-buffer-id)))
        (concat
         (propertize " " 'display `((space
                                     :align-to
                                     (- center ,(/ (string-width a) 2.0)))))
         (propertize a 'face '(mode-line-buffer-id
                               (:overline t))))))
     (:eval (let ((a (format-mode-line Z572-1-modeline-right)))
              (concat (propertize
                       " " 'display
                       `((space
                          :align-to (- right ,(string-width a)))))
                      a)))
     " "
     (:eval (when (<= (/ (display-pixel-width) 1.5) (window-pixel-width))
              '(:propertize "%-" face Z572-1-mode-line-over)))
     ))
 '(eldoc-message-function #'Z572-1-eldoc-message))

(apply #'custom-theme-set-faces
       `(Z572-1
         (default ((((class color) (background dark))
                    :background "#222"
                    :foreground ,Z572-1-white)
                   (((class color) (background light))
                    :background ,Z572-1-white
                    :foreground "#222")))
         (minibuffer-prompt
          ((((background dark)) :foreground "cyan")
           ;; Don't use blue because many users of the MS-DOS port customize
           ;; their foreground color to be blue.
           (((type pc)) :foreground "magenta")
           (t :foreground "medium blue")))

         (avy-lead-face
          ((t (:foreground "white" :background "#e52b50"))))
         (cfw:face-day-title ((((class color) (background dark))
                               :background "#444")
                              (((class color) (background light))
                               :background "#ccc")))
         (cfw:face-grid ((((class color) (background dark))
                          :foreground "#222"
                          :background "#222")
                         (((background light))
                          :foreground ,Z572-1-white
                          :background ,Z572-1-white)))
         (cfw:face-title ((((class color) (background dark))
                           :foreground "darkgoldenrod3"
                           :weight bold
                           :height 2.0
                           :inherit variable-pitch)
                          (((class color) (background light))
                           :foreground "DarkGrey"
                           :weight bold
                           :height 2.0
                           :inherit variable-pitch)
                          (t :height 1.5 :weight bold :inherit variable-pitch)))
         (cfw:face-today-title ((t :background "#f66")))
         (cfw:face-header ((t :inherit mode-line-buffer-id)))
         (cfw:face-holiday ((t :foreground ,Z572-1-white
                               :inherit (cfw:face-day-title))))
         (cfw:face-select ((t :background "#999")))
         (cfw:face-sunday ((t :foreground ,Z572-1-white
                              :inherit (cfw:face-day-title))))
         (cfw:face-toolbar-button-off ((t :foreground ,Z572-1-white)))
         (company-scrollbar-bg ((((class color) (background dark))
                                 :background "#444")))
         (company-scrollbar-fg ((((class color) (background dark))
                                 :background "#555")))
         (dired-ignored ((t :strike-through t ;; :inherit shadow
                            :inherit font-lock-comment-face)))
         (dired-directory ((t :weight bold
                              :inherit font-lock-function-name-face)))
         (company-tooltip ((((class color) (background dark))
                            :inherit default
                            :background "#333"
                            :foreground "#666")))
         (company-tooltip-annotation ((((min-colors 8))
                                       :inherit (font-lock-string-face))
                                      (t :foreground "#aee")))
         (company-tooltip-command ((((class color) (background dark))
                                    :foreground "#ff3300")))
         (company-tooltip-selection ((t :inherit default)))
         (ctrlf-highlight-line ((t :underline "red" :extend t)))
         (cursor ((((background light))
                   :background "#000"
                   :foreground "#222222")
                  (((class color) (background dark))
                   :background "#fff")))
         (secondary-selection
          ((((class color) (min-colors 88) (background light))
            :background "yellow1" :extend t)
           (((class color) (min-colors 88) (background dark))
            :background "SkyBlue4" :extend t)
           (((class color) (min-colors 16) (background light))
            :background "yellow" :extend t)
           (((class color) (min-colors 16) (background dark))
            :background "SkyBlue4" :extend t)
           (((class color) (min-colors 8))
            :background "cyan" :foreground "black" :extend t)
           (t :inverse-video t)))
         (avy-lead-face-0
          ((t :foreground "white" :background "#4f57f9")))
         (avy-lead-face-1
          ((t :foreground "white" :background "gray")))
         (avy-lead-face-2
          ((t :foreground "white" :background "#f86bf3")))
         (avy-lead-face
          ((t :foreground "white" :background "#e52b50")))
         (avy-background-face
          ((t :foreground "gray40")))
         (avy-goto-char-timer-face
          ((t :inherit highlight)))
         (eldoc-highlight-function-argument
          ((t :inherit bold
              :foreground "#f20")) )
         (font-lock-constant-face
          ((((class grayscale) (background light))
            :foreground "LightGray" :weight bold :underline t)
           (((class grayscale) (background dark))
            :foreground "Gray50" :weight bold :underline t)
           (((class color) (min-colors 88) (background light))
            :foreground "dark cyan")
           (((class color) (min-colors 88) (background dark))
            :foreground "Aquamarine")
           (((class color) (min-colors 16) (background light))
            :foreground "CadetBlue")
           (((class color) (min-colors 16) (background dark))
            :foreground "Aquamarine")
           (((class color) (min-colors 8)) :foreground "magenta")
           (t :weight bold :underline t)))
         (flycheck-error ((((class color) (background dark))
                           :background "red"
                           :weight bold)
                          (((class color) (background light))
                           :background "red"
                           :weight bold)))
         (flycheck-warning ((((class color) (background dark))
                             :background "DarkOrange"
                             :foreground "#222222")
                            (((class color) (background light))
                             :background "DarkOrange"
                             :foreground "#222222")))
         (completions-annotations ((t
                                    ;; ((class grayscale) (background light))
                                    :underline nil
                                    :inherit (italic shadow))))
         (font-lock-builtin-face
          ((((class grayscale) (background light))
            :foreground "LightGray" :weight bold)
           (((class grayscale) (background dark))
            :foreground "DimGray" :weight bold)
           (((class color) (background light))
            :foreground "dark violet")
           (((class color) (background dark))
            :foreground "LightSteelBlue")
           (((class color) (min-colors 16) (background light))
            :foreground "Orchid")
           (((class color) (min-colors 16) (background dark))
            :foreground "LightSteelBlue")
           (((class color) (min-colors 8))
            :foreground "blue" :weight bold)
           (t :weight bold)))
         (font-lock-variable-name-face
          ((((class grayscale) (background light))
            :foreground "Gray90" :weight bold :slant italic)
           (((class grayscale) (background dark))
            :foreground "DimGray" :weight bold :slant italic)
           (((class color) (min-colors 88) (background light))
            :foreground "orange red")
           (((class color) (min-colors 88) (background dark))
            :foreground "LightGoldenrod")
           (((class color) (min-colors 16) (background light))
            :foreground "DarkGoldenrod")
           (((class color) (min-colors 16) (background dark))
            :foreground "LightGoldenrod")
           (((class color) (min-colors 8))
            :foreground "yellow" :weight light)
           (t :weight bold :slant italic)))
         (font-lock-comment-face
          ((((class color) (background light))
            :foreground "#aaa"
            :slant italic)
           (((min-colors 24)) :foreground "#666")
           (((min-colors 8)) :slant italic)))
         (font-lock-doc-face ((t :slant italic
                                 :inherit (font-lock-string-face))))
         (font-lock-keyword-face
          ((((class color) (background dark))
            :foreground "#0bf" :weight bold)
           (((class color) (background light))
            :foreground "#09f" :weight bold)))
         (fringe ((((class color) (background dark)) :inherit default)
                  (((class color) (background light)) :inherit default)))
         (header-line ((((class color) (background dark))
                        :underline "#555"
                        :inherit mode-line-highlight)
                       (((class color) (background light))
                        :overline nil
                        :underline "#555"
                        :inherit mode-line)))
         (highlight ((((background light))
                      :background "darkseagreen2")
                     (t :background "dark olive green")))
         (highlight-defined-builtin-function-name-face
          ((((class color) (background dark)) :weight bold
            :inherit highlight-defined-function-name-face)
           (((class color) (background light))
            :inherit highlight-defined-function-name-face)))
         (line-number ((((class color) (background dark))
                        :foreground "#666")
                       (((class color) (background light))
                        :foreground "#777")))
         (line-number-current-line
          ((((class color) (background dark))
            :background "#ddd"
            :inverse-video t
            :inherit (line-number))
           (((class color) (background light))
            :background "#eee"
            :inverse-video t
            :inherit (line-number))))
         (line-number-major-tick
          ((((class color) (background dark))
            :foreground "#fff"
            :inherit (default))
           (((class color) (background dark))
            :foreground "#fff"
            :inherit (default))))
         (line-number-minor-tick
          ((((class color) (background dark))
            :foreground "#bbb")
           (((class color) (background dark))
            :foreground "#bbb")))
         (mode-line
          ((((class color) (background dark)) (:overline "#555"))
           (((class color) (background light)) :overline "#888")))
         (mode-line-buffer-id
          ((((class color) (background dark))
            :weight bold
            :foreground "#aaa"
            :overline "#999")
           (((class color) (background light))
            :weight bold
            :foreground "#333"
            :overline "#333")))
         (mode-line-highlight
          ((((class color) (background dark))
            :foreground "#bbb")))
         (mode-line-inactive
          ((((class color) (background dark))
            :inherit mode-line
            :foreground "#555")
           (((background light))
            :inherit mode-line
            :foreground "#999")))
         (mu4e-trashed-face
          ((t :strike-through t
              :inherit font-lock-comment-face
              :foreground "dark gray")))
         (mu4e-modeline-face ((t :weight bold )))
         (outline-1 ((t :inherit font-lock-function-name-face)))
         (outline-2 ((t :inherit font-lock-variable-name-face)))
         (outline-3 ((t :inherit font-lock-keyword-face)))
         (outline-4 ((t :inherit font-lock-comment-face)))
         (outline-5 ((t :inherit font-lock-type-face)))
         (outline-6 ((t :inherit font-lock-constant-face)))
         (outline-7 ((t :inherit font-lock-builtin-face)))
         (outline-8 ((t :inherit font-lock-string-face)))
         (org-superstar-leading ((t :inherit default)))
         (org-document-info-keyword
          ((t :overline t
              :foreground "tomato"
              :weight bold
              :inherit (shadow))))
         (parenthesis ((t :inherit font-lock-comment-face)))
         (region
          ((((class color) (background dark))
            :background "#555"
            :distant-foreground ,Z572-1-white
            :extend t)
           (((class color) (background light))
            :background "#ddd"
            :distant-foreground "#333"
            :extend t)))
         (org-headline-done
          ((((class color) (background light))
            :strike-through t
            :foreground "#585858")
           (((class color) (background dark))
            :strike-through t
            :foreground "LightSalmon")))
         (rime-highlight-candidate-face ((t :inherit font-lock-function-name-face)))
         (selectrum-primary-highlight
          ((t :foreground "#e44"
              :inherit bold)))
         (selectrum-secondary-highlight
          ((t :inherit selectrum-primary-highlight
              :underline t
              :foreground "#e44"
              :weight bold)))
         (show-paren-match
          ((((class color) (background dark))
            :weight bold
            :foreground "#aff")
           (((class color) (background light))
            :weight bold
            :foreground "#222")))
         (diff-refine-removed
          ((default
             :inherit diff-refine-changed)
           (((class color) (min-colors 257) (background light))
            :background "#ffaaaa")
           (((class color) (min-colors 88) (background light))
            :background "#ffbbbb")
           (((class color) (min-colors 88) (background dark))
            :background "#aa2222")))
         (diff-refine-added
          ((default
             :inherit diff-refine-changed)
           (((class color) (min-colors 257) (background light))
            :background "#8f8")
           (((class color) (min-colors 88) (background light))
            :background "#aaffaa")
           (((class color) (min-colors 88) (background dark))
            :background "#22aa22")))
         (magit-process-ok
          ((t :foreground "black" :inherit magit-section-heading)))
         (magit-diff-context-highlight
          ((((class color) (background light))
            :extend t
            :background "#fafafa"
            :foreground "grey50")
           (((class color) (background dark))
            :extend t
            :background "grey20"
            :foreground "grey70")))
         (magit-diff-hunk-heading-highlight
          ((((class color) (background light))
            :extend t
            :background "grey75"
            :foreground "black")
           (((class color) (background dark))
            :extend t
            :background "grey35"
            :foreground "grey70")))
         (magit-section-heading
          ((((class color) (background light))
            :foreground "#09f"
            :weight bold
            :extend t)
           (((class color) (background  dark))
            :extend t
            :foreground "LightGoldenrod2"
            :weight bold)))
         (telega-entity-type-code
          ((t :background "#333" :underline t)))
         (telega-msg-heading ((t nil)))
         (telega-msg-inline-forward
          ((((class color) (background dark))
            :background "#555")))
         (telega-msg-inline-reply
          ((((class color) (background dark))
            :background "#444")))
         (telega-msg-user-title
          ((((class color) (background dark))
            :background "#333")))
         (telega-webpage-preformatted
          ((t :background "#000"
              :extend t
              :inherit telega-webpage-fixed)))
         (term-color-black
          ((t :foreground "black"
              :background "#585858")))
         (term-color-blue
          ((t :foreground "#7aa6da"
              :background "#7cafc2")))
         (term-color-cyan
          ((t :foreground "#70c0ba"
              :background "#1abb9b")))
         (term-color-green
          ((t :foreground "#00cc00"
              :background "#8d8f8d")))
         (term-color-magenta
          ((t :foreground "#c397d8"
              :background "#ba8baf")))
         (term-color-red
          ((t :foreground "#d54e53"
              :background "#ab4642")))
         (term-color-white
          ((t :foreground ,Z572-1-white
              :background "#f8f8f8")))
         (term-color-yellow
          ((t :foreground "#e6c547"
              :background "#f7ca88")))
         (whitespace-line
          ((((class color) (background light))
            :background "#cacaca" :underline t)
           (t :background "#404040" :underline t)))))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (let ((base (file-name-directory load-file-name)))
    (add-to-list 'custom-theme-load-path base)))

(provide-theme 'Z572-1)
