#lang racket
(require algorithms)

(define-syntax-rule (values->list generator)
  (call-with-values (λ () generator) list))

(define (priority item-type)
  (index-of (string->list " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ") item-type))

(define (split-compartments rucksack)
  (values->list (split-at rucksack (/ (length rucksack) 2))))

(define (first-intersection lists)
  (set-first (apply set-intersect (map list->set lists))))

(define (priority-sum container-groups)
  (for/sum ([container-group container-groups])
    (priority (first-intersection container-group))))

(define rucksacks (map string->list (file->lines "input-3-1.txt")))

(display "Part 1: ")
(println (priority-sum (map split-compartments rucksacks)))

(display "Part 2: ")
(println (priority-sum (chunks-of rucksacks 3)))
