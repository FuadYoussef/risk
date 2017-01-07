set CLASSPATH="lib/gson-2.5.jar;classes"

del RiskServer.class
javac -d classes -cp %CLASSPATH% *.java
java -cp %CLASSPATH% RiskServer
