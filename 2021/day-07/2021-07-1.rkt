#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")

;; Calculate cost of all possble columns and return the cheapest.
(define (cheapest-pos data)
  (let ([crab-positions (string-split-numbers data ",")])
    (apply min
           (for/list ([column-idx (range-minmax crab-positions)])
             ;; Calculate the cost of this column
             (for/sum ([crab-position crab-positions])
               (abs (- crab-position column-idx)))))))

(cheapest-pos (file->string-trimmed "sample-2021-07.txt"))
(cheapest-pos (file->string-trimmed "input-2021-07.txt"))
