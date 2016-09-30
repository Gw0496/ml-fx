# 読み込んだcsvをマージする
setwd("D:\\Test_ORJ\\data")             # 作業ディレクトリを変更する
getwd()                     # 現在の作業ディレクトリを確認する# 複数のデータファイルを一括してリストに読み込む

table_all <- data.frame()

# 読み込んだcsvをマージする
table_ashi15 <- read.table("GBPJPY15.csv", header=F, sep=",")
table_ashi60 <- read.table("GBPJPY60.csv", header=F, sep=",")
table_ashi1440 <- read.table("GBPJPY1440.csv", header=F, sep=",")
nrow_ashi15   <- nrow(table_ashi15)
nrow_ashi60   <- nrow(table_ashi60)
nrow_ashi1440 <- nrow(table_ashi1440)
i15 <- 0
i60 <- 0
i1440 <- 0
# # 空行テーブル
line_ashi_empty=data.frame("","",0,0,0,0,0)
names(line_ashi_empty) <- c("V1","V2","V3","V4","V5","V6","V7")
# b 前 a 未来
for(i15 in 1:nrow_ashi15){
  line_ashi15   <- if(i15>0){ table_ashi15[c(i15), ]} else {line_ashi_empty}
  line_ashi15b3 <- if(i15-3>0){ table_ashi15[c(i15-3), ]} else {line_ashi_empty}
  line_ashi15b2 <- if(i15-2>0){ table_ashi15[c(i15-2), ]} else {line_ashi_empty}
  line_ashi15b1 <- if(i15-1>0){ table_ashi15[c(i15-1), ]} else {line_ashi_empty}
  line_ashi15a1 <- if(i15 != nrow_ashi15){ table_ashi15[c(i15+1), ]} else {line_ashi_empty}
  mod_temp <- i15 %% 4
  if (mod_temp == 1) {
    i60 <- i60 + 1
    line_ashi60   <- if(i60>0){ table_ashi60[c(i60), ]} else {line_ashi_empty}
    line_ashi60b3 <- if(i60-3>0){ table_ashi60[c(i60-3), ]} else {line_ashi_empty}
    line_ashi60b2 <- if(i60-2>0){ table_ashi60[c(i60-2), ]} else {line_ashi_empty}
    line_ashi60b1 <- if(i60-1>0){ table_ashi60[c(i60-1), ]} else {line_ashi_empty}
    line_ashi60a1 <- if(i60 != nrow_ashi60){ table_ashi60[c(i60+1), ]} else {line_ashi_empty}
  }
  mod_temp <- i15 %% 96
  if (mod_temp == 1) {
    i1440 <- i1440 + 1
    line_ashi1440   <- if(i1440>0){ table_ashi1440[c(i1440), ]} else {line_ashi_empty}
    line_ashi1440b3 <- if(i1440-3>0){ table_ashi1440[c(i1440-3), ]} else {line_ashi_empty}
    line_ashi1440b2 <- if(i1440-2>0){ table_ashi1440[c(i1440-2), ]} else {line_ashi_empty}
    line_ashi1440b1 <- if(i1440-1>0){ table_ashi1440[c(i1440-1), ]} else {line_ashi_empty}
    line_ashi1440a1 <- if(i1440 != nrow_ashi1440){ table_ashi1440[c(i1440+1), ]} else {line_ashi_empty}
  }
  line_all <- data.frame(line_ashi15b3,line_ashi15b2,line_ashi15b1, line_ashi15,line_ashi15a1,
                         line_ashi60b3,line_ashi60b2,line_ashi60b1, line_ashi60,line_ashi60a1,
                         line_ashi1440b3,line_ashi1440b2,line_ashi1440b1, line_ashi1440,line_ashi1440a1)
  table_all <- rbind(table_all,line_all)
  i15 <- i15 + 1
}
# write.table(table_all, "output.txt", quote=F,col.names=F, append=F,row.names=F)
write.csv(table_all, "output.txt", quote=F,row.names=F)

