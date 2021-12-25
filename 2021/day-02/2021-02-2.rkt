#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")

(define (parse-kvp kvp)
  (list (car (string-split kvp " "))
        (string->number (cadr (string-split kvp " ")))))

(define (get-pos data)
  (for/fold ([x 0]
             [y 0]
             [aim 0]
             #:result (* x y))
            ([line (string-split data "\n")])
    (match-define (list key val) (parse-kvp line))
    (match key
      ["up"      (values x y (- aim val))]
      ["down"    (values x y (+ aim val))]
      ["forward" (values (+ x val) (+ y (* aim val)) aim)])))

(get-pos sample_data)
(get-pos input_data)
(count-deeper (file->string "sample-2021-01.txt"))
(count-deeper (file->string "input-2021-01.txt"))

