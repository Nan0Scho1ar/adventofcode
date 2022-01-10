#lang racket

;; Return an entire file as a string
(define (file->string fname)
  (with-input-from-file fname (λ () (port->string))))

(provide file->string)



;; Return an entire file as a string
(define (file->string-trimmed fname)
  (string-trim (with-input-from-file fname (λ () (port->string)))))

(provide file->string-trimmed)



;; Converts a list of bits to an integer (big endian)
(define (bitlist->number bits)
  (for/sum([bit bits]
           [idx (range (- (length bits) 1) -1 -1)])
    (* bit (expt 2 idx))))

(provide bitlist->number)



;; Returns the average of a list of numbers
(define (avg nums)
  (/ (apply + nums) (length nums)))

(provide avg)



;; Convert a string containing a binary number to a bitlist
(define (string->bitlist chars)
  (for/list ([bit (string->list chars)])
    (if (equal? bit #\1) 1 0)))

(provide string->bitlist)



;; Converts lines of binary numbers to list of bitlists
(define (strings->bitlists data)
  (for/list ([line (string-split data "\n")])
    (string->bitlist line)))

(provide strings->bitlists)



;; Returns a column from a list of lists at idx
(define (column-at-idx nums idx)
  (for/list ([num nums])
    (list-ref num idx)))

(provide column-at-idx)



;; Returns the average of a column in a list of lists
(define (avg-column-at-idx nums idx)
  (if (>= (avg (column-at-idx nums idx)) 0.5) 1 0))

(provide avg-column-at-idx)



;; Create a list from elements and then flatten it
(define (flatlist . a)
  (flatten a))

(provide flatlist)



;; Set the bit at bit-idx in an integer
(define (set-bit-in-int int bit-idx)
  (bitwise-ior int (arithmetic-shift 1 bit-idx)))

(provide set-bit-in-int)



;; Set the bit at bit-idx for the element at idx in the list
(define (set-bit-in-int-list states idx bit-idx)
  (list-set states idx (set-bit-in-int (list-ref states idx) bit-idx)))

(provide set-bit-in-int-list)



;; Returns true if all the bits in the mask are set in the int
(define (fills-mask? int mask)
  (= (bitwise-and int mask) mask))

(provide fills-mask?)



;; Shift the entire list left putting the first elem at the end
(define (lshift lst)
  (append (rest lst) (list (first lst))))

(provide lshift)



;; Shift the entire list right putting the last elem at the front
(define (rshift lst)
  (append (list (last lst)) (drop-right lst 1)))

(provide rshift)



;; prepend to list at a given index of a list
(define (prepend-at-idx lst idx val)
  (list-set lst idx (cons val (list-ref lst idx))))

(provide prepend-at-idx)


;; prepend to list at a given index of a list
(define (prepend-at-idxs lst idxs val)
  (for/fold ([updated lst])
            ([idx idxs])
    (prepend-at-idx updated idx val)))

(provide prepend-at-idxs)


;; Add val to the element at a given index of a list
(define (add-at-idx lst idx val)
  (list-set lst idx (+ val (list-ref lst idx))))

(provide add-at-idx)



;; Convert a row of comma seperated values to list of ints
(define (string-split-numbers str sep)
  (map string->number (string-split str sep)))

(provide string-split-numbers)



;; Finds the distance between min and max
(define (minmax-dist lst [inclusive #f])
  (if inclusive
      (- (add1 (apply max lst)) (apply min lst))
      (- (apply max lst) (apply min lst))))

(provide minmax-dist)



;; Creates a range from 0 to the distance between min and max
(define (range-minmax-dist lst [inclusive #f])
  (range (minmax-dist lst inclusive)))

(provide range-minmax-dist)



;; Creates a range from the min int in list to the max int in list
(define (range-minmax lst [inclusive #f])
  (if inclusive
      (range (apply min lst) (add1 (apply max lst)))
      (range (apply min lst) (apply max lst))))

(provide range-minmax)



;; Cumulative sum of elements in a list
(define (cumsum xs)
  (for/fold ([out '()] [sum-so-far 0] #:result (reverse out))
            ([x (in-list xs)])
    (define new-sum (+ sum-so-far x))
    (values (cons new-sum out) new-sum)))

(provide cumsum)



;; Cumulative sum of elements for a given range
(define (cumsum-range start stop)
  (cumsum (range start stop)))

(provide cumsum-range)
