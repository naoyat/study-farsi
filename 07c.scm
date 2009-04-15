(use srfi-1)
(use util.match)

(define dic '(
              ;第5課
;              ("AN"     "a:n"      pron (あ そ))
;              ("IN"     "i:n"      pron (こ))
              ("AN"     "a:n"      det (あれ それ)) ; 限定詞
              ("IN"     "i:n"      det (これ))

              ("@ST"    "ast"      be   (です))

              ("KTAB"   "keta:b"   n    (本))
              ("SG"     "sa:g"     n    (犬))
              ("MDAD"   "meda:d"   n    (鉛筆))
              ("@SB"    "asb"      n    (馬))
              ("DRKhT"  "derakht"  n    (木))
              ("KAGhDz" "ka:ghaz"  n    (紙))
              ("NAN"    "na:n"     n    (パン))
              ("AB"     "a:b"      n    (水))
              ("GL"     "gol"      n    (花))
              ("SIB"    "si:b"     n    (リンゴ))
              ("GRBH"   "gorbe"    n    (猫))

              ("BRzRG"  "bozorg"   adj  (大きい))
              ("KUChK"  "ku:chek"  adj  (小さい))
              ("SRD"    "sard"     adj  (冷たい 寒い))
              ("QShNG"  "ghashang" adj  (美しい))
              ("SFID"   "sefi:d"   adj  (白い))

              ;第6課
              ("AYA"     "a:ya:"    AYA   (？))
              ("?"       "?"        ?     (？))

              ("BLH"     "bale"     yn    (はい))
              ("NH KhIR" "na kheir" yn    (いいえ))
              ("NKhIR"   "nakheir"  yn    (いいえ))

              ("NIST"    "ni:st"    be    (ではありません))

              ("ChH"     "che"      qu    (何))
              ("ChIST"   "chi:st"   S     ("ChH" "@ST"))
              ("KI"      "ki:"      qu    (誰))
              ("KIST"    "ki:st"    S     ("KI" "@ST"))
              ("KJA"     "koja:"    qu    (どこ))
              ("KJAST"   "koja:st"  S     ("KJA" "@ST"))

              ("INJA"    "i:nja:"   pron  (ここ))
              ("U"       "u:"       pron  (彼 彼女))

              ("JA"      "ja:"      n     (場所))
              ("TUT"     "tu:t"     n     (桑の実))
              ("HSIN"    "hosein"   prop  (ホセイン {人名,男}))
              ("IRAN"    "i:ra:n"   prop  (イラン))
              ("QLM"     "ghalam"   n     (ペン))
              ("MIRz"    "mi:z"     n     (机))
              (".SNDLI"  "sandali:" n     (椅子))
              ("RzhAPN"  "zha:pon"  n     (日本))

              ;第7課
              ("SRKh"    "sorkh"     adj  (赤い))
              ("PIR"     "pi:r"      adj  (年老いた))
              ("NU"      "nou"       adj  (新しい))
              ("BLND"    "boland"    adj  (長い))

              ("PDR"     "pedar"     n    (父))
              ("MADR"    "ma:dar"    n    (母))

              ("MN"      "man"       pron (私))
              ("MA"      "ma:"       pron (私たち))
              ("ShMA"    "shoma:"    pron (あなた あなたがた))

              ("MRD"     "mard"      n    (男の人))
              ("RzN"     "zan"       n    (女の人))

              ("RAST"    "ra:st"     adj  (右 正しい))
              ("ChP"     "chap"      adj  (左))

              ("DST"     "dast"      n    (手))
              ("PA"      "pa:"       n    (足))
              ("MU"      "mu:"       n    (髪))
              ("BChChH"  "bachche"   n    (子供))
              ("BChH"    "bachche"   n    (子供))
              ("@SM"     "esm"       n    (名前))

              ("AQA"     "a:gha:"    n    (_氏 _さん))
              ("KhANM"   "kha:nom"   n    (_夫人 _さん 婦人))
              ("KASB"    "ka:seb"    n    (商人))
              ("BNDR"    "bandar"    n    (_港))
              ("RUD"     "ru:d"      n    (_川))
              ("KUH"     "ku:h"      n    (_山))
              ("ShHR"    "shahr"     n    (_市 町))

              ("V"       "va"        conj (そして _と)); "va" | "o"

              ("NADR"    "na:der"    prop (ナーデル {人名,男}))
              ("HSN"     "hasan"     prop (ハサン {人名,男}))
              ("@FShAR"  "afsha:r"   prop (アフシャール {人名}))
			  ("RJBRzADH" "rajabza:de" prop (ラジャブザーデ {人名}))
              ("`BBAS"   "abba:s"    prop (アッバース {人名,男}))
              ("`BAS"   "abba:s"     prop (アッバース {人名,男}))
              ("KARUN"   "ka:ru:n"   prop (カールーン {川}))
              ("DMAUND"  "dama:vand" prop (ダマーヴァンド {山}))
              ("THRAN"   "tehra:n"   prop (テヘラン))
              ))

