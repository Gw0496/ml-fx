#source("http://noucobi.com/Rsource/tameshi.txt")
#install.packages("forecast", dependencies = TRUE)

setwd("D:\\ml-fx\\ml-fx\\data")             # 作業ディレクトリを変更する
getwd()                     # 現在の作業ディレクトリを確認する# 複数のデータファイルを一括してリストに読み込む

# data input
data <- read.table("forecast.csv", header=T, sep=",")
library(forecast)

# preprocessing
colnames(data) <- c("frequency", "horizon", "dates", "values")
data[[1,"dates"]]
#dates <- strsplit("1/15/2012;2/15/2012;3/15/2012;4/15/2012;5/15/2012;6/15/2012;7/15/2012;8/15/2012;9/15/2012;10/15/2012;11/15/2012;12/15/2012; 1/15/2013;2/15/2013;3/15/2013;4/15/2013;5/15/2013;6/15/2013;7/15/2013;8/15/2013;9/15/2013;10/15/2013;11/15/2013;12/15/2013; 1/15/2014;2/15/2014;3/15/2014;4/15/2014;5/15/2014;6/15/2014;7/15/2014;8/15/2014;9/15/2014", ";")
chr_datas= as.character(data[1,"dates"])
chr_values= as.character(data[1,"values"])

c_dates <- strsplit(chr_datas, ";")
c_values <- strsplit(chr_values, ";")

dates <- lapply(c_dates,as.Date,format = '%m/%d/%Y')
values <- lapply(c_values,as.numeric)

# fit a time-series model
train_ts<- ts(values, frequency=data$frequency)
class(train_ts)
fit1 <- auto.arima(train_ts)
train_model <- forecast(fit1, h = data$horizon)
plot(train_model)

# produce forecasting
train_pred <- round(train_model$mean,2)
data.forecast <- as.data.frame(t(train_pred))
colnames(data.forecast) <- paste("Forecast", 1:data$horizon, sep="")

# data output
maml.mapOutputPort("data.forecast");


a <- c(1, 3, 5)
a <- a + 1