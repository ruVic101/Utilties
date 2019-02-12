:Start
title Pixel Image Extractor
@echo off
cls
:GetResponse1
	echo Step 1: Do you have both Camera folder and this batch file inside the same folder? (Y/N)
	set /p id= "Enter Response: "
	if /I "%id%"=="N" (
		echo Exiting Program. Please put the folder Camera and this batch file in 1 folder and Re-run.
		echo Killing application!
		GOTO Kill
	)
	if /I "%id%"=="Y" (
		if exist "%CD%\pixel_2_out" (
			echo Directory Exists! Deleting directory...
			rd /s /q %CD%\pixel_2_out
			echo Directory deleted!
		)
			echo Creating Ouput Directory pixel_2_out...
			mkdir %CD%\pixel_2_out
			echo Ouput Directory pixel_2_out created.
			echo.
			echo Copying .jpg and .mp4 files from %CD%\Camera to %CD%\pixel_2_out
			setlocal EnableDelayedExpansion
			set n=0
			for /r %CD%\Camera %%f in (*.jpg *.mp4) do set /A n+=1
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
			pushd %CD%\Camera		
			for /r %%f in (*.jpg *.mp4) do (
				set /A i+=1, percent=i*100/n, barLen=50*percent/100
				for %%a in (!barLen!) do title Pixel Image Extractor !percent!%%  !bar:~0,%%a!%space%
				COPY "%%f" "%CD%\pixel_2_out\%%~nxf" > nul
			)
			popd
			echo.
			echo    *********************************
			echo    *  !i! files copied             *
			echo    *********************************	
			echo. 		
			echo ******* Files extracted to %CD%\pixel_2_out *******
			set /A n_after=0
			set /A i_after=0
			for /r %CD%\Camera %%f in (*.jpg *.mp4) do set /A n_after+=1
			for /r %CD%\pixel_2_out %%f in (*.jpg *.mp4) do set /A i_after+=1
			echo files in Source = !n_after!, files in destination = !i_after!
			set /A remaining_files=!n_after!-!i_after!
			echo ------- Matching number of files copied. ----------
			if /A %remaining_files%==0 (
			echo  ----------!remaining_files! files could not be copied. ----------
			) else ( echo ------- All files copied SUCCESSFULLY. ---------- 
			)
			GOTO GetResponse2
	
	) else (
	echo.
	echo !Invalid Input!
	echo.
	GOTO GetResponse1 )
	
:GetResponse2
	title Pixel Image Extractor - Completed
	echo.
	echo Would you like to delete the Camera directory (Y/N)
	set /p id_2= "Enter Response: "
	if /I "%id_2%"=="Y" (
		echo.
		echo Deleting the Camera Directory...
		rd /s/q %CD%\Camera
		if exist %CD%\Camera rd /s /q %CD%\Camera
		echo.
		echo Camera Directory has been deleted!
		GOTO End
	) 
	if /I "%id_2%"=="N" (
	echo You chose not to delete the Camera directory.
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
explorer.exe %CD%\pixel_2_out
Exit

:Kill
pause
exit
