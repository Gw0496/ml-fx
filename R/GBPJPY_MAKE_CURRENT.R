# V3 未来値を投入データ、教師データそれぞれから除外する
# 現在値データは経過時間に適合したリアルな内容とする
# 読み込んだcsvをマージする
setwd("D:\\Test_ORJ\\data")             # 作業ディレクトリを変更する
getwd()                     # 現在の作業ディレクトリを確認する# 複数のデータファイルを一括してリストに読み込む

tableall <- data.frame()

# 読み込んだcsvをマージする
table_ashi15 <- read.table("GBPJPY15.csv", header=F, sep=",")
nrow_ashi15   <- nrow(table_ashi15)
i15 <- 0
hajimene60 <- 0
takane60 <- 0
yasune60 <- 999
owarine60 <- 0
hajimene24 <- 0
takane24 <- 0
yasune24 <- 999
owarine24 <- 0
# # 空行テーブル
line_ashi_empty=data.frame("","",0,0,0,0,0)
names(line_ashi_empty) <- c("V1","V2","V3","V4","V5","V6","V7")
for(i15 in 1:nrow_ashi15){

  line_ashi15 <- table_ashi15[c(i15), ]
  hajimene60 <- if(hajimene60 == 0){line_ashi15[1,3]}else{hajimene60}
  takane60 <- if(takane60 < line_ashi15[1,4]){line_ashi15[1,4]}else{takane60}
  yasune60 <- if(yasune60 > line_ashi15[1,5]){line_ashi15[1,5]}else{yasune60}
  owarine60 <- line_ashi15[1,6]
  hajimene24 <- if(hajimene24 == 0){line_ashi15[1,3]}else{hajimene24}
  takane24 <- if(takane24 < line_ashi15[1,4]){line_ashi15[1,4]}else{takane24}
  yasune24 <- if(yasune24 > line_ashi15[1,5]){line_ashi15[1,5]}else{yasune24}
  owarine24 <- line_ashi15[1,6]
  
  #列の追加
  lineall <- line_ashi15
  lineall$v60h<-hajimene60
  lineall$v60t<-takane60
  lineall$v60y<-yasune60
  lineall$v60o<-owarine60
  lineall$v24h<-hajimene24
  lineall$v24t<-takane24
  lineall$v24y<-yasune24
  lineall$v24o<-owarine24

  tableall <- rbind(tableall,lineall)
  
  mod_temp <- i15 %% 4
  if (mod_temp == 0) {
    hajimene60 <- 0
    takane60 <- 0
    yasune60 <- 0
    owarine60 <- 0
  }
  mod_temp <- i15 %% 96
  if (mod_temp == 0) {
    hajimene24 <- 0
    takane24 <- 0
    yasune24 <- 0
    owarine24 <- 0
  }
  i15 <- i15 + 1
}
# write.table(table_all, "output.txt", quote=F,col.names=F, append=F,row.names=F)
write.csv(tableall, "GBPJPY_CURRENT.csv", quote=F,row.names=F)

