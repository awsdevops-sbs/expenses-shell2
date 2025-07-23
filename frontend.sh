source common.sh

Print_Task_Heading "Install Nginx"
dnf install nginx -y &>>$Log
echo $?




Print_Task_Heading "Copy Expense Conf"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$Log
echo $?

Print_Task_Heading "Clean Old content"
rm -rf /usr/share/nginx/html/* &>>$Log
echo $?

Print_Task_Heading "Download Frontend Component"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>$Log
echo $?

Print_Task_Heading "Extract and unzip frontend component "
cd /usr/share/nginx/html &>>$Log
unzip /tmp/frontend.zip &>>$Log
echo $?

Print_Task_Heading "Start Nginx Service"
systemctl enable nginx &>>$Log
systemctl start nginx &>>$Log
systemctl restart nginx &>>$Log
echo $?


