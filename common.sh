
Log=/tmp/expense.log

Print_Task_Heading(){
  echo $1
  echo "####################$1##################" &>>$Log
    }

    Check_Status(){

   if [ $1 -eq 0 ]; then
      echo -e "\e[32mSUCCESS\e[0m"
      else
        echo -e "\e[31mFAILURE\e[0m"
      exit 2
    fi
    }


    App_PreReq(){


      Print_Task_Heading "Clean old content"
      rm -rf ${appdir} &>>$Log
      Check_Status $?

      Print_Task_Heading "Create App directory"
      mkdir ${appdir} &>>$Log
      Check_Status $?

      Print_Task_Heading "Download App content"
      curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-${component}-v2.zip &>>$Log
      Check_Status $?

      Print_Task_Heading "Extract App content"
      cd ${appdir} &>>$Log
      unzip /tmp/${component}.zip &>>$Log
      Check_Status $?


    }