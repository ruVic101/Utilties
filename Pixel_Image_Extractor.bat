:Start
title Pixel Image Extractor
@echo off
cls
:GetResponse1
	echo Step 1: copy DCIM\Camera file from phone to Desktop path: C:\Users\%username%\Desktop\Camera .(Y/N)
	set /p id= "Enter Response: "
	if /I "%id%"=="N" (
		echo Exiting Program. Please retry after completing the pre-requisite task of copying DCIM\Camera file from phone to Desktop path: C:\Users\%username%\Desktop\Camera.
		echo Killing application!
		GOTO Kill
	)
	if /I "%id%"=="Y" (
		if exist "C:\Users\%username%\Desktop\pixel_2_out" (
			echo Directory Exists! Deleting directory...
			rd /s /q C:\Users\%username%\Desktop\pixel_2_out
			echo Directory deleted!
		)
			echo Creating Temp Directory pixel_2_out...
			mkdir C:\Users\%username%\Desktop\pixel_2_out
			echo Temp Directory pixel_2_out created.
			echo.
			echo Copying .jpg and .mp4 files from C:\Users\%username%\Desktop\Camera to C:\Users\%username%\Desktop\pixel_2_out
			setlocal EnableDelayedExpansion
			set n=0
			for /r %%f in (*.jpg *.mp4) do set /A n+=1
			echo.
			echo    *********************************
			echo    *  Number of files found: !n!   *
			echo    *********************************
			echo.
			set "bar="
			for /L %%i in (1,1,50) do set "bar=!bar!#"
			set "space="
			for /L %%i in (1,1,70) do set "space=!space!"
			set i=0
			echo Processing files:	
			pushd C:\Users\%username%\Desktop\Camera		
			for /r %%f in (*.jpg *.mp4) do (
				set /A i+=1, percent=i*100/n, barLen=50*percent/100
				for %%a in (!barLen!) do title Pixel Image Extractor !percent!%%  !bar:~0,%%a!%space%
				COPY "%%f" "C:\Users\%username%\Desktop\pixel_2_out\%%~nxf" > nul
			)
			popd
			echo.
			echo    *********************************
			echo    *  !i! files copied             *
			echo    *********************************	
			echo. 		
			echo ******* Files extracted to C:\Users\%username%\Desktop\pixel_2_out *******
			GOTO GetResponse2
	
	) else (
	echo.
	echo !Invalid Input!
	echo.
	GOTO GetResponse1 )
	
:GetResponse2
	title Pixel Image Extractor - Completed
	echo.
	echo Would you like to delete the Camera directory from **Desktop** (Y/N)
	set /p id_2= "Enter Response: "
	if /I "%id_2%"=="Y" (
		echo.
		echo Deleting Camera Directory from Your Desktop...
		rd /s/q C:\Users\%username%\Desktop\Camera
		if exist C:\Users\%username%\Desktop\Camera rd /s /q C:\Users\%username%\Desktop\Camera
		echo.
		echo Camera Directory from Your Desktop has been deleted!
		GOTO End
	) 
	if /I "%id_2%"=="N" (
	echo You chose not to delete Camera directory from your Desktop.
	GOTO End	
	) else (
	echo.
	echo !Invalid Input!
	echo.
	GOTO GetResponse2)
	
:End
echo.
echo Exiting Program...
echo Opening destination directory.
@pause
explorer.exe C:\Users\%username%\Desktop\pixel_2_out
Exit

:Kill
pause
exit
