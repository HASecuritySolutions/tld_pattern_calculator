# Folder in $path should contain the following files
# gtld_list.txt, cctld_list.txt, stld_list.txt, and grtld_list.txt
$path = "C:\Path\To\Where\tld\files\are"
# This is the regex file the script will generate
$pattern_file = "$path\tld_patterns.txt"
if(Test-Path -Path $pattern_file){
    Remove-Item -Force -Path $pattern_file
}
$gtld = Get-Content $path\gtld_list.txt
$gtld_regex = "GTLD "
foreach($record in $gtld){
    $gtld_regex += "$record|"
}
$gtld_regex.Substring(0,$gtld_regex.Length-1) | Out-File $pattern_file -Append -Encoding ascii
$cctld = Get-Content $path\cctld_list.txt
$cctld_regex = "CCTLD "
foreach($record in $cctld){
    $cctld_regex += "$record|"
}
$cctld_regex.Substring(0,$cctld_regex.Length-1) | Out-File $pattern_file -Append -Encoding ascii
$stld = Get-Content $path\stld_list.txt
$stld_regex = "STLD "
foreach($record in $stld){
    $stld_regex += "$record|"
}
$stld_regex.Substring(0,$stld_regex.Length-1) | Out-File $pattern_file -Append -Encoding ascii
$grtld = Get-Content $path\grtld_list.txt
$grtld_regex = "GRTLD "
foreach($record in $grtld){
    $grtld_regex += "$record|"
}
$grtld_regex.Substring(0,$grtld_regex.Length-1) | Out-File $pattern_file -Append -Encoding ascii
'REGISTEREDDOMAIN %{WORD:parent_domain}\.(%{GTLD:gtld}|%{GRTLD:grtld}|%{STTLD:stld})(\.%{CCTLD:cctld})?$'  | Out-File $pattern_file -Append -Encoding ascii