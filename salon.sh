#! /bin/bash


PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"


#sql request appointments
SERVICE=$($PSQL "SELECT service_id, name FROM services")

#select service
SERVICES_MENU() {
  echo $SERVICE | sed -r -e "s/ /\n/g" | sed -r -e "s/\|/) /g" 
  read SERVICE_ID_SELECTED

if [[ $SERVICE_ID_SELECTED < 4 ]]
then
  echo "In order to book, please provide your phone number."
  read CUSTOMER_PHONE

  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo "What is your name?"
    read CUSTOMER_NAME
    CUSTOMER_INSERT_RESULT=$($PSQL "INSERT INTO customers (phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  echo $CUSTOMER_ID

  echo "What time today would you like to book your appointment for?"
  read SERVICE_TIME
  TIME_INSERT_RESULT=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, '$SERVICE_ID_SELECTED', '$SERVICE_TIME')")

  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

  echo "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  
else
  SERVICES_MENU "Sorry, that's not available."
fi


if [[ $1 ]]
then
  echo TEST
fi
  

#if [[ $SELECTED_SERVICE is not a number ]]
#then
  #echo FAIL
#fi

}

  #if not valid,
  #go main menu
#enter phone number
  #sql Select customer_id where phone = '$phone'
  #if [[ -z $phone ]]
  #then
    #as for name
    #enter customer into database
#insert booked appointment into appointments

SERVICES_MENU
