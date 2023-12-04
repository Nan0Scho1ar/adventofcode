#lang racket

(define grid (map (λ (line) (map (λ (tree) (cons (string->number tree) #f)) (string-split line #rx"(?<=.)(?=.)")))
                  (file->lines "input-8-1.txt")))

(define example-grid (map (λ (line) (map (λ (tree) (cons (string->number tree) #f)) (string-split line #rx"(?<=.)(?=.)")))
                  (file->lines "input-8-example.txt")))


(define (mark-row row)
  (for/fold ([marked '()]
             [tallest -1]
             #:result (reverse marked))
            ([tree row])
    (let ([t (car tree)])
      (if (> t tallest)
          (values (cons (cons t #t) marked) t)
          (values (cons tree marked) tallest)))))

(define (mark-grid grid)
  (let* ([left (map mark-row grid)]
         [grid (map reverse left)]
         [right (map mark-row grid)]
         [grid (map reverse right)]
         [grid (apply map list grid)]
         [top (map mark-row grid)]
         [grid (map reverse top)]
         [bottom (map mark-row grid)]
         [grid (map reverse bottom)]
         [grid (apply map list grid)])
    grid))


(define (print-grid grid)
  (for ([row grid])
    (for ([tree row])
      (if (cdr tree)
          (display #t)
          (display (string-append "0" (number->string (car tree)))))
      (display " "))
    (newline)))

;; (define marked (mark-grid example-grid))
(define marked (mark-grid grid))

(print-grid marked)

(apply + (map (λ (row) (length (filter (λ (tree) (eq? (cdr tree) #t)) row))) marked))
