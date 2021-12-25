#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")

(define (count-deeper data)
  (let ([nums (map string->number (string-split data "\n"))])
    (for/sum ([i nums]
              [j (cdr nums)]
              #:when (> j i))
      1)))


(count-deeper (file->string "sample-2021-01.txt"))
(count-deeper (file->string "input-2021-01.txt"))
