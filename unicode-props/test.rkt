#lang racket

(require "derived-core-properties.rkt")

(module+ test
  (require rackunit)
  (check-true (xid-start-codepoint? (char->integer #\a)))
  (check-false (xid-start-codepoint? (char->integer #\0)))
  (check-false (xid-start-codepoint? (char->integer #\space)))
  (check-true (xid-start-codepoint? (char->integer #\U11109)))
  (check-true (xid-start-codepoint? 178205))
  (check-false (xid-start-codepoint? 178206))
  ;; must check false not true, member doesn't return true...
  (check-false (not (member 119970 xid-start-codepoints)))
  (check-false (not (member '(119997 . 120003) xid-start-codepoints)))
  ;; tests for xid-continue:
  (check-true (xid-continue-codepoint? (char->integer #\a)))
  (check-true (xid-continue-codepoint? (char->integer #\0)))
  (check-false (xid-continue-codepoint? (char->integer #\space)))
  (check-true (xid-continue-codepoint? (char->integer #\U11109)))
  (check-true (xid-continue-codepoint? 126629))
  (check-false (xid-continue-codepoint? 126628))
  )
