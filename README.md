# tld_pattern_calculator

This project exists to help genarate regex patterns for SIEMs to break up a domain into proper subcomponents such as **subdomain**, **parent_domain**, and various **tlds**. This aids in analyst searching as well as the application of enrichment techniques.

**First Run:**

To generate a regex pattern you need to run either **generate_tld_regex.ps1** or **generate_tld_regex_from_files.ps1** with **PowerShell**. Examples below:

This command runs the **generate_tld_regex.ps1** script which attempts to pull down online lists of TLDs and directly builds a regex pattern file in a file called **tld_patterns.txt**.

powershell.exe -File C:\users\user\Downloads\tld_pattern_calculator\generate_tld_regex.ps1 -ExecutionPolicy Bypass

This command runs the **generate_tld_regex_from_files.ps1** script which attempts to read text files containing TLDs and then builds a regex pattern file in a file called **tld_patterns.txt**. You must have the TLD files saved before this will work. This GitHub repo comes with TLD files although they are not updated.

powershell.exe -File C:\users\user\Downloads\tld_pattern_calculator\generate_tld_regex_from_files.ps1 -ExecutionPolicy Bypass
