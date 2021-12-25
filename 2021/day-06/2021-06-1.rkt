#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")

;; Shift the entire list left putting the first elem at the end
(define (lshift lst)
  (append (rest lst) (list (first lst))))

;; Add val to the element at a given index of a list
(define (add-at-idx lst idx val)
  (list-set lst idx (+ val (list-ref lst idx))))

;; Convert the string of fish ages into a list of days
(define (format-data data)
  (for/fold ([days '(0 0 0 0 0 0 0 0 0)])
            ([fish (map string->number (string-split data ","))])
    (add-at-idx days fish 1)))

;; Simulate the pool of fishes for a given number of days
(define (simulate-pool data days-remaining)
  (for/fold ([pool (format-data data)]
             #:result (apply + pool))
            ([i (range days-remaining 0 -1)])
    (lshift (add-at-idx pool 7 (first pool)))))

(simulate-pool sample_data 80)
(simulate-pool input_data 80)
(count-deeper (file->string "sample-2021-01.txt"))
(count-deeper (file->string "input-2021-01.txt"))

