
source common.sh
My_root_password=$1

Print_Task_Heading "Enable Default NodeJs version module"
dnf module disable nodejs -y &>>/tmp/expense.log
echo $?

Print_Task_Heading "enable NodeJs Version 20 module"
dnf module enable nodejs:20 -y &>>/tmp/expense.log
echo $?

Print_Task_Heading "Install nodeJs"
dnf install nodejs -y &>>/tmp/expense.log
echo $?

Print_Task_Heading "add application user"
useradd expense &>>/tmp/expense.log
echo $?

Print_Task_Heading "Copy Backend service"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log
echo $?


Print_Task_Heading "Clean old content"
rm -rf /app &>>/tmp/expense.log
echo $?

Print_Task_Heading "Create App directory"
mkdir /app &>>/tmp/expense.log
echo $?

Print_Task_Heading "Download App content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
echo $?

Print_Task_Heading "Extract App content"
cd /app &>>/tmp/expense.log
unzip /tmp/backend.zip &>>/tmp/expense.log
echo $?

Print_Task_Heading "Download NodeJs dependencies"
cd /app &>>/tmp/expense.log
npm install &>>/tmp/expense.log
echo $?

Print_Task_Heading "Start Backend service"
systemctl daemon-reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl start backend &>>/tmp/expense.log
echo $?



Print_Task_Heading "Install Mysql"
dnf install mysql -y &>>/tmp/expense.log
mysql -h 172.31.17.214  -uroot -p${My_root_password} < /app/schema/backend.sql &>>/tmp/expense.log
echo $?