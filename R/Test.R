setwd("D:\\umezaki\\R")             # 作業ディレクトリを変更する
getwd()                     # 現在の作業ディレクトリを確認する# 複数のデータファイルを一括してリストに読み込む
fnames <- dir(pattern=".csv") # とすると、作業ディレクトリ内のcsvファイルのみを選んでくれる
# fnamesp <- choose.files() # ファイルを選ぶ。パスのベクトルが保存される。リストの要素名には使いづらい
csvlist <- lapply(fnames, read.csv)
names(csvlist) <- fnames
csvlist

# 読み込んだcsvをマージする
n <- length(csvlist)
temp <- csvlist[[1]]
for (i in 2:n) {
  temp <- merge(temp, csvlist[[i]], all=T)
}
res <- temp
res
# x <- matrix(1:8, ncol=2)                 # 4 * 2 の行列
# write(x, file="data12.txt")              # ファイル data12.txt に書き出し
x <- read.csv("a1.csv")
y <- read.csv("a2.csv")
z=data.frame(x, y)
line <- z[c(1), ]
z <- rbind(z,line)
z <- rbind(z,line)
z <- rbind(z,line)
# z[3,]=c(66,66,0,0,0,0,0)
write.table(z, "output.txt", quote=F,col.names=F, append=T)


#write("temp", file="data12.ctv",append=F)


# scan("data12.txt")   
