#lang racket

(define (parse-input file-name)
  (map split-pair (file->lines file-name)))

(define (split-pair line)
  (map split-range (string-split line ",")))

(define (split-range pair)
  (map string->number (string-split pair "-")))

(define (surrounds? a b)
  (and (<= (first a) (first b)) (>= (second a) (second b))))

(define (overlaps? a b)
  (and (<= (first a) (first b)) (>= (second a) (first b))))

(define (conflicts? comparison ranges)
  (or (comparison (first ranges) (second ranges))
     (comparison (second ranges) (first ranges))))

(define (count-conflicts comparison range-pairs)
  (length (filter (curry conflicts? comparison) range-pairs)))

(display "Part 1: ")
(println (count-conflicts surrounds? (parse-input "input-4-1.txt")))

(display "Part 2: ")
(println (count-conflicts overlaps? (parse-input "input-4-1.txt")))
