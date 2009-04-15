;
; faTL util
;
(define (faTL->uc str)
  (let loop ([s (string->list str)]
             [done '()]
             [first? #t])
    (if (null? s)
        (list->string (reverse! done))
        (let ([head (car s)]
              [rest (cdr s)])
          (define (followed-by? ch) (and (not (null? rest)) (eq? ch (car rest))))
          (define (followed-by2? ch) (and (not (null? rest))
                                          (not (null? (cdr rest)))
                                          (eq? ch (cadr rest))))
          (define (last?) (null? rest))
          (define (push-and-next uc) (loop rest (cons uc done) #f))
          (define (skip1-push-and-next uc) (loop (cdr rest) (cons uc done) #f))
          (define (skip2-push-and-next uc) (loop (cddr rest) (cons uc done) #f))
          (define (not-found) (loop rest done #f))
          (case head
            [(#\?) (push-and-next #\u061F)]
            [(#\`) (push-and-next #\u0639)]
            [(#\.)
             (cond [(last?) (not-found)]
                   [(followed-by? #\H)
                    (skip1-push-and-next #\u062D)] ;.H
                   [(followed-by? #\S)
                    (if (followed-by2? #\z)
                        (skip2-push-and-next #\u0636) ; dad .Sz (..Z)
                        (skip1-push-and-next #\u0635) ; sad .S
                        )]
                   [(followed-by? #\T)
                    (if (followed-by2? #\z)
                        (skip2-push-and-next #\u0638) ; zah .Tz (.Z)
                        (skip1-push-and-next #\u0637) ; tah .T
                        )]
                   )]
            [(#\@) (push-and-next #\u0627)] ;A
            [(#\A) ;(push-and-next #\u0622)] ;A~
             (if first?
                 (push-and-next #\u0622) ; A~
                 (push-and-next #\u0627) ; A
                 )]
            [(#\B) (push-and-next #\u0628)]
            [(#\C)
             (if (followed-by? #\h)
                 (skip1-push-and-next #\u0686) ;Ch
                 (not-found) ;C - not found
                 )]
            [(#\D)
             (if (followed-by? #\z)
                 (skip1-push-and-next #\u0630) ;Dz
                 (push-and-next #\u062F) ;D
                 )]
            [(#\F) (push-and-next #\u0641)]
            [(#\G)
             (if (followed-by? #\h)
                 (skip1-push-and-next #\u063A) ;Gh
                 (push-and-next #\u06AF) ;G
                 )]
            [(#\H) (push-and-next #\u0647)] ;H
            [(#\I)
             (if first?
                 (loop rest (cons #\u06CC (cons #\u0627 done)) #f) ; AY
                 (push-and-next #\u06CC) ; Y
                 )]
            [(#\J) (push-and-next #\u062C)]
            [(#\K)
             (if (followed-by? #\h)
                 (skip1-push-and-next #\u062E) ;Kh
                 (push-and-next #\u06A9) ;K
                 )]
            [(#\L) (push-and-next #\u0644)]
            [(#\M) (push-and-next #\u0645)]
            [(#\N) (push-and-next #\u0646)]
            [(#\P) (push-and-next #\u067E)]
            [(#\Q) (push-and-next #\u0642)]
            [(#\R)
             (if (followed-by? #\z)
                 (if (followed-by2? #\h)
                     (skip2-push-and-next #\u0698) ;Rzh
                     (skip1-push-and-next #\u0632) ;Rz
                     )
                 (loop rest (cons #\u0631 done) #f) ;R
                 )]
            [(#\S)
             (if (followed-by? #\h)
                 (skip1-push-and-next #\u0634) ;Sh
                 (push-and-next #\u0633) ;S
                 )]
            [(#\T)
             (if (followed-by? #\h)
                 (skip1-push-and-next #\u062B) ;theh (s)
                 (push-and-next #\u062A) ;teh
                 )]
            [(#\U) ; for AV
             (if first?
                 (loop rest (cons #\u0648 (cons #\u0627 done)) #f) ; AV
                 (push-and-next #\u0648) ; V
                 )]
            [(#\V) (push-and-next #\u0648)]
            [(#\Y) (push-and-next #\u06CC)]
            [else (push-and-next head)])
          ))))

(define (uc->faTL str)
  (let loop ([s (string->list str)]
             [done '()]
             [last-char #\space])
    (if (null? s)
        (string-join (reverse! done) "")
        (let ([head (car s)]
              [rest (cdr s)])
          (define (followed-by? ch) (and (not (null? rest)) (eq? ch (car rest))))
          (define (first?) (eq? last-char #\space))
          (define (last?) (null? rest))

          (define (push-and-next uc) (loop rest (cons uc done) head))
          (define (skip1-push-and-next uc) (loop (cdr rest) (cons uc done) head))

          (define (alef? ch) (or (eq? #\u0622 ch) (eq? #\u0627 ch)))

          (case head
            [(#\u061f) (push-and-next "?")]
            [(#\u0622) (push-and-next "A")]  ;alef + madda
            [(#\u0627)
             (cond [(and (last?) (not (first?))) (push-and-next "A")] ;alef
                   [(or (followed-by? #\u06CC) (followed-by? #\u064A)) (skip1-push-and-next "I")]
                   [(followed-by? #\u0648) (skip1-push-and-next "U")]
                   [(first?) (push-and-next "@")]
                   [else (push-and-next "A")]
                   )]
            [(#\u0628) (push-and-next "B")]   ;beh
            [(#\u0686) (push-and-next "Ch")]  ;tcheh
            [(#\u062F) (push-and-next "D")]   ;dal
            [(#\u0630) (push-and-next "Dz")]  ;thal
            [(#\u0641) (push-and-next "F")]   ;feh
            [(#\u06AF) (push-and-next "G")]   ;gaf ;FARSI 06AF
            [(#\u063A) (push-and-next "Gh")]  ;ghain
            [(#\u0647) (push-and-next "H")]   ;heh
            [(#\u062D) (push-and-next ".H")]  ;hah
            [(#\u062C) (push-and-next "J")]   ;jeem
            [(#\u06A9 #\u0643) (push-and-next "K")] ;keheh | kaf
            [(#\u062E) (push-and-next "Kh")]  ;khah
            [(#\u0644) (push-and-next "L")]   ;lam
            [(#\u0645) (push-and-next "M")]   ;meem
            [(#\u0646) (push-and-next "N")]   ;noon
            [(#\u067E) (push-and-next "P")]   ;peh FARSI 067E <Persian, Urdu, ...>
            [(#\u0642) (push-and-next "Q")]   ;qaf - pronounced like ghain
            [(#\u0631) (push-and-next "R")]   ;reh
            [(#\u0632) (push-and-next "Rz")]  ;zain
            [(#\u0698) (push-and-next "Rzh")] ;zh - jeh
            [(#\u0633) (push-and-next "S")]   ;seen
            [(#\u0634) (push-and-next "Sh")]  ;sheen
            [(#\u0635) (push-and-next ".S")]  ;sad
            [(#\u0636) (push-and-next ".Sz")] ;dad ..Z ;ẕ
            [(#\u062A) (push-and-next "T")]   ;teh
            [(#\u062B) (push-and-next "Th")]  ;theh
            [(#\u0637) (push-and-next ".T")]  ;tah
            [(#\u0638) (push-and-next ".Tz")] ;zah .z
            [(#\u0639) (push-and-next "`")]   ;ain

            [(#\u0648) ; (push-and-next "V")]   ;waw
             (cond [(first?) (push-and-next "V")]
                   [(alef? last-char) (push-and-next "V")]
                   [else (push-and-next "U")])]

            [(#\u06CC #\u064A) ; (push-and-next "Y")] ; yeh ;FARSI 06CC <farsi-yeh>
             (cond [(first?) (push-and-next "Y")]
                   [(alef? last-char) (push-and-next "Y")]
                   [else (push-and-next "I")])]

            [(#\u066A) (push-and-next "%")] ; % percent sign (0025)
            [(#\u066D) (push-and-next "*")] ; * asterisk (002A)
            [(#\u064E) (push-and-next "a")]   ;fatha
            [(#\u064F) (push-and-next "o")]   ;damma
            [(#\u0650) (push-and-next "e")]   ;kasra
            [(#\u0660 #\u06F0) (push-and-next "0")]
            [(#\u0661 #\u06F1) (push-and-next "1")]
            [(#\u0662 #\u06F2) (push-and-next "2")]
            [(#\u0663 #\u06F3) (push-and-next "3")]
            [(#\u0664 #\u06F4) (push-and-next "4")]
            [(#\u0665 #\u06F5) (push-and-next "5")]
            [(#\u0666 #\u06F6) (push-and-next "6")]
            [(#\u0667 #\u06F7) (push-and-next "7")]
            [(#\u0668 #\u06F8) (push-and-next "8")]
            [(#\u0669 #\u06F9) (push-and-next "9")]
            [(#\space)
             (loop rest (cons " " done) #\space)]
            (else (push-and-next (x->string head)))
            )))))
