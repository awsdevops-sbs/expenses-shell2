source common.sh

appdir=/usr/share/nginx/html
component=frontend

Print_Task_Heading "Install Nginx"
dnf install nginx -y &>>$Log
Check_Status $?

Print_Task_Heading "Copy Expense Nginx Conf"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$Log
Check_Status $?

App_PreReq

Print_Task_Heading "Start Nginx Service"
systemctl enable nginx &>>$Log
systemctl restart nginx &>>$Log
Check_Status $?


