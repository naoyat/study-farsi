(use gauche.test)
(require "./farsi-engine")

(test-start "LESSON")

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

;;
;; Lesson 6
;;
(test-section "第6課 - 本文")
(test* "AYA IN KTAB @ST ?" "これは本ですか？" (faTL->ja "AYA IN KTAB @ST ?"))
(test* "IN KTAB @ST ?" "これは本ですか？" (faTL->ja "IN KTAB @ST ?"))
(test* "AYA IN KTAB @ST ?" "これは本ですか？" (faTL->ja "AYA IN KTAB @ST ?"))
(test* "IN KTAB @ST ?" "これは本ですか？" (faTL->ja "IN KTAB @ST ?"))
(test* "AYA IN SG @ST ?" "これは犬ですか？" (faTL->ja "AYA IN SG @ST ?"))
(test* "BLH IN SG @ST" "はい、これは犬です。" (faTL->ja "BLH IN SG @ST"))
(test* "AYA IN GRBH @ST ?" "これは猫ですか？" (faTL->ja "AYA IN GRBH @ST ?"))
(test* "NKhYR IN GRBH NYST" "いいえ、これは猫ではありません。" (faTL->ja "NKhYR IN GRBH NYST"))
(test* "IN ChYST ?" "これは何ですか？" (faTL->ja "IN ChYST ?"))
(test* "INJA KJAST ?" "ここはどこですか？" (faTL->ja "INJA KJAST ?"))
(test* "AN ChYST ?" "あれは何ですか？" (faTL->ja "AN ChYST ?"))
(test* "AN TVT @ST" "あれは桑の実です。" (faTL->ja "AN TVT @ST"))
(test* "U KYST ?" "彼は誰ですか？" (faTL->ja "U KYST ?"))
(test* "U HSYN @ST" "彼はホセインです。" (faTL->ja "U HSYN @ST"))
(test* "INJA KJAST ?" "ここはどこですか？" (faTL->ja "INJA KJAST ?"))
(test* "INJA IRAN @ST" "ここはイランです。" (faTL->ja "INJA IRAN @ST"))

(test-section "第6課 - 練習")
(test* "1) AYA IN GL @ST ?" "これは花ですか？" (faTL->ja "AYA IN GL @ST ?"))
(test* "   BLH IN GL @ST" "はい、これは花です。" (faTL->ja "BLH IN GL @ST"))
(test* "2) AYA IN QLM @ST ?" "これはペンですか？" (faTL->ja "AYA IN QLM @ST ?"))
(test* "   NKhYR IN QLM NYST" "いいえ、これはペンではありません。" (faTL->ja "NKhYR IN QLM NYST"))
(test* "3) IN ChYST ?" "これは何ですか？" (faTL->ja "IN ChYST ?"))
(test* "   IN MYRz @ST" "これは机です。" (faTL->ja "IN MYRz @ST"))
(test* "4) AN ChYST ?" "あれは何ですか？" (faTL->ja "AN ChYST ?"))
(test* "   AN .SNDLY @ST" "あれはいすです。" (faTL->ja "AN .SNDLY @ST"))
(test* "5) INJA KJAST ?" "ここはどこですか？" (faTL->ja "INJA KJAST ?"))
(test* "   INJA RzhAPN @ST" "ここは日本です。" (faTL->ja "INJA RzhAPN @ST"))

(test-end)
