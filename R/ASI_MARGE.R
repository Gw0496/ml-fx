# 読み込んだcsvをマージする
setwd("D:\\umezaki\\R")             # 作業ディレクトリを変更する
getwd()                     # 現在の作業ディレクトリを確認する# 複数のデータファイルを一括してリストに読み込む

table_all <- data.frame()

# 読み込んだcsvをマージする
table_ashi1 <- read.table("ashi1.csv", header=F, sep=",")
table_ashi5 <- read.table("ashi5.csv", header=F, sep=",")
i5 <- 0
i1 <- 0
for(i1 in 1:6){
  line_ashi1 <- table_ashi1[c(i1), ]
  line_ashi1f <- table_ashi1[c(i1+1), ]
  mod_temp <- i1 %% 5
  if (mod_temp == 1) {
    i5 <- i5 + 1
    line_ashi5 <- table_ashi5[c(i5), ]
    line_ashi5f <- table_ashi5[c(i5+1), ]
  }
  line_all <- data.frame(line_ashi1, line_ashi5,line_ashi1f, line_ashi5f)
  table_all <- rbind(table_all,line_all)
  i1 <- i1 + 1
}
write.table(table_all, "output.txt", quote=F,col.names=F, append=T)

