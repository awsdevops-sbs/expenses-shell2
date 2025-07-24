
source common.sh
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
useradd expense &>>$Log
Check_Status $?

Print_Task_Heading "Copy Backend service"
cp backend.service /etc/systemd/system/backend.service &>>$Log
Check_Status $?


Print_Task_Heading "Clean old content"
rm -rf /app &>>$Log
Check_Status $?

Print_Task_Heading "Create App directory"
mkdir /app &>>$Log
Check_Status $?

Print_Task_Heading "Download App content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>$Log
Check_Status $?

Print_Task_Heading "Extract App content"
cd /app &>>$Log
unzip /tmp/backend.zip &>>$Log
Check_Status $?

Print_Task_Heading "Download NodeJs dependencies"
cd /app &>>$Log
npm install &>>$Log
Check_Status $?

Print_Task_Heading "Start Backend service"
systemctl daemon-reload &>>$Log
systemctl enable backend &>>$Log
systemctl start backend &>>$Log
Check_Status $?



Print_Task_Heading "Install Mysql"
dnf install mysql -y &>>$Log
mysql -h 172.31.17.214  -uroot -p${My_root_password} < /app/schema/backend.sql &>>$Log
Check_Status $?