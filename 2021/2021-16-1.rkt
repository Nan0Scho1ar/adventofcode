#lang racket

(require rebellion/binary/bitstring)


(define sample1 "EE00D40C823060")
;; Becomes
(define bin-str-1   "11101110000000001101010000001100100000100011000001100000")
;;                   VVVTTTILLLLLLLLLLLAAAAAAAAAAABBBBBBBBBBBCCCCCCCCCCC
(define bin-str-1-2 "111 011 1 00000000011 0101000000 110010000010 00110000011 00000")
;;                   VVV TTT I LLLLLLLLLLL AAAAAAAAAA ABBBBBBBBBBB CCCCCCCCCCC Junk
(define bin-str-1-3 '(111 011 1 00000000011 0101000000 110010000010 00110000011))
;;                   VVV TTT I LLLLLLLLLLL AAAAAAAAAA ABBBBBBBBBBB CCCCCCCCCCC Junk
(define bin-str-1-4 (list  (bitstring 1 1 1)   ;; Packet version
                           (bitstring 0 1 1)   ;; Packet type (4 means literal) anything else is an operator
                           (bitstring 1)       ;; Subpacket length type (0 means next 15 bits are total combined length of subpackets)
                           ;; (1 means next 11 bits represent the total number of subpackets)
                           (bitstring 0 0 0 0 0 0 0 0 0 1 1)
                           ;; Length of subpackets
                           (bitstring 0 1 0 1 0 0 0 0 0 0)
                           (bitstring 1 1 0 0 1 0 0 0 0 0 1 0)
                           (bitstring 0 0 1 1 0 0 0 0 0 1 1)))





(define (bs-range bs start stop)
  (apply bitstring
         (for/list ([idx (range start (add1 stop))])
           (bitstring-ref bs idx))))

;; Big endian
;; TODO make this not crap
(define (bs->number bs)
  (for/sum
      ([b bs]
       [i (range (sub1 (bitstring-size bs)) -1 -1)])
    (* b (expt 2 i))))

(define (hex->bitstring str)
  (apply bitstring
         (flatten
          (for/list ([c str])
            (match c
              [#\0 '(0 0 0 0)]  [#\1 '(0 0 0 1)]
              [#\2 '(0 0 1 0)]  [#\3 '(0 0 1 1)]
              [#\4 '(0 1 0 0)]  [#\5 '(0 1 0 1)]
              [#\6 '(0 1 1 0)]  [#\7 '(0 1 1 1)]
              [#\8 '(1 0 0 0)]  [#\9 '(1 0 0 1)]
              [#\A '(1 0 1 0)]  [#\B '(1 0 1 1)]
              [#\C '(1 1 0 0)]  [#\D '(1 1 0 1)]
              [#\E '(1 1 1 0)]  [#\F '(1 1 1 1)])))))

(define (bs->str bs)
  (string-join (for/list ([bit (in-bitstring bs)])
                 (number->string bit)) " "))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define sample-bits (hex->bitstring sample1))
(define p-version (bs-range sample-bits 0 2))
(define p-type    (bs-range sample-bits 3 5))
(define s-l-type  (bitstring-ref sample-bits 6))
(define s-len-bits
  (if (= s-l-type 0)
      (bs-range sample-bits 7 (+ 7 14))
      (bs-range sample-bits 7 (+ 7 10))))
(define s-len (bs->number s-len-bits))
(define subpackets
  (if (= s-l-type 0)
      (bs-range sample-bits
                (+ 7 15)
                (+ 7 15 ))
      (bs-range sample-bits
                (+ 7 11)
                (+ 7 11 (* s-len 11)))))

(println sample-bits)

(displayln
 (string-join
  (list "(bitstring"
        (bs->str         p-version)
        (bs->str         p-type)
        (number->string  s-l-type)
        (bs->str         s-len-bits)
        (bs->str         subpackets)
        ")")
  " "))
;; test
