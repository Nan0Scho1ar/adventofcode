#lang racket

(define (sum-calories chunk)
  (apply + (map string->number (string-split chunk "\n"))))

(define (parse-elves filename)
  (map sum-calories (string-split (file->string filename) "\n\n")))

(define sorted (sort (parse-elves "input-1-1.txt") >))

(display "Part 1: ")
(displayln (first sorted))

(display "Part 2: ")
(displayln (apply + (take sorted 3)))
