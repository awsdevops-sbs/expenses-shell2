
source common.sh

appdir=/app

component=backend

My_root_password=$1

if [ -z "${My_root_password}" ]; then

  echo -e "\e[31mInput Password Missing\e[0m".
  exit 1
  fi

Print_Task_Heading "Enable Default NodeJs version module"
dnf module disable nodejs -y &>>$Log
Check_Status $?

Print_Task_Heading "enable NodeJs Version 20 module"
dnf module enable nodejs:20 -y &>>$Log
Check_Status $?

Print_Task_Heading "Install nodeJs"
dnf install nodejs -y &>>$Log
Check_Status $?

Print_Task_Heading "Add application user"

id expense &>>$Log

if [ $? -ne 0 ]; then
useradd expense &>>$Log

fi
Check_Status $?

Print_Task_Heading "Copy Backend service"
cp backend.service /etc/systemd/system/backend.service &>>$Log
Check_Status $?


App_PreReq

Print_Task_Heading "Download NodeJs dependencies"
cd /app &>>$Log
npm install &>>$Log
Check_Status $?

Print_Task_Heading "Start Backend service"
systemctl daemon-reload &>>$Log
systemctl enable backend &>>$Log
systemctl start backend &>>$Log
Check_Status $?



Print_Task_Heading "Install Mysql client"
dnf install mysql -y &>>$Log
Check_Status $?

Print_Task_Heading "Load Schema"
mysql -h mysql-dev.awsdevops.sbs   -uroot -p${My_root_password} < /app/schema/backend.sql &>>$Log
Check_Status $?