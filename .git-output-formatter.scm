#!/usr/bin/mzscheme
#lang scheme

(require scheme/system)


(system (format "meld ~a ~a"
                (vector-ref (current-command-line-arguments) 1)
                (vector-ref (current-command-line-arguments) 4)))