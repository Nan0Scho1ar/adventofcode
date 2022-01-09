#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")

(define (count-segments data)
  (length
   (flatten
    (map (λ (line)
           (filter (λ (num) (member (string-length num) '(2 3 4 7)))
                   (string-split
                    (cadr
                     (string-split line " | ")) " ")))
         (string-split (file->string-trimmed data) "\n")))))

(count-segments "sample-2021-08.txt")
(count-segments "input-2021-08.txt")
