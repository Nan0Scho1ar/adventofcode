#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")

(define (get-val numlist isCo2 [idx 0])
  (let* ([target (avg-column-at-idx numlist idx)]
         [nums (filter (λ (n) (xor isCo2 (= (list-ref n idx) target)))
                       numlist)])
    (if (< (length nums) 2)
        (bitlist->number (car nums))
        (get-val nums isCo2 (add1 idx)))))

(define (check-lifesupport data)
  (* (get-val data #t) (get-val data #f)))

(check-lifesupport (strings->bitlists (file->string "sample-2021-03.txt")))
(check-lifesupport (strings->bitlists (file->string "input-2021-03.txt")))
