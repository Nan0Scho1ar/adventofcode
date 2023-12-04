#lang racket
(require algorithms)

(define (marker-end-index file-name size)
  (let* ([panes (sliding (string->list (file->string file-name)) size)])
    (+ size (index-where panes (λ (pane) (not (check-duplicates pane)))))))

(display "Part 1: ")
(displayln (marker-end-index "input-6-1.txt" 4))

(display "Part 2: ")
(displayln (marker-end-index "input-6-1.txt" 14))




;; (define (windowed lst size)
;;   (for/fold ([panes '()]
;;              [remaining lst]
;;              #:result (reverse panes))
;;             ([i (add1 (- (length lst) size))])
;;     (values (cons (take remaining size) panes)
;;            (cdr remaining))))

;; (define (marker-end-index buffer size)
;;   (let* ([panes (windowed (string->list buffer) size)]
;;          [unique-counts (map (λ (lst) (set-count (list->set lst))) panes)])
;;     (+ (index-of unique-counts size) size)))

;; (displayln (marker-end-index (file->string "input-6-1.txt") 4))
;; (displayln (marker-end-index (file->string "input-6-1.txt") 14))




;; (require rebellion/streaming/transducer)
;; (require rebellion/streaming/reducer)
;; (require rebellion/collection/set)
;; (require rebellion/base/option)

;; (define (marker-end-index2 file-name size)
;;   (+ size (present-value
;;            (transduce (file->string file-name)
;;                      (windowing size #:into into-set)
;;                      (mapping set-count)
;;                      #:into (into-index-of size)))))

;; (marker-end-index2 "input-6-1.txt" 4)
;; (marker-end-index2 "input-6-1.txt" 14)
