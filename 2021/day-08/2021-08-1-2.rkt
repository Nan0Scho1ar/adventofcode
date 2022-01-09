#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")
(require threading)

(define (count-segments data)
  (let ([split-tail (λ~> (string-split " | ") cadr (string-split " "))]
        [valid-length (λ~> string-length (member '(2 3 4 7)))])
    (~>> data
        (file->string-trimmed)
        (string-split _ "\n")
        (map split-tail)
        (flatten)
        (count valid-length))))

(count-segments "sample-2021-08.txt")
(count-segments "input-2021-08.txt")
