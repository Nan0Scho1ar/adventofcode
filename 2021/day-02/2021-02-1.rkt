#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")

(define (get-key kvp) (car (string-split kvp " ")))
(define (get-val kvp) (string->number (cadr (string-split kvp " "))))
(define (get-pos data)
  (*
   (for/sum ([line (string-split data "\n")]
             #:when (equal? (get-key line) "forward"))
     (get-val line))
   (for/sum ([line (string-split data "\n")]
             #:when (not (equal? (get-key line) "forward")))
     (if (equal? (get-key line) "down") (get-val line) (- (get-val line))))))


(define (parse-kvp kvp)
  (list (car (string-split kvp " "))
        (string->number (cadr (string-split kvp " ")))))

(define (get-pos2 data)
  (for/fold ([x 0]
             [y 0]
             #:result (* x y))
            ([line (string-split data "\n")])
    (match-define (list key val) (parse-kvp line))
    (match key
      ["forward" (values (+ x val) y)]
      ["up"      (values x (- y val))]
      ["down"    (values x (+ y val))])
    ))

(get-pos2 sample_data)
(get-pos2 input_data)
(count-deeper (file->string "sample-2021-01.txt"))
(count-deeper (file->string "input-2021-01.txt"))

