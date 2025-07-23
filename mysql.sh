source common.sh
#My_root_password=$1

Print_Task_Heading "Install MySQL server"
dnf install mysql-server -y &>>/tmp/expense.log
echo $?

Print_Task_Heading "Enable and Start MySQL server"
systemctl enable mysqld &>>/tmp/expense.log
systemctl start mysqld &>>/tmp/expense.log
echo $?

sudo mysql_secure_installation --set-root-pass ExpenseApp@1 &>>/tmp/expense.log