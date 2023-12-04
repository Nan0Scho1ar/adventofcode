#lang racket

(define (maap proc lst)
  (map (λ (inner-list) (map proc inner-list)) lst))

(define (extract-crates row)
  (map (λ (index) (string-ref row index))
      (list 1 5 9 13 17 21 25 29 33)))

(define (extract-moves row)
  (map (λ (index) (list-ref (string-split row) index))
      (list 1 3 5)))

(define (parse-input file-name)
  (let* ([sections (string-split (file->string file-name) "\n\n")]
         [crates (map extract-crates (string-split (first sections) "\n"))]
         [moves (map extract-moves (string-split (second sections) "\n"))])
    (values
     ;; transpose crates matrix then remove spaces.
     (map (curry remove* '(#\space)) (apply map list crates))
     ;; parse moves to numbers
     (maap string->number moves))))

(define (simulate crates moves #:reverse reverse?)
  (for/fold ([state crates])
            ([move moves])
    (let* ([numcrates (first move)]
           [target-index (sub1 (second move))]
           [destination-index (sub1 (third move))]
           [target-column (list-ref state target-index)]
           [destination-column (list-ref state destination-index)]
           [moved-crates (take target-column numcrates)]
           [moved-crates (if reverse? (reverse moved-crates) moved-crates)]
           [new-target-column (list-tail target-column numcrates)]
           [new-destination-column (flatten (list moved-crates destination-column))]
           [state-with-new-target (list-set state target-index new-target-column)])
      (list-set state-with-new-target destination-index new-destination-column))))

(define-values (crates moves) (parse-input "input-5-1.txt"))

(display "Part 1: ")
(displayln (list->string (map car (simulate crates moves #:reverse #t))))

(display "Part 2: ")
(displayln (list->string (map car (simulate crates moves #:reverse #f))))
