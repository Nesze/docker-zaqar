sed s/MONGO/$MONGO/g zaqar_sample.config | tee zaqar.config 

docker build -t nesze/zaqar .

