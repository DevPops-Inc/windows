# looking forward to working together 

# define $colors list and foreach loop
$colors = 'Red', 'Yellow', 'Green', 'Blue'

Foreach ($color in $colors)
{
    Write-Host -Foregroundcolor $color "Looking forward to working together!"
    Start-Sleep -s 1
}
