#lang racket
(require "../../libs/racket/n0s1-aoc.rkt")

;; Create a list of with two elements and then flatten it
(define (flatlist a b)
  (flatten (list a b)))

;; Parse the input string into the form (nums-called ((board1) (board2) ...))
(define (prep-data data)
    (let* ([cleaned (regexp-replaces data '([#rx"\n " "\n"] [#rx"^ |  " " "]))]
           [chunks (string-split cleaned "\n\n")])
    (list (map string->number (string-split (first chunks) ","))
          (for/list ([board (rest chunks)])
            (map string->number
                 (string-split (string-replace board "\n" " ") " "))))))

;; These are the masks which correspond to 5 in a row or column
(define win-states
  '(31 992 31744 1015808 32505856 1082401 2164802 4329604 8659208 17318416))

;; Check if any of the boards have won. If one has, return it
(define (has-winner? board-states)
  (for*/first ([(state idx) (in-indexed board-states)]
              [win win-states]
              #:when (= (bitwise-and state win) win))
    (list idx state)))

;; Calculate the score of the winning board
(define (score board state)
  (for/sum ([num board]
            [mask (map (curry arithmetic-shift 1) (range 25))]
            #:when (= (bitwise-and state mask) 0))
    num))

;; Set the bit at bit-idx for the element at idx in the list
(define (set-bit states idx bit-idx)
  (list-set states idx
            (bitwise-ior (list-ref states idx)
                         (arithmetic-shift 1 bit-idx))))

;; Call the numbers until one of the boards wins
(define (find-winner nums-called boards)
  (for*/fold ([states (build-list (length boards) (const 0))]
              [winner '(#f)]
              #:result winner)
             ([num-called nums-called]
              [(board idx) (in-indexed boards)])
    #:break (first winner)
    ;; If the number called matches a square on the board set the
    ;; bit for that square, then check for a winner.
    (if (member num-called board)
        (let ([new-states (set-bit states idx (index-of board num-called))])
          (values new-states (flatlist (has-winner? new-states) num-called)))
        (values states (flatlist winner num-called)))))

;; Oh yeah! It's bingo time!
(define (bingo-time data)
  (match-define (list nums-called boards) (prep-data data))
  (match-define (list winner-idx winner-state last-call)
    (find-winner nums-called boards))
  (* last-call (score (list-ref boards winner-idx) winner-state)))

(bingo-time sample_data)
(bingo-time input_data)
(count-deeper (file->string "sample-2021-01.txt"))
(count-deeper (file->string "input-2021-01.txt"))

