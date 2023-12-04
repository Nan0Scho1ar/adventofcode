#lang racket


(define (mp proc lst)
  lst)

(define (maap proc lst)
  (map (λ (inner-list) (map proc inner-list)) lst))

(define (maaap proc lst)
  (maap (λ (inner-list) (map proc inner-list)) lst))

(define (maaaap proc lst)
  (maaap (λ (inner-list) (map proc inner-list)) lst))

(define list-1d (list 1 2 3))
(define list-2d (list list-1d list-1d))
(define list-3d (list list-2d list-2d))
(define list-4d (list list-3d list-3d))

(map (λ (elems) (add1 elems)) list-1d)
(maap (λ (elems) (add1 elems)) list-2d)
(maaap (λ (elems) (add1 elems)) list-3d)
(maaaap (λ (elems) (add1 elems)) list-4d)



(define (string->number* . numbers)
  (map (λ (number) (string->number number)) numbers))
