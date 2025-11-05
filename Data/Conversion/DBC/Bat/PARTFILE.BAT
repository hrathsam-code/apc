erase mspartfl.txo
erase mspartfl.isi
erase mspartfl.new
rename mspartfl.txt mspartfl.txo
reformat a:mspartfl.txt mspartfl.txt -l=285
index mspartfl.txt 2-21
reformat mspartfl.txt mspartfl.new -comp
cd ..
cd cc
cchelp
 

