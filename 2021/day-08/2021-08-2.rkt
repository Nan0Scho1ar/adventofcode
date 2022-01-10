#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")
(require threading)

(define (parse-data fname)
  (map
   (λ~> (string-split " | ") (map (λ~> (string-split " ")) _))
   (~> fname (file->string-trimmed) (string-split "\n"))))

(define (filter-blank x)
  (filter (λ (y) (not (equal? y ""))) x))

(define (get-letter-groups line)
  (let* ([split-single    (λ (x) (filter-blank (string-split (car x) "")))]
         [map-split       (λ (x) (map (curryr string-split "") x))]
         [apply-intersect (λ (x) (apply set-intersect (map-split x)))]
         [split-intersect (λ (x) (filter-blank (apply-intersect x)))])
    (match-let* ([(list one seven four five six eight)
                  (for/fold ([acc '(() () () () () ())])
                            ([seq line])
                    (prepend-at-idx acc (- (string-length seq) 2) seq))])
      (list (split-single one)
            (split-single four)
            (split-intersect five)
            (split-intersect six)
            (split-single seven)
            (split-single eight)))))

(define (solve-segments inputs)
  (match-let*
      ([(list one four five six seven eight) (get-letter-groups inputs)]
       [top (remove* one seven)]
       [br (set-intersect six one)]
       [tr (remove* br one)]
       [mid (set-intersect five four)]
       [bot (remove* top (remove* mid five))]
       [tl (remove* one (remove* mid four))]
       [bl (remove* bot (remove* top (remove* four eight)))])
    (list (car top) (car tl) (car tr) (car mid) (car bl) (car br) (car bot)))
  )

(define (map-output-digit seq input-segments)
  (index-of '(119 36 93 109 46 107 123 37 127 111)
            (for/fold ([value 0])
                      ([seg (filter-blank (string-split seq ""))])
              (+ value (expt 2 (index-of input-segments seg))))))

(define (determine-outputs rows)
  (for/list ([input (map car rows)]
             [output (map cadr rows)])
    (for/list ([segment output])
      (map-output-digit segment (solve-segments input)))))

(define (combine-digits digits)
  (for/fold ([acc 0] [mult 1] #:result acc)
            ([digit (reverse digits)])
    (values (+ acc (* digit mult)) (* mult 10))))

(define (calculate-answer fname)
  (apply + (map combine-digits (determine-outputs (parse-data fname)))))

(calculate-answer "sample-2021-08.txt")
(calculate-answer "input-2021-08.txt")
