## This script is interactive and gives the user a few different ways to manipulate their file-names and structure
## Note: Errors are not handled after the initial file read 
## Author: isaiahsaucedo


"Let's preprocess your file-names!"

$continue = 1 


Do {

	# Obtain path

	try {
		[string]$dir_name = Read-Host -Prompt "Please enter the full path to the folder containing your files"
		$files = Get-ChildItem $dir_name -ErrorAction Stop}
	catch {
		"Error loading in file. Please be sure the full path is correct."
		 break; 
	}

	# String replacement

	[string]$replace = Read-Host "Would you like to replace a string inside your filename with another string? (Ex: mydata -> data) 
	Enter 'Y' or 'y' for yes"

	If(($replace -eq "Y" ) -or ($replace -eq "y")){
		[string]$old_string = Read-Host "Enter the substring you would like to replace"
		[string]$new_string = Read-Host "Enter the replacement string (leave this field blank if you would just like to remove the string)"		
		$files | Rename-Item -NewName {"$($_.Name)" -replace "$($old_string)", "$($new_string)"}
	}

	# Add extension 

	[string]$add_ext = Read-Host "Would you like to add an extension to your files if it doesn't exist?
	Enter 'Y' or 'y' for yes"

	If(($add_ext -eq "Y" ) -or ($add_ext -eq "y")){
		[string]$new_ext = Read-Host "Enter the extension you would like to have added"	
		$files | Rename-Item -NewName {$_.Name + "$($new_ext)"}
	}


	# Leading number 


	[string]$enum = Read-Host -Prompt "Would you like to add a leading number before the file name? (Ex: \folder\data.csv -> \folder\1_data.csv)
	Enter 'Y' or 'y' for yes"

	If (($enum -eq "Y" ) -or ($enum -eq "y")) {

		for ($i=0; $i -lt $files.Count; $i++) {
		Rename-Item -LiteralPath "$($files[$i].FullName)" -NewName "$($i)_$($files[$i].Name)"
		}
	}

	$continue = 0

	"All done! If there's anything else you'd like this script to provide, feel free to make the request at https://github.com/isaiahsaucedo/preprocess_filenames_with_powershell"
} Until ($continue -eq 0)