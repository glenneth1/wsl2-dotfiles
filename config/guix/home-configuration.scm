;; Guix Home configuration for Glenn's Scheme development environment

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (gnu home services)
             (gnu home services shells)
             (gnu home services guix)
             (gnu home services mcron)
             (guix gexp))

(home-environment
  ;; Packages to install in the home environment
  (packages (specifications->packages 
             '(;; System essentials
               "glibc-locales"
               
               ;; Scheme/Guile development environment
               "guile-next"        ; Latest Guile development version
               "guile-hoot"        ; Scheme to WebAssembly compiler
               "guile-goblins"     ; Distributed programming environment
               "guile-lib"         ; Useful Guile libraries
               "guile-reader"      ; Reader extensions for Guile
               "guile-json"        ; JSON support for Guile
               
               ;; Development tools  
               ;; Note: Using custom-built Emacs 31.0.50 installation
               "git"               ; Version control
               "make"              ; Build system
               "gcc-toolchain"     ; C compiler and tools
               "pkg-config"        ; Package configuration
               "texinfo"           ; Documentation system
               "rlwrap")))         ; Readline wrapper for better REPL experience

  ;; Services for the home environment
  (services
   (list
    ;; Set up environment variables for Scheme development
    (simple-service 'scheme-dev-env-vars
                    home-environment-variables-service-type
                    '(("EDITOR" . "emacs")
                      ("GUILE_LOAD_PATH" . "$HOME/.guix-home/profile/share/guile/site/3.0:$GUILE_LOAD_PATH")
                      ("GUILE_LOAD_COMPILED_PATH" . "$HOME/.guix-home/profile/lib/guile/3.0/site-ccache:$GUILE_LOAD_COMPILED_PATH")
                      ("GUIX_LOCPATH" . "$HOME/.guix-home/profile/lib/locale")
                      ("GUILE_AUTO_COMPILE" . "1")
                      ("GUILE_WARN_DEPRECATED" . "detailed")))

    ;; Add a simple mcron job for keeping system updated
    (simple-service 'update-reminder
                    home-mcron-service-type
                    (list #~(job "0 12 * * 0"  ; Every Sunday at noon
                                "echo 'Consider running: guix pull && guix home reconfigure ~/.config/guix/home-configuration.scm'"))))))
