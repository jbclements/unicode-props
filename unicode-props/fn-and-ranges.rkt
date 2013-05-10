#lang racket

;; fn-and-ranges allows a single piece of syntax to define
;; both a direct representation of a range of codepoints and
;; also a membership function.

(provide define-fn-and-ranges)

;; define a raw range-list and also a membership function
(define-syntax define-fn-and-ranges
  (syntax-rules ()
    [(_ ranges-id fn-id ranges)
     (begin 
       (define ranges-id (quote ranges))
       (define (fn-id arg)
         (check-in-ranges arg ranges)))]))

;; expands, e.g., (check-in-ranges foo (3 (14 . 19))) 
;; into (or (= foo 3) (<= 14 foo 19))
(define-syntax check-in-ranges
  (syntax-rules ()
    [(_ id (range-elt ...))
     (or (range-elt-check id range-elt) ...)]))

(define-syntax range-elt-check
  (syntax-rules ()
    [(_ id (lo . hi))
     (<= lo id hi)]
    [(_ id n)
     (= n id)]))
