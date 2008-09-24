My wife had an LG VX5300 and recently got an LG Shine.  We wanted to get her 186 numbers from her old phone into the LG Shine and I couldn't find anyway to do it.

I was able to get the contacts onto her phone using this script.

What I have:
	LG Shine (CU720)
	LG VX5300 
	MacBook Pro with OS X 10.5.5 (ruby & BlueTooth File Exchange Utility)
	BitPim 1.0.7.20080908.ub1 - Test
	
How to use:
	1. Create a vCard file with BitPim (or something else).  
	The script expects the file to have entries formatted like the record below:
		BEGIN:VCARD
		VERSION:2.1
		FN:Michael Bluth
		N:Michael;Bluth;;;
		TEL;TYPE=CELL,PREF:2125556342
		END:VCARD
	2. Execute this script
	
	usage:
		ruby parse_vcards.rb [area code] [vCard File]

	[area code]  	- default area code for numbers without
	[vCard File]	- file path of the vcard file
	
	This will create a folder called "vCards" and write out files for
	each contact in your original file.
	
	3. Pair your phone to your computer then use BlueTooth File Exchange to send all of the vCard files in the "vCards" directory to your phone.
	
KNOWN ISSUES:

1. A space is added to the begining of each name.
' Jeff' instead of 'Jeff'
This puts all imported contacts alphabetically ahead of any other contacts you enter unless you input them with a space first.  There is no space in the vCard files; I don't know why the space shows up on the Shine.

2. The script wasn't written to parse vCard version 3 which is what Apple's Address Book currently exports.

3. I'm lame and didn't write unit tests.
