#!/bin/bash

CLASSPATH="lib/gson-2.5.jar:classes"

javac -d classes -cp $CLASSPATH *.java
if [ $? -eq 0 ]
then
  echo "Compilation succeeded"
  java -cp $CLASSPATH RiskServer
else
  echo "Compilation failed"
fi
