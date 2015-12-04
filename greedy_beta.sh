#!/bin/bash

#
# Probable errors' answer: 
#     30,60  sed -> gsed; 
#      60     -r -> -E. 
# If this solutions doesn't solve problems, report to the *developer*. 
#

function random_line() {
   var1=25
   line="$((RANDOM%5+1))"  
   while [ $var1 != 0 ]
   do
      line="$line$((RANDOM%5+1))"
      var1=$((var1 - 1))
   done
   echo "$line\n"
}

function generator() {
   var2=14
   field="$(random_line)"
   while [ $var2 != 0 ]
   do
      field="$field$(random_line)"
      var2=$((var2 - 1))
   done

   field=`sed -e "
      1! G
      /$/ { 
         s/[1-9]/@/$((RANDOM%300+1)) 
      }
      " <<< "$field"`
  echo -e "$field"
   while true
   do
      read -s -n 1 ctrl
      case "${ctrl}" in
         k|w) dr=w;;
         h|a) dr=a;;
         j|s) dr=s;;
         l|d) dr=d;;
         q) dr=q;;
         e) dr=e;;
         z) dr=z;;
         c) dr=c;;
         g) dr=g;;
         *) dr=;;
      esac
      
      if [ -n "${dr}" ]
      then
         echo "${dr}"
      fi
   done
}

generator |  sed -r -n -f "greedy_beta.sed"
