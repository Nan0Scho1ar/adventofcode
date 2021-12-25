#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")

(define (strings->bitlists data)
  (for/list ([lines (string-split data "\n")])
    (for/list ([bit (string->list lines)])
      (if (equal? bit #\1) 1 0))))

(define (bitlist->number bits)
  (for/sum([bit bits]
           [idx (range (- (length bits) 1) -1 -1)])
    (* bit (expt 2 idx))))

(define (at-idx nums idx)
  (for/list ([num nums])
    (list-ref num idx)))

(define (avg nums)
  (/ (apply + nums) (length nums)))

(define (most-common nums idx)
  (if (>= (avg (at-idx nums idx)) 0.5) 1 0))

(define (get-val numlist isCo2 [idx 0])
  (let* ([target (most-common numlist idx)]
         [nums (filter (λ (n) (xor isCo2 (= (list-ref n idx) target)))
                       numlist)])
    (if (< (length nums) 2)
        (bitlist->number (car nums))
        (get-val nums isCo2 (add1 idx)))))

(define (check-lifesupport data)
  (* (get-val data #t) (get-val data #f)))

(println (check-lifesupport (strings->bitlists sample_data)))
(println (check-lifesupport (strings->bitlists input_data)))
(count-deeper (file->string "sample-2021-01.txt"))
(count-deeper (file->string "input-2021-01.txt"))

