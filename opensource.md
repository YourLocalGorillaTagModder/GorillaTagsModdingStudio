This Files Open Sourced!

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the form (window)
$form = New-Object System.Windows.Forms.Form
$form.Text = "DLL Generator"
$form.Size = New-Object System.Drawing.Size(400,200)
$form.StartPosition = "CenterScreen"

# Label for the DLL name input
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(150,20)
$label.Text = "Enter the name of the DLL:"
$form.Controls.Add($label)

# Textbox to input DLL name
$textbox = New-Object System.Windows.Forms.TextBox
$textbox.Location = New-Object System.Drawing.Point(170, 20)
$textbox.Size = New-Object System.Drawing.Size(200,20)
$form.Controls.Add($textbox)

# Button to generate DLL
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(150, 60)
$button.Size = New-Object System.Drawing.Size(100,30)
$button.Text = "Generate DLL"
$form.Controls.Add($button)

# Label to show success or failure
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Location = New-Object System.Drawing.Point(10, 100)
$statusLabel.Size = New-Object System.Drawing.Size(350,20)
$form.Controls.Add($statusLabel)

# Function to compile the C# code into a DLL
$button.Add_Click({
    $dllName = $textbox.Text

    if (-not [string]::IsNullOrWhiteSpace($dllName)) {
        $dllPath = "$dllName.dll"

        # Example C# code to compile
        $csCode = @"
using System;
public class MyMod {
    public static void HelloWorld() {
        Console.WriteLine(""Hello from the DLL!"");
    }
}
"@

        # Path to the temporary source file
        $srcFilePath = "$($env:TEMP)\$dllName.cs"
        $dllOutputPath = "$pwd\$dllPath"

        # Write the C# code to a file
        $csCode | Out-File -FilePath $srcFilePath -Encoding utf8

        # Define the path to csc.exe (C# compiler)
        $cscPath = "$env:WINDIR\Microsoft.NET\Framework\v4.0.30319\csc.exe"

        # Compile the C# file into a DLL
        & $cscPath /target:library /out:$dllOutputPath $srcFilePath

        # Check if DLL was generated
        if (Test-Path $dllOutputPath) {
            $statusLabel.Text = "DLL created successfully: $dllPath"
        } else {
            $statusLabel.Text = "DLL generation failed."
        }
    } else {
        $statusLabel.Text = "Please enter a valid DLL name."
    }
})

# Show the form
$form.Topmost = $true
$form.Add_Shown({ $form.Activate() })
[void]$form.ShowDialog()



@echo off
:: Define paths
setlocal
set CSC_PATH=%WINDIR%\Microsoft.NET\Framework\v4.0.30319\csc.exe
set OUTPUT_DLL=MyMod.dll
set SRC_FILE=MyMod.cs

:: Check if the C# source file exists
if not exist %SRC_FILE% (
    echo Source file %SRC_FILE% not found.
    exit /b 1
)

:: Compile the C# file into a .dll
%CSC_PATH% /target:library /out:%OUTPUT_DLL% %SRC_FILE%

:: Check if the compilation succeeded
if exist %OUTPUT_DLL% (
    echo Compilation successful. DLL generated: %OUTPUT_DLL%
) else (
    echo Compilation failed.
)

pause


Please do Not Pirate my Mod :(
