#!/bin/bash
# Bash script to calculates the MAX, MIN, MEDIAN and MEAN of the word frequencies in the
# file the  http://www.gutenberg.org/files/58785/58785-0.txt

# Jeff Smolinski
# 9/29/2020
# homework 3


if [ $# -ne 1 ]
   then
       echo "Please provide a txt file url"
       echo "USAGE ./calculate_basic_stats.sh  url"
       echo "http://www.gutenberg.org/files/58785/58785-0.txt" 
       echo "----------------------------------"
       #exit with error

       #echo $1
       exit 1
fi   

echo  "############### Statistics for file  ############### "

echo "Positional Parameters"

if [ "$1" != "" ]; then
    echo "Parameter 1 contains something"
    echo "-------" 

    echo "Q1 ----"
    echo '$1 = ' $1
    echo "-------" 

    echo "Q2 ----"
    sorted_words=$(curl -s $1|tr [A-Z] [a-z]|grep -oE "\w+"|sort |uniq -c|sort -k1n -k2,1 -r )
    #echo "$sorted_words" | sed -n '1,10p;'
    
    #echo "$sorted_words" | awk '$2 ~ /^[- 0-9]+$/ {print NR, $1, $2}' 
    
    total_uniq_words=$( echo "$sorted_words" |wc -l ) 
    echo "Total number of words = $total_uniq_words"
    echo "-------" 

    # Q3
    echo "Q3 ----"
    echo "Min frequency and word is: $( echo "$sorted_words" | head -n 1 )"
    echo "Max frequency and word is: $( echo "$sorted_words" | tail -n 1 )"
    echo "-------" 

    # Q4
    echo "Q4 ----"
    function get_median(){
      if [ $(($total_uniq_words % 2)) -eq 0 ]
      then
        mid1=$(( $total_uniq_words / 2))
        mid2=$(( ($total_uniq_words / 2) + 1))
        #echo "$mid"
        echo "median low $( echo "$sorted_words" | sed -n "${mid1}p" )"
        echo "median high $( echo "$sorted_words" | sed -n "${mid2}p" )"
        echo "median value" $(( ($mid1+$mid2) /2))
        
      else
        mid=$(( ($total_uniq_words / 2) + 1))
        #echo "$mid"
        echo "median $( echo "$sorted_words" | sed -n "${mid}p" )"
      fi
    }
    get_median


    function get_mean(){
      total_freq=0
      count_=0
      
      echo "------ ~ 12 unit delay-------"
      while read -r var1
      do
        test=$(($count_ % 1000))
        #echo "$test"
        if [ $test -eq 0 ]
        then
          echo "------ "$((($count_ / 1000)+1))
        fi
        #$count_=$(( $(cat bash_is_trash.txt) + 1))
        count_=$(($count_ + 1))
        ((++$count_))
        #field1="$( echo "$var1"| awk '{print $1}' )"
        field1="$( echo "$var1" | cut -d' ' -f 1 )"
        #echo "$field1"
        #echo "$field1"
        #total_freq
        #echo $field1
        #echo "$total_freq"
        total_freq="$(($total_freq + $field1))"
      done < <(printf '%s\n' "$sorted_words")


      # Q5 Q6
      echo "Q5 ----"
      echo "Count $count_"
      echo "Q6 ----"
      echo 'Total '$total_freq
      echo "-------" 

      # Q7
      echo "Q7 ----"
      #tot=126825
      #cont=10980
      #my_mean="$(echo "$total_freq / $count_" | bc -l )"
      my_mean=$(echo "scale=0; ($total_freq / $count_) / 1" | bc -l )
      echo "Mean frequency using integer arithemetic = $my_mean"
      echo "-------" 
      echo "Q8 ----"
      my_mean=$(echo "scale=4; $total_freq / $count_" | bc -l )
      echo "Mean frequency using floating point arithemetic = $my_mean"

    }
    #get_mean
    

    

    function lazy_commit() {

      git add .
      git commit -m $1
      #eval $(ssh-agent -s)
      #ssh-add ~/.ssh/4447_git   # UNIX
      #ssh-add /mnt/c/wsl/4447_git    # PC
      
      git push origin master
      #exit 1
      #sleep 2
      
      #ssh-agent -k
      echo "`$message` has been added to origin."
    }
    #commit_message="lazy_test_9"
    message="lazy_test_13"
    #read -p 'Please enter a commit message: ' message
    lazy_commit $message



else
    echo "Positional parameter 1 is empty"
fi


#sorted_words='curl -s $1|tr [A-Z] [a-z]|grep -oE "\w+"|sort|uniq -c|sort  '





#$book_path = 'http://www.gutenberg.org/files/58785/58785-0.txt'

#echo $book_path

