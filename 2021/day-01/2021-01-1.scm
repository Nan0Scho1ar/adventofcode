(use-modules (ice-9 textual-ports))

(define (file->string-trimmed fname)
  (string-trim-right
   (call-with-input-file fname get-string-all)
   #\newline))

(define (count-deeper data)
  (compare
   (map string->number
        (string-split (file->string-trimmed data) #\newline))))

(define (compare nums)
  (let lp ((i nums))
    (let ((j (cadr nums)))
      (display i)
      (newline)
      (display j)
      (if (= 0 (length nums))
          i
          (lp (cdr i))
          ))))
;;     (when (> j i)
;;       (display i)
;;       (newline)
;;       (display j)
;;       (newline)))))

(count-deeper "sample-2021-01.txt")

(define (curry func . args) (lambda x (apply func (append args x))))
(define num '((1 2 3) (1 2 3) (1 2 3) (1 2 3)))

(let lp ((x 1000))
  (display x)
  (newline)
  (if (positive? x)
      (lp (- x 1))
      x))

(define (recursive x)
  (display x)
  (newline)
  (if (positive? x)
      (recursive (- x 1))
      x))

(recursive 10)
