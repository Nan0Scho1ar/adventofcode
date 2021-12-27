#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")

(define (parse-kvp kvp)
  (list (car (string-split kvp " "))
        (string->number (cadr (string-split kvp " ")))))

(define (get-pos data)
  (for/fold ([x 0]
             [y 0]
             #:result (* x y))
            ([line (string-split data "\n")])
    (match-define (list key val) (parse-kvp line))
    (match key
      ["forward" (values (+ x val) y)]
      ["up"      (values x (- y val))]
      ["down"    (values x (+ y val))])))

(get-pos (file->string "sample-2021-02.txt"))
(get-pos (file->string "input-2021-02.txt"))
