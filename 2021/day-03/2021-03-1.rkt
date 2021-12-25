#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")

(define (get-power data)
  (for/fold ([gamma 0]
             [epsilon 0]
             #:result (* gamma epsilon))
            ([index (range 0 (string-length (car data)))]
             [power (range (- (string-length (car data)) 1) -1 -1)])
    (if (>= (/ (count (λ (x) (equal? (string-ref x index) #\1)) data)
               (length data))
            0.5)
        (values (+ gamma (expt 2 power)) epsilon)
        (values gamma (+ epsilon (expt 2 power))))))

(get-power (string-split sample_data "\n"))
(get-power (string-split input_data "\n"))
(count-deeper (file->string "sample-2021-01.txt"))
(count-deeper (file->string "input-2021-01.txt"))

