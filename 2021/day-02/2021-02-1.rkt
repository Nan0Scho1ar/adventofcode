#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")

(define (get-key kvp) (car (string-split kvp " ")))

(define (get-val kvp) (string->number (cadr (string-split kvp " "))))

(define (get-pos data)
  (*
   (for/sum ([line (string-split data "\n")]
             #:when (equal? (get-key line) "forward"))
     (get-val line))
   (for/sum ([line (string-split data "\n")]
             #:when (not (equal? (get-key line) "forward")))
     (if (equal? (get-key line) "down") (get-val line) (- (get-val line))))))

(get-pos (file->string "sample-2021-02.txt"))
(get-pos (file->string "input-2021-02.txt"))
