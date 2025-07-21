dnf install mysql-server -y

systemctl enable mysqld
systemctl start mysqld

sudo mysql_secure_installation --set-root-pass ExpenseApp@1