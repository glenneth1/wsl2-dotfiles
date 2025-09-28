;; Guix channels configuration with faster mirrors and nonguix
;; This file configures alternative Git repositories for faster channel updates

(cons* (channel
        (name 'guix)
        (url "https://codeberg.org/guix/guix")  ; Faster mirror
        (branch "master")
        (introduction
         (make-channel-introduction
          "9edb3f66fd807b096b48283debdcddccfea34bad"
          (openpgp-fingerprint
           "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))

       ;; Nonguix channel for non-free software and WSL2 compatibility
       (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix")
        ;; Enable signature verification:
        (introduction
         (make-channel-introduction
          "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
          (openpgp-fingerprint
           "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
       
       ;; Fallback to official repository if needed
       ;; (channel
       ;;  (name 'guix-official)
       ;;  (url "https://git.savannah.gnu.org/git/guix.git")
       ;;  (branch "master"))
       
       %default-channels)
