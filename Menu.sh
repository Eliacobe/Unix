#!/bin/bash
menu()
{
	running= true;
	while $running; do
		echo 
		echo 
		echo $'This is your current directory\n'$(ls)
		echo 
		echo "Press 1 to change repository"
		echo "Press 2 to create a new repository"
		echo "Press 3 to add a file to a repository"
		echo "Press 4 to view the log file"
		echo "Press 5 to edit a file" 
		echo "Press 6 to zip a repository" 
		echo "Press 7 to go back a repository" 
		read -p $'Press 0 if you would like to EXIT the program\n' value
		
		if [ $value -eq 1 ]; then
			changeRepo
			
		elif [ $value -eq 2 ]; then
			createRepo
			
		elif [ $value -eq 3 ]; then
			addFile
			
		elif [ $value -eq 4 ]; then
			viewLog
		
		elif [ $value -eq 5 ]; then
			editFile
		
		elif [ $value -eq 6 ]; then
			zipFile
		
		elif [ $value -eq 7 ]; then
			cd ..
			
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
	echo "A repository '$vName' was created		" $(date) "	" $(whoami) >> /home/vboxuser/Efiles/Project1/LogFile.txt
	echo >> /home/vboxuser/Efiles/Project1/LogFile.txt
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
		echo "A file '$vFile' has been created and saved into '$rep'		" $(date) "	" $(whoami) >> /home/vboxuser/Efiles/Project1/LogFile.txt
		echo >> /home/vboxuser/Efiles/Project1/LogFile.txt
		
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

editFile()
{
	ls
	read -p "Is the file you would like to add in this repository y/n: " anss
	if [ $ans "y" ]; then
		find -type f
		read -p "What is the name of the file: " file
		nano $file
		cd ..
		echo "A file '$vFile' has been edited and saved in '$rep'		" $(date) "	" $(whoami) >> /home/vboxuser/Efiles/Project1/LogFile.txt
		echo >> /home/vboxuser/Efiles/Project1/LogFile.txt
	elif [ $ans = "n" ]; then
		echo */
		read -p "What is the name of the directory: " dir
		cd dir
		find -type f
		read -p "What is the name of the file: " file
		nano $file
		cd ..
		echo "A file '$vFile' has been edited and saved in '$rep'		" $(date) "	" $(whoami) >> /home/vboxuser/Efiles/Project1/LogFile.txt
		echo >> /home/vboxuser/Efiles/Project1/LogFile.txt
	else
		echo "That was not one of the answeres"
	fi		
}

zipFile()
{
	echo */ 
	read -p "Which repository would you like to zip: " zDir
	read -p "What would you like to call your zip folder: " zFolder
	zip -r zFolder zDir
	echo "A folder '$vDir' has been ziped into '$zFolder'		" $(date) "	" $(whoami) >> /home/vboxuser/Efiles/Project1/LogFile.txt
		echo >> /home/vboxuser/Efiles/Project1/LogFile.txt
}

changeRepo()
{
	echo */
	read -p "Which repository woud you like to see: " nRepo
	cd $nRepo
}



menu
