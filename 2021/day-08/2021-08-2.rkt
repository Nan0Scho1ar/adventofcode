#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")
(require threading)

(define (parse-data fname)
  (let* ([split-space (λ~> (string-split " "))]
         [inner-split (λ~> (string-split " | ") (map split-space))]
         [lines (~> fname (file->string-trimmed) (string-split "\n"))])
    (map inner-split lines)))

(define (count-segments fname)
  (let ([valid-length (λ~> (string-length) (member '(2 3 4 7)))])
    (~>> fname
        (parse-data)
        (map cdr)
        (flatten)
        (count valid-length))))

(count-segments "sample-2021-08.txt")
(count-segments "input-2021-08.txt")
