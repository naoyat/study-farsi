(use gauche.test)
(require "./farsi-engine-1")

(test-start "第5課")

;;
;; Lesson 5
;;
(test-section "第5課 - 本文")
(test* "AN KTAB @ST" "あれは本です。" (faTL->ja "AN KTAB @ST"))
(test* "IN KTAB @ST" "これは本です。" (faTL->ja "IN KTAB @ST"))
(test* "IN KTAB BRzRG @ST" "この本は大きい。" (faTL->ja "IN KTAB BRzRG @ST"))
(test* "AN SG KVChK @ST" "あの犬は小さい。" (faTL->ja "AN SG KVChK @ST"))

(test-section "第5課 - 練習")
(test* "1) AN MDAD @ST" "あれは鉛筆です。" (faTL->ja "AN MDAD @ST"))
(test* "2) IN @SB @ST" "これは馬です。" (faTL->ja "IN @SB @ST"))
(test* "3) AN DRKhT @ST" "あれは木です。" (faTL->ja "AN DRKhT @ST"))
(test* "4) IN KAGhDz @ST" "これは紙です。" (faTL->ja "IN KAGhDz @ST"))
(test* "5) AN NAN @ST" "あれはパンです。" (faTL->ja "AN NAN @ST"))
(test* "6) IN AB SRD @ST" "この水は冷たい。" (faTL->ja "IN AB SRD @ST"))
(test* "7) AN GL QShNG @ST" "あの花は美しい。" (faTL->ja "AN GL QShNG @ST"))
(test* "8) IN SYB BRzRG @ST" "このリンゴは大きい。" (faTL->ja "IN SYB BRzRG @ST"))
(test* "9) IN GRBH KVChK @ST" "この猫は小さい。" (faTL->ja "IN GRBH KVChK @ST"))
(test* "10) AN KAGhDz SFYD @ST" "あの紙は白い。" (faTL->ja "AN KAGhDz SFYD @ST"))

(test-end)
