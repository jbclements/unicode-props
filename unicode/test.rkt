#lang racket

(require "derived-core-properties.rkt")

(module+ test
  (require rackunit)
  (check-true (xid-start-codepoint? (char->integer #\a)))
  (check-false (xid-start-codepoint? (char->integer #\0)))
  (check-false (xid-start-codepoint? (char->integer #\space)))
  ;; chakma letter "GAA":
  (check-true (xid-start-codepoint? (char->integer #\U11109)))
  (check-true (xid-continue-codepoint? (char->integer #\a)))
  (check-true (xid-continue-codepoint? (char->integer #\0)))
  (check-false (xid-continue-codepoint? (char->integer #\space)))
  ;; chakma letter "GAA":
  (check-true (xid-continue-codepoint? (char->integer #\U11109)))
  )
