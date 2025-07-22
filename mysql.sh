dnf install mysql-server -y &>>/tmp/expense.log

systemctl enable mysqld &>>/tmp/expense.log
systemctl start mysqld &>>/tmp/expense.log

sudo mysql_secure_installation --set-root-pass ExpenseApp@1 &>>/tmp/expense.log