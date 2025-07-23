source common.sh

Print_Task_Heading "Install Nginx"
dnf install nginx -y &>>/tmp/expense.log
echo $?


Print_Task_Heading "Enable and start Nginx"
systemctl enable nginx &>>/tmp/expense.log
systemctl start nginx &>>/tmp/expense.log
echo $?

Print_Task_Heading "Copy Expense Conf"
cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/expense.log
echo $?

Print_Task_Heading "Remove previous App content"
rm -rf /usr/share/nginx/html/* &>>/tmp/expense.log
echo $?

Print_Task_Heading "Download Frontend Component"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/expense.log
echo $?

Print_Task_Heading "Extract and unzip frontend component "
cd /usr/share/nginx/html &>>/tmp/expense.log
unzip /tmp/frontend.zip &>>/tmp/expense.log
echo $?

Print_Task_Heading "Restart Nginx"
systemctl restart nginx &>>/tmp/expense.log
echo $?


