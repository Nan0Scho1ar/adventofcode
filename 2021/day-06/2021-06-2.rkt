#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")

;; Convert the string of fish ages into a list of days
(define (format-data data)
  (for/fold ([days '(0 0 0 0 0 0 0 0 0)])
            ([fish (string-split-numbers data ",")])
    (add-at-idx days fish 1)))

;; Simulate the pool of fishes for a given number of days
(define (simulate-pool data days-remaining)
  (for/fold ([pool (format-data data)]
             #:result (apply + pool))
            ([i (range days-remaining 0 -1)])
    (lshift (add-at-idx pool 7 (first pool)))))

(simulate-pool (file->string-trimmed "sample-2021-06.txt") 256)
(simulate-pool (file->string-trimmed "input-2021-06.txt") 256)
