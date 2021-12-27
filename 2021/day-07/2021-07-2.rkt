#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")

;; Calculate cost of all possble columns and return the cheapest.
(define (cheapest-pos data)
  (let* ([crabs (string-split-numbers data ",")]
         [cost-at-distance (cumsum-range 0 (minmax-dist crabs #t))])
    (apply min
           (for/list ([pos (range-minmax crabs)])
             ;; Calculate the cost of this column
             (for/sum ([crabpos crabs])
               (list-ref cost-at-distance (abs (- crabpos pos))))))))

(cheapest-pos (file->string-trimmed "sample-2021-07.txt"))
(cheapest-pos (file->string-trimmed "input-2021-07.txt"))