(define (string-rtrim-n str n)
  (let1 len (string-length str)
    (if (< len n) str (substring str 0 (- len n)))))

(define (lookup-words dic words)
  ;; 辞書{dic}からの単純なルックアップ
  (define (lookup word)
    (let1 it (assoc word dic)
      (if it (cddr it) #f)))

  (let loop ([rest words] [result '()])
    (define (push-and-next trans)
      (loop (cdr rest) (cons trans result)))
    (define (push2-and-next t1 t2)
      (loop (cdr rest) (cons t2 (cons t1 result))))
    (define (not-found word)
      (push-and-next (list '? (list (string-append "%(" word ")%"))) ))

    (if (null? rest) (reverse! result)
        (let* ([head (car rest)]
               [trans (lookup head)])
          (cond [(not trans) ; not found
                 (cond [(#/ST$/ head)
                        (let1 tmp (lookup (string-rtrim-n head 2))
                          (if tmp
                              (push2-and-next tmp (lookup "@ST"))
                              (not-found head) ))]
                       [(#/-[Yy]?e$/ head)
                        (cond [(#/-Ye$/ head)
                               (let* ([body (string-rtrim-n head 3)]
                                      [body+Y (string-append body "I")])
                                 (let1 t1 (lookup body+Y)
                                   (if t1 
                                       (push-and-next (ezafe t1))
                                       (let1 t2 (lookup body)
                                         (if t2
                                             (push-and-next (ezafe t2))
                                             (not-found head) )))))]
                              [(#/-ye$/ head)
                               (push-and-next (ezafe (lookup (string-rtrim-n head 3))))]
                              [(#/-e$/ head)
                               (push-and-next (ezafe (lookup (string-rtrim-n head 2))))]
                              [else (not-found head)])]
                       )]
                [(eq? 'S (car trans))
                 (loop (cdr rest) (append (reverse! (map lookup (cadr trans))) result))]
                [else
                 (push-and-next trans)]
                )
          ))))

;(define (symbol-append . symbols)
;  (string->symbol (string-join (map symbol->string symbols) "")))

(define (nom->gen nom)
  (case (string->symbol nom)
    ((あれ) "あの")
    ((これ) "この")
    ((それ) "その")
    ((どれ) "どの")
    (else (string-append nom "の"))
    ))

;
; modify
;
(define (tagged? tag obj) (and (pair? obj) (eq? tag (car obj))))

(define (modified? obj) (tagged? 'modified obj))
(define (modified-body obj)
  (if (modified? obj)
      (second obj)
      obj))
(define (modified-modifiers obj)
  (if (modified? obj)
      (third obj)
      '()))
(define (modify obj . modifiers)
  (if (modified? obj)
      (list 'modified (modified-body obj) (append modifiers (modified-modifiers obj)))
      (list 'modified obj modifiers)))

(unless #t
(use gauche.test)
(test-start "modify")
(define o0 'hair)
(test* "modified?" #f (modified? o0))
(test* "modified-body" 'hair (modified-body o0))
(test* "modified-modifiers" '() (modified-modifiers o0))
(define o1 (modify o0 'blond))
(test* "modified?" #t (modified? o1))
(test* "modified-body" 'hair (modified-body o1))
(test* "modified-modifiers" '(blond) (modified-modifiers o1))
(define o2 (modify o1 'long))
(test* "modified?" #t (modified? o2))
(test* "modified-body" 'hair (modified-body o2))
(test* "modified-modifiers" '(long blond) (modified-modifiers o2))
(test-end)
)

(define (pos obj) ; 品詞
  (if (modified? obj)
      (pos (modified-body obj))
      (car obj)))

(define (surface obj) ;表層形
  (if (modified? obj)
      (let1 body (surface (modified-body obj))
        (string-append
         (string-join
          (map (lambda (x) (case (pos x)
                             [(n pron) (string-append (surface x) "の")]
                             [(prop) (if (#/^_/ body)
                                         (surface x)
                                         (string-append (surface x) "の"))]
                             [(adj) (surface x)]
                             [(det) (nom->gen (surface x))]
                             [else (string-append (surface x) "-")]))
               (modified-modifiers obj))
          "")
         (if (#/^_/ body)
             (substring body 1 -1); (string-length body))
             body)))
      (symbol->string (car (second obj)))))

(define (ezafe obj)
  (cons 'ezafe obj))
(define (ezafe? obj) (tagged? 'ezafe obj))
(define (ezafe-body obj)
  (if (ezafe? obj) (cdr obj) obj))
;;

;a b Ec Ed e f = a b (c- d- e) f
;              = f (e -d -c) b a
(define (resolve-ezafe objs)
  (let loop ([rest objs]
             [curr-obj #f]
             [past '()])
    (if (null? rest)
        (reverse! (if curr-obj (cons curr-obj past) past))
        (let1 head (car rest)
          (if curr-obj
              (if (ezafe? head)
                  ;; (... ezafe) ezafe
                  (loop (cdr rest) (modify curr-obj (ezafe-body head)) past)
                  ;; (... ezafe) -
                  (if (eq? 'det (pos head))
                      (loop (cddr rest) #f (cons (modify curr-obj (modify (cadr rest) head)) past))
                      (loop (cdr rest) #f (cons (modify curr-obj head) past))
                      ))
              (if (ezafe? head)
                  ;; #f ezafe
                  (loop (cdr rest) (ezafe-body head) past)
                  ;; #f -
                  (loop (cdr rest) #f (cons head past))
                  ))))))

(define (faTL->ja** text)
  (let* ([words (string-split text " ")]
         [trans (lookup-words dic words)]
;         [X (print "trans: " trans)]
         [trans* (resolve-ezafe trans)]
;         [Y (print "trans*: " trans*)]
         )
    (map (lambda (t)
           (if (modified? t)
               (format "+ ~a : ~a : ~a" (pos t) (modified-body t) (modified-modifiers t))
               (format "- ~a : ~a" (pos t) t)
               ))
         trans*)
    ))

(define (faTL->ja text)
  (let* ([words (string-split text " ")]
         [trans (resolve-ezafe (lookup-words dic words))])
    (let ([pos-l (map pos trans)]  ; (pron n be)
          [ja (map surface trans)])
      (match pos-l
        ;; lesson 5
        [('det 'n 'be)
         (format "~aは~aです。" (first ja) (second ja))]
        [('det 'n 'adj 'be)
         (format "~a~aは~a。" (nom->gen (first ja)) (second ja) (third ja))]
        ;; lesson 6
        [('AYA 'det 'n 'be '?)
         (format "~aは~aですか？" (second ja) (third ja))]
        [('det (or 'n 'adj) 'be '?)
         (format "~aは~aですか？" (first ja) (second ja))]
        [('yn 'det 'n 'be)
         (format "~a、~aは~a~a。" (first ja) (second ja) (third ja) (fourth ja))]
        [((or 'det 'pron) 'qu 'be '?)
         (format "~aは~aですか？" (first ja) (second ja))]
        [((or 'n 'pron) (or 'n 'prop) 'be)
         (format "~aは~aです。" (first ja) (second ja))]
        ;; lesson 7
        [((or 'n 'prop))
         (first ja)]
        [((or 'n 'pron) 'adj 'be)
         (format "~aは~a。" (first ja) (second ja))]
        [('det 'n 'n 'be)
         (format "~a~aは~aです。" (nom->gen (first ja)) (second ja) (third ja))]
        [('n 'qu 'be '?)
         (format "~aは~aですか？" (first ja) (second ja))]
        [('det 'n 'qu 'be '?)
         (format "~a~aは~aですか？" (nom->gen (first ja)) (second ja) (third ja))]
        [('n 'conj 'n)
         (format "~aと~a" (first ja) (third ja))]
        [else
         (format "> ~a : ~a" pos-l ja)]);match
      )))

;;
;; TEST
;;
(use gauche.test)
(test-start "第７課")
(require "./lesson5-test")
(require "./lesson6-test")
(require "./lesson7-test")
(test-end)
