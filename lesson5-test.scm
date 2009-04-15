;;
;; Lesson 5
;;
(define-macro (faTL->ja-test cap faTL ja)
  `(test* ,(string-append cap faTL) ,ja (faTL->ja ,faTL)))

(test-section "第5課:本文")
(faTL->ja-test "" "AN KTAB @ST" "あれは本です。")
(faTL->ja-test "" "IN KTAB @ST" "これは本です。")
(faTL->ja-test "" "IN KTAB BRzRG @ST" "この本は大きい。")
(faTL->ja-test "" "AN SG KUChK @ST" "あの犬は小さい。")

(test-section "第5課:練習")
(faTL->ja-test "1) " "AN MDAD @ST" "あれは鉛筆です。")
(faTL->ja-test "2) " "IN @SB @ST" "これは馬です。")
(faTL->ja-test "3) " "AN DRKhT @ST" "あれは木です。")
(faTL->ja-test "4) " "IN KAGhDz @ST" "これは紙です。")
(faTL->ja-test "5) " "AN NAN @ST" "あれはパンです。")
(faTL->ja-test "6) " "IN AB SRD @ST" "この水は冷たい。")
(faTL->ja-test "7) " "AN GL QShNG @ST" "あの花は美しい。")
(faTL->ja-test "8) " "IN SIB BRzRG @ST" "このリンゴは大きい。")
(faTL->ja-test "9) " "IN GRBH KUChK @ST" "この猫は小さい。")
(faTL->ja-test "10) " "AN KAGhDz SFID @ST" "あの紙は白い。")
