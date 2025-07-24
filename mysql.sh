source common.sh
My_root_password=$1

if [ -z "${My_root_password}" ]; then

  echo -e "\e[31mInput Password Missing\e[0m".
  exit 1
fi

Print_Task_Heading "Install MySQL server"
dnf install mysql-server -y &>>$Log
Check_Status $?

Print_Task_Heading "Enable and Start MySQL server"
systemctl enable mysqld &>>$Log
systemctl start mysqld &>>$Log
Check_Status $?

Print_Task_Heading "Setup MySql password"
echo 'show databases' | mysql -h ${mysql-dev.awsdevops.sbs} -uroot -p${My_root_password} &>>$Log
if [ $? -ne 0 ]; then
sudo mysql_secure_installation --set-root-pass ${My_root_password} &>>$Log

fi

Check_Status $?