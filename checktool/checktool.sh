#!/bin/bash                                                                     
#engage.cpf確認                                                                 
engage_FILE="/opt/izumofs/jetty/engage.cpf"
if [ -e $engage_FILE ]; then
    echo "engage.cpf exists"
else
    echo "engage.cpf does not exist"
fi

#ログ領域                                                                       
log_FILE="/var/log/izumofs"
if df -h $log_FILE | grep 100%; then
    echo -e "ログ領域:\e[31mNG\e[m"
else
    echo "ログ領域:OK"
fi

#beta version                                                                   
if [[ $(yum info izumofs | grep beta48) ]]; then
    if [[ $(java -version 2>&1) == *"OpenJDK"* ]]; then
        echo "beta48(OpenJDK):OK"
    else
        echo -e "beta48(OracleJDK):\e[31mNG\e[m"
    fi
elif [[ $(yum info izumofs | grep beta47) ]]; then
    if [[ $(java -version 2>&1) == *"OpenJDK"* ]]; then
        echo -e "beta47(OpenJDK):\e[31mNG\e[m"
    else
        echo "beta47(OracleJDK):OK"
    fi
else
    if [[ $(java -version 2>&1) == *"OpenJDK"* ]]; then
        echo -e "beta47以前(OpenJDK):\e[31mNG\e[m"
    else
        echo "beta47以前(OracleJDK):OK"
    fi
fi

#Javaパス確認                                                                   
if [[ $(java -version 2>&1 | grep version) ]]; then
    if [[ $(jps) == *Jps* ]]; then
        jps_num=$(jps | grep Xml | awk '{print $1}')
        if [[ $(jstat -gc $jps_num | grep S0C) ]]; then
            echo "Javaパス:OK"
        else
            echo -e "Javaパス:\e[31mNG(jstat)\e[m"
        fi
    else
        echo -e "Javaパス:\e[31mNG(jps)\e[m"
    fi
else
    echo -e "Javaパス:\e[31mNG(java -version)\e[m"
fi

