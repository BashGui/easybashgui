#!/usr/bin/env bash
#
#########################
#
# Copyright (C) 2011 Vittorio Cagnetta
#
# Author: Vittorio Cagnetta <vaisarger@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 3 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with this program, 
# called, in this distribution, "EasyBashGUI-license"; if not, write to the 
# Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
#
#########################
#
source easybashgui
#
LIB_CHECK="$(type "easybashgui" 2> /dev/null )"
[ ${#LIB_CHECK} -eq 0 ] && echo -e "\n\n\n\nYou need to copy \"easybashgui\" in your path ( e.g.: \"cp easybashgui_X.X.X /usr/local/bin/\" )...\n:(\n\n\n\n" 1>&2 && exit 1
#
##
#
##################
show()
	{
	message "You chose/wrote: \n\n \"$(cat "${dir_tmp}/${file_tmp}" )\" \n\n ;-)" 
	}
##################
#
##
#
# ... "x" is the function name...
#
##
#
x=message,ok_message,alert_message
	{
	x=message
	${x} "This is a test \"<${x}>\" function...\n;-)"
	#
	x="ok_message --width 700 --height 300"
	[ "${mode}" = "kdialog" ] && message "Now let's try to change \n window size... \n\n Next function: \"<${x}>\" ... \n\n ( Note: for kdialog messages, \n - due to a known kdialog bug - \n setting a different geometry \n makes it ONLY fit to box text !! )" || \
	message "Now let's try to change \n window size... \n\n Next function: \"<${x}>\" ..."
	${x} "This is a test \"<${x}>\" function, \n with custom size... \n ;-)"
	#
	x="alert_message --height 700 --width 300"
	[ "${mode}" = "kdialog" ] && message "Now let's try to change \n window size... \n\n Next function: \"<${x}>\" ... \n\n ( Note: for kdialog messages, \n - due to a known kdialog bug - \n setting a different geometry \n makes it ONLY fit to box text !! )" || \
	message "Now let's try to change \n window size... \n\n Next function: \"<${x}>\" ..."
	${x} "This is a test \"<${x}>\" function, \n with custom size... \n ;-)"
	}
#
##
#
x=text
	{
	file="/etc/passwd"
	message "Next function: \"head -n 10 ${file} | ${x} -w 600 -h 600\" ..."
	head -n 10 ${file} | ${x} -w 600 -h 600 ; show
	}
#
##
#
x=question
	{
	while :
		do
		${x} "This is a test \"<${x}>\" function (1)... \n Please click \"Cancel\", now ..."
		answer="${?}"
		if [ ${answer} -eq 0 ]
			then
			continue
		elif [ ${answer} -eq 1 ]
			then
			break
		else
			exit
		fi
	done
	while :
		do
		${x} "This is a test \"<${x}>\" function (2)... \n Please click \"Ok\", this time ..."
		answer="${?}"
		if [ ${answer} -eq 0 ]
			then
			break
		elif [ ${answer} -eq 1 ]
			then
			continue
		else
			exit
		fi
	done
	}
#
##
#
x=wait_seconds
	{
	message "Next function: \"<${x} 5>\" ..."
	${x} 5
	}
#
##
#
x=wait_for
	{
	message "Next function: \"<${x}>\" ..."
	${x} "This is a test ${x} function (command: sleep 5) \n + \n terminate_wait_for \n\n ;-)"
	sleep 5
	terminate_wait_for
	}
#
##
#
x=fselect,dselect
	{
	for x in fselect dselect
		do
		message "Next function: \"<${x}>\" ..."
		${x} ; show
	done
	}
#
##
#
x=input
	{
	message "Next function: \"<${x} 1>\" ..."
	${x} 1 "(please write here)" ; show
	#
	message "Next function: \"<${x} 2>\" ..."
	${x} 2 "First name" "Jimi" "Surname" "Hendrix" ; show
	#
	message "Next function: \"<${x} 3>\" ..."
	${x} 3 "Artist" "Albert King" "Genre" "Blues" "Album" "The Big Blues" ; show
	}
#
##
#
x=menu
	{
	x="menu -w 650 -h 550"
	message "Next function: \"<${x}>\" ..."
	${x} "Country Music" "Blues" "Rock And Roll" "Pop" ; show
	}
#
##
#
x=list
	{
	message "Next function: \"<${x}>\" ... \n ( it differs from \"menu\" for multi-choice possibility )"
	list -"Country Music" +"Blues" +"Rock And Roll" -"Pop" ; show
	}
#
##
#
x=progress
	{
	x="progress -w 600"
	message "Next function: \"${x}\" with \"custom\" width ( \"-w\" ) \n (old style with \n percent integer -with or without '%'- \n in STDIN)..."
	for i in 10 20.30 32 40.50 50 60.50 70.45 80.90 85 93 100; do echo "${i}"; sleep 1 ; done | ${x} "This is a test \"<${x}>\" function \n (old style with percent in STDIN)... \n\n ;-)"
	#
	x="progress --width 400 --height 200"
	message "Next function: \"${x}\" with \"custom\" width and height \n ( \"--width\" \"--height\" ) \n (new style with \n \"PROGRESS\" string \n in STDIN)..."
	for i in 10 20.30 32 40.50 50 60.50 70.45 80.90 85 93 100; do echo "PROGRESS" ; sleep 1 ; done | ${x} "This is a test \"<${x}>\" function \n (new style with \"PROGRESS\" string in STDIN)... \n\n ;-)" 11
	}
#
##
#
x=adjust
	{
	message "Next function: \"<${x} 'Please adjust level...' 100 200 300>\" ..."
	${x} 'Please adjust level...' 100 200 300 ; show
	}
#
##
#
ok_message "Tour is finished. :-) \n Click now to see with your eyes \n how easy is programming with ${LIB_NAME}..."
#
##
#
# This is *short* and *nice* :
cat "${0}" | text -w 800 -h 600
#
sleep 3 && clean_temp



