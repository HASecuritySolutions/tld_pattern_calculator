# Set $path to the folder you want the tld_patterns.txt file to generate in
$path = "C:\Users\jhend\Downloads\tld_pattern_calculator-master\tld_pattern_calculator-master"
# Set this to the site that contains the list of tlds
# If you change the site you may need to rename fields
$site = "https://tld-list.com/df/tld-list-details.csv"
# Do you want puny code tlds to be enabled? If so set to 1
# I do not recommend grabbing punycode as systems may struggle
# with the special character sets
$punycode = 0

# Do not change the rest of this script unless you know what you are doing
$gtld = @()
$cctld = @()
$stld = @()
$grtld = @()
$output = (Invoke-WebRequest -Uri $site).Content | ConvertFrom-Csv 
$output | ForEach-Object {
    if($punycode -eq 1){
        if ($_.Type -eq "gTLD") { $gtld += $_.TLD }
        if ($_.Type -eq "ccTLD") { $cctld += $_.TLD }
        if ($_.Type -eq "sTLD") { $stld += $_.TLD }
        if ($_.Type -eq "grTLD") { $grtld += $_.TLD }
    } else {
        if($_.Punycode -eq ""){
            if ($_.Type -eq "gTLD") { $gtld += $_.TLD }
            if ($_.Type -eq "ccTLD") { $cctld += $_.TLD }
            if ($_.Type -eq "sTLD") { $stld += $_.TLD }
            if ($_.Type -eq "grTLD") { $grtld += $_.TLD }
        }
    }
}
# This is the regex file the script will generate
$pattern_file = "$path\tld_patterns.txt"
if(Test-Path -Path $pattern_file){
    Remove-Item -Force -Path $pattern_file
}

$gtld_regex = "GTLD "
foreach($record in $gtld){
    $gtld_regex += "$record|"
}
$gtld_regex.Substring(0,$gtld_regex.Length-1) | Out-File $pattern_file -Append -Encoding ascii

$cctld_regex = "CCTLD "
foreach($record in $cctld){
    $cctld_regex += "$record|"
}
$cctld_regex.Substring(0,$cctld_regex.Length-1) | Out-File $pattern_file -Append -Encoding ascii

$stld_regex = "STLD "
foreach($record in $stld){
    $stld_regex += "$record|"
}
$stld_regex.Substring(0,$stld_regex.Length-1) | Out-File $pattern_file -Append -Encoding ascii

$grtld_regex = "GRTLD "
foreach($record in $grtld){
    $grtld_regex += "$record|"
}
$grtld_regex.Substring(0,$grtld_regex.Length-1) | Out-File $pattern_file -Append -Encoding ascii
'TOPLEVEL (%{GTLD:[dns][question][gtld]}|%{GRTLD:[dns][question][grtld]}|%{STTLD:[dns][question][sttld]})(\.%{CCTLD:[dns][question][cctld]})?$' | Out-File $pattern_file -Append -Encoding ascii
'REGISTEREDDOMAIN %{WORD:[dns][question][parent_domain]}\.%{TOPLEVEL:[dns][question][top_level_domain]}' | Out-File $pattern_file -Append -Encoding ascii
'DNSQUERY (%{DATA:[dns][question][subdomain]}\.)?%{REGISTEREDDOMAIN:[dns][question][registered_domain]}' | Out-File $pattern_file -Append -Encoding ascii
