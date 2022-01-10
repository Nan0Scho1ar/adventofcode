#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")
(require threading)

(define (count-segments fname)
  (~>> fname
       (file->string-trimmed)
       (string-split _ "\n")
       (map (λ~> (string-split " | ") (cdr) (map (curryr string-split " ") _)))
       (flatten)
       (count (λ~> (string-length) (member '(2 3 4 7))))))

(count-segments "sample-2021-08.txt")
(count-segments "input-2021-08.txt")
