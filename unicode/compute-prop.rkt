#lang racket

(require net/url)

(define props
  `(("DerivedCoreProperties.txt"
     "derived-core-properties.rkt"
     (("XID_Start" xid-start)
      ("XID_Continue" xid-continue)))))

;; given a file in the unicode UCD directory, fetch it to a temp file and return the name:
(define (fetch-file text-file-name)
  (define temp-f (make-temporary-file))
  (call-with-output-file temp-f
    #:exists 'truncate
    (lambda (op)
      (copy-port
       (get-pure-port (string->url (~a "http://www.unicode.org/Public/6.2.0/ucd/" text-file-name)))
       op))))

;; path-string string -> syntax
;; given a file and a character class mentioned in the file,
;; return an s-exp
(define (membership-fn temp-path char-class-name)
  (define line-regexp
    (pregexp (string-append "^([^;]*); *" char-class-name)))
  (call-with-input-file temp-path
    (lambda (ip)
      ;; I wish stx were appropriate here,
      ;; but I think it's not.
      `(lambda (code-point)
          (or
           ,@(for/list ([line (in-lines ip)]
                        #:when (regexp-match line-regexp line))
               (match-define (list _ char-range) 
                 (regexp-match line-regexp line))
               (match char-range
                 [(regexp 
                   #px"^([[:xdigit:]]+)\\.\\.([[:xdigit:]]+)\\w*"
                   (list _ pre post))
                  `(<= ,(hex->num pre) code-point ,(hex->num post))]
                 [(regexp #px"^([[:xdigit:]]+)\\w*"
                          (list _ only))
                  `(= code-point ,(hex->num only))])))))))

;; given a hex number string, return a number
(define (hex->num str)
  (string->number str 16))

(define xid-start-fn 
  `(define xid-start-code-point? 
     ,(membership-fn "XID_Start")))
(define xid-continue-fn (membership-fn "XID_Continue"))
