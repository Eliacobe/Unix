#!/bin/bash
menu()
{
	running= true;
	while $running; do
	
		echo "Press 1 if you would you like create a new repository"
		echo "Press 2 if you would like to add a file to a repository"
		echo "Press 3 if you would like to view the log file" 
		read -p $'Press 0 if you would like to EXIT the program\n' value
		
		if [ $value -eq 1 ]; then
			createRepo
			
		elif [ $value -eq 2 ]; then
			addFile
			
		elif [ $value -eq 3 ]; then
			viewLog
			
		elif [ $value -eq 0 ]; then
			running= false
			break
			
		fi
		
	done
}

createRepo()
{
	read -p "What name would you like to call this repository: " vName
	mkdir "$vName"
	echo "A repository '$vName' was created		" $(date) >> LogFile.txt
	echo >> LogFile.txt
}

addFile()
{
	read -p "What do you want to call this file: " vFile
	echo "These are the available repositories for your file"
	echo */
	read -p "What repository would you like to add this file to: " rep
	if [ -d "$rep" ]; then
		cd $rep
		echo > "$vFile".txt
		cd ..
		echo "A file '$vFile' has been created and saved into '$rep'		" $(date) >> LogFile.txt
		echo >> LogFile.txt
		
	else
		read -p "This repository does not exist would you like to create one y/n: " ans
		if [ $ans "y" ]; then
			createRepo
		elif [ $ans = "n" ]; then
			break
		else
			echo "That was not one of the answeres"
		fi
	fi
}

viewLog()
{
	cat LogFile.txt
}




menu

