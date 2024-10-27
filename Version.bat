Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the form (window)
$form = New-Object System.Windows.Forms.Form
$form.Text = "Version Information"
$form.Size = New-Object System.Drawing.Size(300,150)
$form.StartPosition = "CenterScreen"

# Create a label to show the version information
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(50, 40)
$label.Size = New-Object System.Drawing.Size(200, 40)
$label.Font = New-Object System.Drawing.Font("Arial", 12)
$label.Text = "Alpha Release Version"
$label.TextAlign = 'MiddleCenter'
$form.Controls.Add($label)

# Create an OK button to close the form
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(100, 80)
$okButton.Size = New-Object System.Drawing.Size(80, 30)
$okButton.Text = "OK"
$okButton.Add_Click({
    $form.Close()
})
$form.Controls.Add($okButton)

# Show the form
$form.Topmost = $true
$form.Add_Shown({ $form.Activate() })
[void]$form.ShowDialog()
