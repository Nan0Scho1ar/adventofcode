#lang racket

(define (file->string fname)
  (with-input-from-file fname (λ () (port->string))))
(provide file->string)

